import 'package:flutter/material.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("My Calendar Page"),
      ),
    );
  }
}
