import 'package:flutter/material.dart';
import 'read.dart';
import 'list.dart';
import 'writeform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/list", //첫 페이지(기본 화면) 선택
      routes: {
        //맵 키:값
        "/read": (context) => ReadPage(), //클래스명 부르는 생성자
        "/list": (context) => ListPage(),
        "/write": (context) => WriteForm(),
      },
    );
  }
}
