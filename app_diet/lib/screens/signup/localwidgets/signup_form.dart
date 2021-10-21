import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:app_diet/states/current_user.dart';
import 'package:app_diet/widgets/our_container.dart';

class OurSignupForm extends StatefulWidget {
  const OurSignupForm({Key? key}) : super(key: key);

  @override
  State<OurSignupForm> createState() => _OurSignupFormState();
}

class _OurSignupFormState extends State<OurSignupForm> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _signUpUser(
      String email, String password, String fullName ,BuildContext context, ) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString = await _currentUser.signUpUser(email, password, fullName);
      if (_returnString == "success") {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: "Full Name",
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
            ),
            //obscureText: true,
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_open),
              hintText: "Confirm Password",
            ),
            //obscureText: true,
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 90.0),
              child: Text("Sign Up"),
            ),
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(
                    _emailController.text, _passwordController.text, _fullNameController.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Password do not match!"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
