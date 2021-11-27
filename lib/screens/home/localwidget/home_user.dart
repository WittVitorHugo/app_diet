import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:app_diet/screens/root/root.dart';
import 'package:app_diet/states/current_user.dart';

class HomeScreenUser extends StatelessWidget {
  var userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:
          const EdgeInsets.only(top: 48.0, bottom: 16.0, left: 24.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Center(
            child: Text('Home User'),
          ),
        ],
      ),
    );
  }
}
