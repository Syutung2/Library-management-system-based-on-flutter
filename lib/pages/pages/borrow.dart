import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/internet/Toast.dart';
import 'package:demo01/pages/pages/pages/BookList.dart';
import 'package:demo01/pages/pages/pages/BorrowList%20copy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorrowpageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BorrowpageWidgetState();
  }
}

class BorrowTools {
  static Future<String> _mycount(String username) async {
    try {
      Response response = await Dio()
          .get('http://bbs.we-chat.cn/apis/count.php?username=$username');
      String userMap = response.toString();
      print(userMap);
      return userMap;
    } catch (e) {
      return "0";
    }
  }

  static bool BorrowJieyue() {
    var books = [10, 10, 10, 3, 0];
    int r = 0;
    _mycount(GlobalNumbers.name).then((value) {
      r = int.parse(value);
    });
    int q = int.parse(GlobalNumbers.quanxian);
    if (GlobalNumbers.quanxian == "5") {
      return false;
    } else {
      if (r <= books[q - 1]) {
        return true;
      } else {
        return false;
      }
    }
  }
}

class BorrowpageWidgetState extends State<BorrowpageWidget> {
  int count = 0;
  var books = [10, 10, 10, 3, 0];
  double r = 0.0;
  String getUser(String quanxian, String muqian) {
    int q = int.parse(quanxian);
    int muqianw = int.parse(muqian);
    return "${books[q - 1] - muqianw}";
  }

  //root
  //
  String getQuanxianzu(String quanxian) {
    int q = int.parse(quanxian);
    return GlobalNumbers.quanxian1[q];
  }

  Future<String> _mycount(String username) async {
    try {
      Response response = await Dio()
          .get('http://bbs.we-chat.cn/apis/count.php?username=$username');
      String userMap = response.toString();
      print(userMap);
      return userMap;
    } catch (e) {
      return "0";
    }
  }

  Widget getInformation(String b) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "欢迎来到iFultter借阅中心\n您已借阅$b本书",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    child: Text(GlobalNumbers.name.split('')[0],
                        style: TextStyle(fontSize: 60)),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(45.0))),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  height: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: r,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueGrey[600]),
                      backgroundColor: Colors.blue,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget getGlobl() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Container(
        height: 85,
        margin: EdgeInsets.all(5),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
                onPressed: () {
                  //BorrowListWidget
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => BorrowListWidget()));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.library_books,
                        color: Colors.blue,
                      ),
                      Text(
                        "借书申请",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )),
            FlatButton(
                onPressed: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.library_add,
                        color: Colors.blue,
                      ),
                      Text(
                        "求上架",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => BookListWidget()));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.blue,
                      ),
                      Text(
                        "图书总览",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (GlobalNumbers.username == "" && GlobalNumbers.password == "") {
      return FutureBuilder<String>(
        future: _mycount(GlobalNumbers.username),
        builder: (context, snapshot) {
          GlobalNumbers.name = "游客";
          if (snapshot.connectionState == ConnectionState.done) {
            String b = snapshot.data;
            print(snapshot.data);
            r = 0;

            return SingleChildScrollView(
                child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    //swidth: 300,
                    height: 300,
                    margin: EdgeInsets.all(6),
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "借 阅 中 心",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  getInformation(b),
                  getGlobl(),
                ],
              ),
            ));
          } else {
            // 请求未结束，显示loading
            return Center(
              child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 80,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                          backgroundColor: Colors.greenAccent[200],
                        ),
                      ),
                      Text(
                        "加载中",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  )),
            );
          }
        },
      );
    } else {
      return FutureBuilder<String>(
        future: _mycount(GlobalNumbers.username),
        builder: (context, snapshot) {
          print(GlobalNumbers.user);
          if (snapshot.connectionState == ConnectionState.done) {
            String b = snapshot.data;
            print(snapshot.data);
            if (GlobalNumbers.quanxian == "5") {
              r = 0;
            } else {
              r = int.parse(b) / books[int.parse(GlobalNumbers.quanxian) - 1];
            }

            if (GlobalNumbers.quanxian == "1") {
              return SingleChildScrollView(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      //swidth: 300,
                      height: 300,
                      margin: EdgeInsets.all(6),
                      decoration: new BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "借 阅 中 心",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    getInformation(b),
                    getGlobl(),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Container(
                        height: 85,
                        margin: EdgeInsets.all(5),
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                                onPressed: () {},
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.network_wifi,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "预约管理",
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                )),
                            FlatButton(
                                onPressed: () {},
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.library_books,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "线下借书后台",
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                )),
                            FlatButton(
                                onPressed: () {},
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.library_add,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "求上架审核",
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
            } else {
              return SingleChildScrollView(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      //swidth: 300,
                      height: 300,
                      margin: EdgeInsets.all(6),
                      decoration: new BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "借 阅 中 心",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    getInformation(b),
                    getGlobl(),
                  ],
                ),
              ));
            }
          } else {
            // 请求未结束，显示loading
            return Center(
              child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 80,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                          backgroundColor: Colors.greenAccent[200],
                        ),
                      ),
                      Text(
                        "加载中",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  )),
            );
          }
        },
      );
    }
  }

  void addButtonClick() {
    setState(() {
      count++;
    });
  }
}
