import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPDF extends StatefulWidget {
  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  // @override
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຊື່ບົດຄົ້ນຄວ້າ'),
        centerTitle: true,
      ),
      body: SfPdfViewer.asset(
        'files/real_proposal.pdf',
        key: _pdfViewerKey,
      ),
      //     SfPdfViewer.network(
      //   // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      //   key: _pdfViewerKey,
      // ),
    );
  }
}
