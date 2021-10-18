// @dart=2.9

import 'package:app_diet/screens/root/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_diet/states/current_user.dart';
import 'package:app_diet/screens/login/login.dart';
import 'package:app_diet/utils/our_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home: const OurRoot(),
      ),
    );
  }
}
