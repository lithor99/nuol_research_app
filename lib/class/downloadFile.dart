import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

int progress = 0;
ReceivePort receivePort = ReceivePort();

class DownloadBookFile {
  static Future<void> addDownload(String bookId) async {
    try {
      final url = 'http://192.168.43.191:9000/book/add_download';
      Map body = {'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print('add download total error:' + e.toString());
    }
  }

  static Future<void> downloadBookFile(
    String bookId,
    String fileUrl,
    String fileName,
  ) async {
    try {
      await addDownload(bookId);
      final status = await Permission.storage.request();
      if (status.isGranted) {
        var path = await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
        if (await File(path + '/$fileName' + '.pdf').exists()) {
          DateTime now = DateTime.now();
          String timeNow = DateFormat('hh:mm:ss').format(now);
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
        // await addDownloadTotal(bookId);
      } else {
        print('no permission');
      }
    } catch (e) {}
  }

  static downloadCallback(id, status, progress) {
    if (status == DownloadTaskStatus.complete) {
      print('.....download complete.....');
      SendPort sendPort =
          IsolateNameServer.lookupPortByName('Downloading File');
      sendPort.send(progress);
    } else if (status == DownloadTaskStatus.failed) {
      print('.....download failed.....');
    }
  }

  // static void showDownloadProgress(received, total) {
  //   if (total != -1) {
  //     print((received / total * 100).toStringAsFixed(0) + '%');
  //   }
  // }

  // static Future<void> downloadFile(
  //     String bookId, String fileUrl, String fileName) async {
  //   try {
  //     var dio = Dio();
  //     final status = await Permission.storage.request();
  //     if (status.isGranted) {
  //       Response response = await dio.get(
  //         fileUrl,
  //         onReceiveProgress: showDownloadProgress,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: true,
  //           validateStatus: (status) {
  //             return status < 500;
  //           },
  //         ),
  //       );
  //       var path = await ExtStorage.getExternalStoragePublicDirectory(
  //           ExtStorage.DIRECTORY_DOWNLOADS);
  //       print('path:::::' + path.toString());
  //       File file = File(path + '/$fileName' + '.pdf');
  //       var raf = file.openSync(mode: FileMode.write);
  //       raf.writeFromSync(response.data);
  //       await raf.close();
  //       await addDownloadTotal(bookId);
  //     } else {
  //       print('no permission');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
