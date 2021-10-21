import 'package:app_diet/screens/nogroup/no_group.dart';
import 'package:app_diet/screens/root/root.dart';
import 'package:app_diet/states/current_user.dart';
import 'package:app_diet/widgets/our_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _goToNoGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurNoGroup(),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Harry Potter and the Sorcerer's Stone",
                    style: TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: const <Widget>[
                        Text(
                          "Due In: ",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                        Text(
                          "8 days",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    child: const Text(
                      "Finished Book",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Next Book Revealed In: ",
                    style: TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                  Text(
                    "22 Hours",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: ElevatedButton(
              child: const Text(
                "Book Club History",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _goToNoGroup(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              child: const Text("Sign out"),
              onPressed: () => _signOut(context),
            ),
          ),
        ],
      ),
    );
  }
}
