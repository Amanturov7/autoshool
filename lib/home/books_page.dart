import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BooksPage extends StatefulWidget {
  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<Map<String, String>> pdfList = [];
  final String apiUrl = 'https://example.com/api/pdf_list'; // Replace with your API endpoint
  Map<String, double> downloadProgress = {};
  Map<String, int> fileSize = {};
  Map<String, bool> downloadCompleted = {};

  @override
  void initState() {
    super.initState();
    fetchPdfList();
  }

  Future<void> fetchPdfList() async {
    try {
      // Mock JSON data for demonstration
      String responseBody = '''
      [
        {
          "title": "Sample PDF 1",
          "url": "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf",
          "image": "https://www.pngmart.com/files/6/Telephone-PNG-Picture.png"
        },
        {
          "title": "Тесты пдд",
          "url": "http://xn--110-5cdal0dizb5bze.xn--p1ai/images/bilet.pdf",
          "image": "https://pdd.auto-cargo.com/plan/thumbs/p-1.jpg"
        },
        {
          "title": "Sample PDF 2",
          "url": "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf",
          "image": "https://www.pngmart.com/files/6/Telephone-PNG-Picture.png"
        },
        {
          "title": "school 1-2",
          "url": "https://school-8-asb.ucoz.ru/zdor_bezop/bezop_dor_dvizh/Test_po_PDD_dlya_1-2_klassa.pdf",
          "image": "https://image.slidesharecdn.com/random-140831171904-phpapp01/75/-1-2048.jpg"
        }
      ]
      ''';

      List<dynamic> data = jsonDecode(responseBody);

      List<Map<String, String>> fetchedList = data.map((item) {
        return {
          'title': item['title'] as String,
          'url': item['url'] as String,
          'image': item['image'] as String
        };
      }).toList();

      setState(() {
        pdfList = fetchedList;
      });
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch PDF list.'),
      ));
    }
  }

  Future<void> _openPdf(String title, String url) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/${title}.pdf';
      File file = File(filePath);

      if (await file.exists()) {
        // File exists, open it
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerScreen(filePath: filePath),
          ),
        );
      } else {
        // File doesn't exist, download and save
        print('Downloading PDF from URL: $url');
        final request = http.Request('GET', Uri.parse(url));
        final response = await request.send();
        
        final totalBytes = response.contentLength ?? 0;
        final file = File(filePath);
        final sink = file.openWrite();

        int downloadedBytes = 0;

        response.stream.listen(
          (chunk) {
            downloadedBytes += chunk.length;
            sink.add(chunk);
            setState(() {
              downloadProgress[title] = downloadedBytes / totalBytes;
              fileSize[title] = totalBytes;
            });
          },
          onDone: () async {
            await sink.flush();
            await sink.close();
            setState(() {
              downloadProgress[title] = 1.0; // Mark as complete
              downloadCompleted[title] = true;
            });
            print('File downloaded and saved successfully at $filePath');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewerScreen(filePath: filePath),
              ),
            );
          },
          onError: (error) {
            print('Error downloading PDF: $error');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Failed to download PDF.'),
            ));
          },
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to open PDF.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books Page'),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[700]!
                : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      body: pdfList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pdfList.length,
              itemBuilder: (context, index) {
                final pdf = pdfList[index];
                final title = pdf['title']!;
                final progress = downloadProgress[title] ?? 0.0;
                final size = fileSize[title] ?? 0;
                final isCompleted = downloadCompleted[title] ?? false;

                return ListTile(
                  leading: pdf['image'] != null
                      ? Image.network(pdf['image']!)
                      : Icon(Icons.picture_as_pdf),
                  title: Text(pdf['title']!),
                  subtitle: isCompleted
                      ? null
                      : LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                        ),
                  trailing: isCompleted
                      ? Text('${size ~/ 1024} KB')
                      : Text(
                          progress > 0
                              ? '${(progress * 100).toStringAsFixed(0)}%'
                              : 'Download',
                        ),
                  onTap: () {
                    if (isCompleted) {
                      _openPdf(title, pdf['url']!);
                    } else {
                      _openPdf(title, pdf['url']!);
                    }
                  },
                );
              },
            ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  PdfViewerScreen({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.file(
        File(filePath),
        onDocumentLoadFailed: (e) => Center(child: Text('Failed to load PDF')),
      ),
    );
  }
}
