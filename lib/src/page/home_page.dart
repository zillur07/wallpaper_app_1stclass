// ignore_for_file: prefer_const_constructors

import 'package:app_name/src/component/catagory_component.dart';
import 'package:app_name/src/component/wellpaper__popular_component.dart';
import 'package:app_name/src/component/wellpaper_component.dart';
import 'package:app_name/src/page/srch_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Uzzal Wallpaper',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  (SearchPage()),
                  transition: Transition.rightToLeftWithFade,
                );
              },
              icon: Icon(
                Icons.search,
                // color: Colors.pink,
              ),
            ),
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.pink,
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.black,
            // isScrollable: true,
            tabs: [
              Tab(text: 'HOME'),
              Tab(text: 'CATEGORIES'),
              Tab(text: 'POPULAR'),
            ],
          ),
        ),
        drawer: Drawer(),
        body: TabBarView(children: [
          WellpaperComponent(),
          CatagpryComponent(),
          WellpaperPopularComponent(),
        ]),
      ),
    );
  }
}
