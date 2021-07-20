import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

int progress = 0;
ReceivePort receivePort = ReceivePort();

class DownloadBookFile {
  static Future<void> addDownload(String bookId) async {
    try {
      final url = serverName + '/book/add_download';
      Map body = {'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
      print('...........added download...........');
    } catch (e) {
      print('add download total error:' + e.toString());
    }
  }

//////////////////////// download file use flutter_downloader ////////////////////
  static Future<void> downloadBookFile(
    String bookId,
    String fileUrl,
    String fileName,
  ) async {
    try {
      await addDownload(bookId);
      var path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      print('path location:' + path.toString());
      if (await File(path + '/$fileName' + '.pdf').exists()) {
        DateTime now = DateTime.now();
        String timeNow = (DateFormat('hh:mm:ss').format(now)).toString();
        await FlutterDownloader.enqueue(
          url: fileUrl,
          savedDir: path,
          fileName: fileName + '_' + timeNow + '.pdf',
          openFileFromNotification: true,
          showNotification: true,
        );
      } else {
        await FlutterDownloader.enqueue(
          url: fileUrl,
          savedDir: path,
          fileName: fileName + '.pdf',
          openFileFromNotification: true,
          showNotification: true,
        );
      }
    } catch (e) {}
  }

  static downloadCallback(String id, DownloadTaskStatus status, int progress) {
    if (status == DownloadTaskStatus.complete) {
      print('...........download complete...........');
      SendPort sendPort =
          IsolateNameServer.lookupPortByName('Downloading File');
      sendPort.send(progress);
    } else if (status == DownloadTaskStatus.failed) {
      print('...........download failed...........');
    }
  }

///////////////////////// download file use dio /////////////////////////////////////////////////////
  static void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  static Future<void> downloadFile(
      String bookId, String fileUrl, String fileName) async {
    try {
      var dio = Dio();
      var path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      Response response = await dio.get(
        fileUrl,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      final status = await Permission.storage.request();
      if (status.isGranted) {
        if (await File(path + '/$fileName' + '.pdf').exists()) {
          DateTime now = DateTime.now();
          String timeNow = DateFormat('hh:mm:ss').format(now);
          File file = File(path + '/$fileName' + '_' + timeNow + '.pdf');
          var raf = file.openSync(mode: FileMode.write);
          raf.writeFromSync(response.data);
          await raf.close();
          await addDownload(bookId);
        } else {
          File file = File(path + '/$fileName' + '.pdf');
          var raf = file.openSync(mode: FileMode.write);
          raf.writeFromSync(response.data);
          await raf.close();
          await addDownload(bookId);
        }
      } else {
        print('no permission');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
