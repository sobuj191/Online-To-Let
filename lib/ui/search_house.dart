import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search_house extends StatefulWidget {
  const Search_house({Key? key}) : super(key: key);

  @override
  _Search_houseState createState() => _Search_houseState();
}

class _Search_houseState extends State<Search_house> {
  var s_input = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) {
                setState(() {
                  s_input = val;
                });
              },
            ),
            SizedBox(height: 10.h,),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("houses")
                      .where("location", isGreaterThanOrEqualTo: s_input)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong"));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text("Loading"));
                    }
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.docs.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  child: Card(
                                    color: Colors.blueAccent,
                                    elevation: 3,
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1.5,
                                          child: Container(
                                            color: Colors.blueAccent,
                                            child: Image.network(
                                              snapshot.data['house-img'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.sp,
                                        ),
                                        Text("${snapshot.data["location"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text("${snapshot.data["rent"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
