import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_let/ui/house_details.dart';
import 'package:to_let/ui/houses_description.dart';
import 'package:to_let/ui/search_house.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nindex=0;
  int c=0;
  final pages=[
    const Home(),
    const Home(),
    const Home(),
    //const Home(),
     const Search_house(),
    //  const Search_house(),
    //  const Search_house(),


  ];
  var _firetoreInstance=FirebaseFirestore.instance;
  fetchhouses()async{//firebase theke resourrces ftch kore neye asar jonno
    QuerySnapshot qn=await _firetoreInstance.collection("houses").get();
        setState(() {
          for(int i=0;i<qn.docs.length;i++){
            houses.add({
              "house-img": qn.docs[i]["house-img"],
              "house-description": qn.docs[i]["house-description"],
              "location": qn.docs[i]["location"],
              "rent": qn.docs[i]["rent"]
            });
          }
        });
        return qn.docs;
  }
  @override
  void initState() {//load howar shate shatte kaj korar jonno
    // TODO: implement initState
    fetchhouses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: nindex,
        //
        // type:BottomNavigationBarType.fixed,
        //   items: const[
        //     BottomNavigationBarItem(icon: Icon(Icons.home),label: ""),
        //     BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
        //     BottomNavigationBarItem(icon: Icon(Icons.book),label: ""),
        //     BottomNavigationBarItem(icon: Icon(Icons.account_box),label: ""),
        //   ],
        //   onTap: (index){
        //   if(index==0){
        //     c=0;
        //   }else c++;
        //   setState(() {
        //     nindex=index;
        //   });
        //   },
        // ),
        body:
           SafeArea(
             child: Container(

              child: Column(
                children: [

                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                        itemCount: houses.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                        itemBuilder: (_, index){
                      return GestureDetector(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>House_details(houses[index]))),
                        child: Card(
                          color: Colors.blueAccent,
                          elevation: 3,
                          child: Column(

                            children: [
                              AspectRatio(aspectRatio: 1.5,
                              child: Container(
                                color: Colors.blueAccent,
                                child:Image.network(houses[index]["house-img"],
                                fit: BoxFit.cover,
                                ),
                              ),),
                              SizedBox(height: 15.sp,),
                              Text("${houses[index]["location"]}",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
                              Text("${houses[index]["rent"]}",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
                            ],
                          ),
                        ),
                      );
                        }
                    ),
                  )],
              ),
          ),
           ),
        

      ),
    );
  }
}
