import 'package:app_diet/screens/profile/profile.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_diet/screens/home/home.dart';

class OurNavigationBar extends StatefulWidget {
  const OurNavigationBar({Key? key}) : super(key: key);

  @override
  State<OurNavigationBar> createState() => _OurNavigationBarState();
}

class _OurNavigationBarState extends State<OurNavigationBar> {
  int _selectedIndex = 0;

  var user = FirebaseAuth.instance.currentUser;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        _selectedIndex = index;
      });
    } else if (index == 1) {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PatientProfilePage(user.uid)));
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: _onItemTapped,
    );
  }
}
