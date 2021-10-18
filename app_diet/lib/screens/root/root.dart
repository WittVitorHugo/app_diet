import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_diet/screens/home/home.dart';
import 'package:app_diet/screens/login/login.dart';
import 'package:app_diet/states/current_user.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRoot extends StatefulWidget {
  const OurRoot({Key? key}) : super(key: key);

  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if(_returnString == "success"){
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = Login();
        break;
      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        break;
    }
    return retVal;
  }
}
