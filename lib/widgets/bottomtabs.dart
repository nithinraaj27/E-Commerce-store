import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottommTabs extends StatefulWidget {

  final int? selectedTab;
  final Function(int)? tabPressed;
  const BottommTabs({this.selectedTab, this.tabPressed});

  @override
  _BottommTabsState createState() => _BottommTabsState();
}

class _BottommTabsState extends State<BottommTabs> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.09),
                spreadRadius: 1.0,
                blurRadius: 30.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imgpath: "assets/tab_home.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: ()
            {
              widget.tabPressed!(0);
            },
          ),
          BottomTabBtn(
            imgpath: "assets/tab_search.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: ()
            {
              widget.tabPressed!(1);
            },
          ),
          BottomTabBtn(
            imgpath: "assets/tab_saved.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: ()
            {
              widget.tabPressed!(2);
            },
          ),
          BottomTabBtn(
            imgpath: "assets/tab_logout.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: ()
            {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String? imgpath;
  final bool? selected;
  final Function? onPressed;

  const BottomTabBtn({this.imgpath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed as Function()?,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Image.asset(
          imgpath ?? "assets/tab_home.png",
          width: 26,
          height: 26,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
