import 'package:app_name/src/model/wallpaper.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {},
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
          SingleChildScrollView(
            child: Column(
              children: [
                // GridView.builder(
                //   shrinkWrap: true,
                //   primary: false,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3, // Number of columns
                //       crossAxisSpacing: 8.0, // Spacing between columns
                //       mainAxisSpacing: 2.0,
                //       mainAxisExtent: 250.0),
                //   itemCount: wallpaperData.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     final item = wallpaperData[index];
                //     return Container(
                //       height: 350,
                //       width: 250,
                //       child: Image.asset(
                //         item.image.toString(),
                //         fit: BoxFit.cover,
                //       ),
                //     );
                //   },
                // ),
                GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 250.0),
                    itemCount: wallpaperData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = wallpaperData[index];
                      return Container(
                        width: 250,
                        child: Image.asset(
                          // '${wallpaperData[index].image}',
                          // '${item.image}',
                          //item.image.toString(),
                          wallpaperData[index].image.toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    })
              ],
            ),
          ),
          Container(
            height: 300,
            width: 200,
            color: Colors.teal,
            child: Center(
              child: Text(
                '2 number ',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
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

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
