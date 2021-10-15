import 'package:flutter/material.dart';

import 'localwidgets/signup_form.dart';

class Signup extends StatelessWidget {
  const Signup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    BackButton(),
                  ],
                ),
                const SizedBox(height: 40.0,),
                const OurSignupForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}