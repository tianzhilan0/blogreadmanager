/*
 * @Descripttion: 
 * @version: 
 * @Author: lichuang
 * @Date: 2020-11-05 15:23:54
 * @LastEditors: lichuang
 * @LastEditTime: 2020-12-21 13:50:53
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _urlStart = "https://blog.csdn.net/tianzhilan0/article/details/";
  var _readIDs = [
    "111473346",
    "109726374",
    "109531873",
    //
    "109381929",
    "109352730",
    "109337169",
    "108519768",
    "108492697",
    //
    "108278021",
    "108239316",
    "108145569",
    "108126161",
    "108123767",
    //
    "108075305",
    "108053941",
    "108053847",
    "107867713",
    "107840221",
    //
    "107692508",
    "107638462",
    "107638441",
    "107638347",
    "107638206",
    //
    "107637775",
    "107634468",
    "107634445",
    "107634423",
    "107634410",
    //
    "107634330",
    "107634318",
    "107634301",
    "107632320",
    "107632290",
    //
    "107632144"
  ];

  var _isCanRead = false;

  var _currentIndex = 0;
  var _webURL = "";
  var _pageState = 0; // 0 默认状态 1 开始 2 结束

  var _number = 0;
  var _timeInterval = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文章阅读器"),
        actions: [FlatButton(onPressed: null, child: Text("$_number 次"))],
      ),
      body: Container(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: _childView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 50,
      child: Row(
        children: [
          FlatButton(
              onPressed: () {
                _isCanRead = true;
                _currentIndex = 0;
                _number = 0;
                print("==> 程序开始");
                _starRead();
              },
              child: Text("开始")),
          FlatButton(
              onPressed: () {
                _isCanRead = false;
              },
              child: Text("结束")),
        ],
      ),
    );
  }

  Widget _childView() {
    if (_pageState == 0) {
      return Container();
    }

    return Container(
        child: Stack(children: [
      WebView(
        initialUrl: _webURL,
        onPageStarted: (String url) {
          print("==> webview 开始加载");
          print("==> webview 加载中...");
        },
        onPageFinished: (String url) {
          print("==> webview 加载结束");
          setState(() {
            _number = _number + 1;
            _pageState = 2;
          });
          Future.delayed(Duration(milliseconds: _timeInterval)).then((value) {
            _currentIndex++;
            _starRead();
          });
        },
      ),
      Offstage(
        offstage: _pageState == 1 ? false : true,
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    ]));
  }

  _starRead() {
    if (!_isCanRead) {
      print("==> 程序结束");
      _pageState = 0;
      setState(() {});
      return;
    }

    if (_currentIndex > _readIDs.length - 1) {
      _currentIndex = 0;
    }
    _webURL = _urlStart + _readIDs[_currentIndex];
    setState(() {
      _pageState = 0;
    });
    print("==> _currentIndex == $_currentIndex  _number == $_number");

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        _pageState = 1;
      });
    });
  }
}
