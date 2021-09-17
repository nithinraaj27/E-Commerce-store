import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/tabs/Home_tab.dart';
import 'package:ecommerce_app/tabs/saved%20_Tab.dart';
import 'package:ecommerce_app/tabs/search_tab.dart';
import 'package:ecommerce_app/widgets/bottomtabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabPageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabPageController,
              onPageChanged: (val) {
                setState(() {
                  _selectedTab = val;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ],
            ),
          ),
          BottommTabs(
            selectedTab: _selectedTab,
            tabPressed: (val) {
              setState(() {
                _tabPageController.animateToPage(val,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCirc);
              });
            },
          ),
        ],
      )),
    );
  }
}
