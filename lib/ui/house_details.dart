import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class House_details extends StatefulWidget {
  var _house;
  House_details(this._house);

  @override
  _House_detailsState createState() => _House_detailsState();
}

class _House_detailsState extends State<House_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          child: IconButton(onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("name",isEqualTo: widget._house['house-name']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Text("");
            }
            return Padding(
              padding: EdgeInsets.only(right: 8.0),
            );
          },),
        ],
      ),
      body:Padding(
        padding: EdgeInsets.only(left: 10.w,right:10.w,top: 10.h ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                color: Colors.blueAccent,
                child: Image.network(widget._house["house-img"],fit: BoxFit.cover,),
              ),
              Text(widget._house["location"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 10.h,),
              Text(widget._house['rent'],style: TextStyle(fontSize: 25),),
              SizedBox(height: 10.h,),
              Text(widget._house["house-description"],style: TextStyle(fontSize: 20.sp),)
            ],
          ),
        ),
      ),
    );
  }
}
