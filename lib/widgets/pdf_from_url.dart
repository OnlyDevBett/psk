import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerFromUrl extends StatelessWidget {
   PDFViewerFromUrl({Key key, @required this.url }) : super(key: key);

   String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Document"),
        centerTitle: true,
      ),
      body: const PDF(
          nightMode: false,
          defaultPage: 2,
          fitPolicy: FitPolicy.BOTH,
          pageFling: true)
          .fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),

        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key key, @required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached PDF From Url'),
      ),
      body: const PDF(nightMode: true, swipeHorizontal: true).cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}