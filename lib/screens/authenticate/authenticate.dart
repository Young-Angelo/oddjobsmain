import 'package:flutter/material.dart';
import 'package:oddjobs/screens/authenticate/register.dart';
import 'package:oddjobs/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false;
  toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(view: toggleView);
    } else {
      return Register(view: toggleView);
    }
  }
}
