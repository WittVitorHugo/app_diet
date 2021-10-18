import 'package:app_diet/screens/root/root.dart';
import 'package:app_diet/states/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is home page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Sign Out"),
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnString = await _currentUser.signOut();
            if (_returnString == "success") {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => OurRoot()),
                  (route) => false);
            }
          },
        ),
      ),
    );
  }
}
