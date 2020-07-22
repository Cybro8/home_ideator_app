import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:home_ideator_app/Pages/home.dart';
import 'package:home_ideator_app/Pages/profile_page.dart';
import 'package:home_ideator_app/Pages/shop_page.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  int currentIndex =0;
  final List pages=[
   Home(),
  Shop(),
  Profile()
  ];
  Widget build(BuildContext context) {
    return new MaterialApp(
        home:Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        title:Image.asset('images/icon.png',
          width: 50,
          height: 70,
        ),
        backgroundColor: Colors.white,
      ),
      ),
      body:pages[currentIndex],
      bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: currentIndex,
          onTap: changePage,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          hasNotch: true, //new
          hasInk: true, //new, gives a cute ink effect
          inkColor: Colors.black12, //optional, uses theme color if not specified
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(backgroundColor: Colors.blueAccent, icon: Icon(Icons.home, color: Colors.black,), activeIcon: Icon(Icons.dashboard, color: Colors.blueAccent,), title: Text("Home")),
      BubbleBottomBarItem(backgroundColor: Colors.blueAccent, icon: Icon(Icons.shop, color: Colors.black,), activeIcon: Icon(Icons.shopping_cart, color: Colors.blueAccent,), title: Text("Shop")),
      BubbleBottomBarItem(backgroundColor: Colors.blueAccent, icon: Icon(Icons.perm_identity, color: Colors.black,), activeIcon: Icon(Icons.person, color: Colors.blueAccent,), title: Text("Profile")),
      ],
    ),
    )
    );
  }
  void changePage(int value) {
    setState(() {
      currentIndex = value;
    });
  }
}
