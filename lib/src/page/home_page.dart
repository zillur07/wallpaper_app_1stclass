// ignore_for_file: prefer_const_constructors

import 'package:app_name/src/component/catagory_component.dart';
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
          backgroundColor: Colors.white,
          title: const Text(
            'NatureWalls  Nature Wallpaper',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(SearchPage());
              },
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            isScrollable: true,
            tabs: [
              Tab(text: 'POPULAR'),
              Tab(text: ' CATEGORIES'),
              Tab(text: 'FAVORITES'),
            ],
          ),
        ),
        drawer: const Drawer(),
        body: TabBarView(children: [
          WellpaperComponent(),
          const CatagpryComponent(),
          Container(
            height: 300,
            width: 200,
            color: Colors.green,
            child: Center(
                child: Text(
              '3 number ',
              style: TextStyle(fontSize: 30),
            )),
          ),
        ]),
      ),
    );
  }
}
