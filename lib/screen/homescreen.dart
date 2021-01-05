import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              leading: Icon(Icons.menu),
              actions: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ))
              ],
              expandedHeight: 300,
              flexibleSpace: new FlexibleSpaceBar(
                  title: Text(
                    "current location",
                    textAlign: TextAlign.left,
                  ),
                  background: Image.asset(
                    'assets/screen1/appbar_bg.png',
                    fit: BoxFit.cover,
                  )),
              pinned: true,
              shadowColor: Colors.red,
              backgroundColor: Colors.pink,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => new ListTile(
                  title: Text("HAI $index"),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            activeIcon: Icon(Icons.home, color: Colors.red),
            // title: Text("Home"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_rounded, color: Colors.grey),
            label: 'Deals',
            activeIcon: Icon(Icons.sticky_note_2_rounded, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: Colors.grey),
            label: 'Saved',
            activeIcon: Icon(Icons.bookmark, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stream, color: Colors.grey),
            label: 'Cards',
            activeIcon: Icon(Icons.stream, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.grey),
            label: 'Profile',
            activeIcon: Icon(Icons.account_circle_outlined, color: Colors.red),
          ),
        ],
        onTap: (index) {
          setState(() {});
        },
      ),
    );
  }
}
