import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nav_homepage extends StatefulWidget {
  const Nav_homepage({super.key});

  @override
  State<Nav_homepage> createState() => _Nav_homepageState();
}

class _Nav_homepageState extends State<Nav_homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
