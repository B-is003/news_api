import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {

  final String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer=
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Top", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
            )),
            Text("Tech",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue
            ),),
    Text("Lines",style: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.yellow)
    )
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          )

        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
