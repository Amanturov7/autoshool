import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  List<int>? _documentBytes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () async {
              if (_documentBytes!.isNotEmpty) {
                try {
                  Directory directory = await getTemporaryDirectory();
                  String path = directory.path;
                  File file = File('$path/sample.pdf');
                  await file.writeAsBytes(_documentBytes!, flush: true);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Document downloaded and saved successfully.'),
                  ));
                } catch (e) {
                  print('Error saving document: $e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to save document.'),
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Document not loaded yet.'),
                ));
              }
            },
          ),
        ],
      ),
      body: SfPdfViewer.asset(
        'assets/pdf/sample.pdf',
        key: _pdfViewerKey,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          setState(() {
            _documentBytes = details.document.saveSync();
          });
        },
      ),
    );
  }
}
