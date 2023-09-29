import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oddjobs/screens/authenticate/authenticate.dart';
import 'package:oddjobs/screens/homescreen/home.dart';
import 'package:oddjobs/screens/homescreen/main_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
