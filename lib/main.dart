import 'package:bytebank/screens/contato/contacts_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.purple,
        brightness: Brightness.dark,
        useMaterial3: true,
        // primaryColor: Colors.green[900],
      ),
      home: ContactsList(),
    );
  }
}


