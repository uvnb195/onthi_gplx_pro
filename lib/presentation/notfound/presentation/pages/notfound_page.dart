import 'package:flutter/material.dart';

class NotfoundPage extends StatelessWidget {
  const NotfoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("404! Not found."))),
    );
  }
}
