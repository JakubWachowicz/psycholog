
import 'package:flutter/material.dart';

import '../../Utils/constants.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          color: Colors.white,
        ),

        child: Container(
            color: Colors.white,
            child:pages[pageIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: pageIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black87,
        backgroundColor: Colors.white,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Challenge'),
          BottomNavigationBarItem(icon: Icon(Icons.generating_tokens),label: 'Videos'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Add'),

        ],

      ),
    );
  }
}