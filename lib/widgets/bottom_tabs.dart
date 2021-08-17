import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/screens/cart_page.dart';

class BottomTabs extends StatefulWidget {
  final int? selectedTab;
  final Function(int)? tabPressed;

  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BottomTabBtn(
              imagePath: "assets/images/outline_home_black_24dp.png",
              selected: _selectedTab == 0 ? true : false,
              onPressed: () {
                widget.tabPressed!(0);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BottomTabBtn(
              imagePath: "assets/images/outline_bookmark_black_24dp.png",
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.tabPressed!(1);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BottomTabBtn(
              imagePath: "assets/images/outline_shopping_cart_black_24dp.png",
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                setState(() {
                  selected:
                  true;
                });
                widget.tabPressed!(2);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BottomTabBtn(
              imagePath: "assets/images/outline_logout_black_24dp.png",
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabBtn(
      {required this.imagePath,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: () {
        onPressed!();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 4.0))),
        child: Center(
          child: Image(
            image: AssetImage(
                imagePath ?? "assets/images/outline_home_black_24dp.png"),
            width: 22.0,
            height: 22.0,
            color: _selected ? Theme.of(context).accentColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
