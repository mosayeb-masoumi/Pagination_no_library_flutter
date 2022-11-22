import 'package:flutter/material.dart';
import 'package:tesssst/home_page.dart';
import 'package:tesssst/static_another_method_pagination_page.dart';
import 'package:tesssst/static_data_pagin.dart';

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

        primarySwatch: Colors.blue,
      ),
      // home:  HomePage(),
      home:  StaticDataPaginationPage(),
      // home:  StaticAnotherMethodPaginationPage(),
    );
  }
}



