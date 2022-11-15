import 'package:flutter/material.dart';
import 'package:to_let/ui/home_screen.dart';
import 'package:to_let/ui/search_house.dart';

class Navigationbutton extends StatefulWidget {
  const Navigationbutton({Key? key}) : super(key: key);

  //const Navigationbutton({Key? key}) : super(key: key);

  @override
  _NavigationbuttonState createState() => _NavigationbuttonState();
}

class _NavigationbuttonState extends State<Navigationbutton> {
  var cindex = 0;
  int c=0;
  final page = [
    //const First(),
    const Home(),
    const Home(),
    const Search_house(),
    const Search_house(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttom Navigation Bar'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cindex,

      type:BottomNavigationBarType.fixed,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.book),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_box),label: ""),
        ],
        onTap: (index){
        if(index==0){
          c=0;
        }else c++;
        setState(() {
          cindex=index;
        });
        },
      ),
      body: page[cindex],
    );
  }
}
