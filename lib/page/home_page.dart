import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/page/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signeout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Delevery App'), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('')),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.login_outlined),
              onTap: () {
                signeout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('')),
    );
  }
}
