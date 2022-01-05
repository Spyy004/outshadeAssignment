import 'package:flutter/material.dart';
import 'package:outshadeassignment/Models/user_status_model.dart';
import 'package:provider/provider.dart';

import 'Screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: UserStatus())],
      child: MaterialApp(home: FirstPage()),
    );
  }
}
