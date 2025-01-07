import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class PdfView extends StatefulWidget {
  const PdfView({super.key});

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    final ByteData data = await rootBundle.load('images/hbomax.pdf');
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/hbomax.pdf');
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visor de PDF'),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath!,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}


