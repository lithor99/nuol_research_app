import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ViewBookFile extends StatefulWidget {
  final String bookId;
  final String bookName;
  final String bookUrl;
  ViewBookFile(this.bookId, this.bookName, this.bookUrl);
  @override
  _ViewBookFileState createState() => _ViewBookFileState();
}

class _ViewBookFileState extends State<ViewBookFile> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Future<void> addView(String bookId) async {
    try {
      final url = 'http://192.168.43.191:9000/book/add_view';
      Map body = {'book_id': bookId};
      await http.put(Uri.parse(url), body: body);
    } catch (e) {
      print('view book file error:' + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bookName,
          style: TextStyle(fontFamily: 'NotoSans', fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        widget.bookUrl,
        key: _pdfViewerKey,
        onDocumentLoaded: (value) async {
          await addView(widget.bookId);
        },
      ),
    );
  }
}
