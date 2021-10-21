import 'package:app_diet/screens/nogroup/no_group.dart';
import 'package:app_diet/screens/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_diet/screens/home/home.dart';
import 'package:app_diet/screens/login/login.dart';
import 'package:app_diet/states/current_user.dart';

enum AuthStatus {
  unknow,
  notLoggedIn,
  notInGroup,
  inGroup,
}

class OurRoot extends StatefulWidget {
  const OurRoot({Key? key}) : super(key: key);

  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknow;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "success") {
      if (_currentUser.getCurrentUser.groupId != "") {
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknow:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = Login();
        break;
      case AuthStatus.notInGroup:
        retVal = OurNoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = HomeScreen();
        break;
    }
    return retVal;
  }
}
