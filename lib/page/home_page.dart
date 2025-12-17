import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/page/Navigation/chat.dart';
import 'package:food_delivery_app/page/Navigation/homepage.dart';
import 'package:food_delivery_app/page/Navigation/profile.dart';
import 'package:food_delivery_app/page/Navigation/search.dart';
import 'package:food_delivery_app/page/Navigation/setting.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cuttentTableIndex = 0;

  final List<Widget> screens = [
    Nav_homepage(),
    search(),
    chat(),
    Profile(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Delevery App'), centerTitle: true),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: cuttentTableIndex,

        onTap: (index) {
          setState(() {
            cuttentTableIndex = index;
          });
        },
        height: 60,
        color: Colors.white,
        items: [
          CurvedNavigationBarItem(child: Icon(Icons.home_outlined)),
          CurvedNavigationBarItem(child: Icon(Icons.search)),
          CurvedNavigationBarItem(child: Icon(Icons.chat_bubble_outline)),

          CurvedNavigationBarItem(child: Icon(Icons.perm_identity)),
          CurvedNavigationBarItem(child: Icon(Icons.settings_outlined)),
        ],
      ),

      body: screens[cuttentTableIndex],
    );
  }
}


