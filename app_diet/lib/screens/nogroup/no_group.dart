import 'package:app_diet/screens/creategroup/create_group.dart';
import 'package:app_diet/screens/home/home.dart';
import 'package:app_diet/screens/joingroup/join_group.dart';
import 'package:flutter/material.dart';

class OurNoGroup extends StatelessWidget {
  const OurNoGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OurJoinGroup(),
        ),
      );
    }

    void _goToCreate(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OurCreateGroup(),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Spacer(
            flex: 1,
          ),
          ElevatedButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Image.asset("assets/logo.png"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Welcome to Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Since you are not in a book club, you can select" +
                  " either to join a club or create a club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.grey),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _goToCreate(context),
                  child: const Text("Create"),
                ),
                ElevatedButton(
                  onPressed: () => _goToJoin(context),
                  child: const Text("Join"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
