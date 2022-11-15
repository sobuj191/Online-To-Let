import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_let/ui/Navigationbutton.dart';
import 'package:to_let/ui/home_screen.dart';
import 'package:to_let/ui/sign_up.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailSign=TextEditingController();
  TextEditingController _passSign=TextEditingController();
  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailSign.text,
          password: _passSign.text,
      );
      var  authCredential=userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigationbutton()));
      }
      else{
        Fluttertoast.showToast(msg: "Please check again");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 24.sp, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to Online To-Let",
                            style: TextStyle(
                                fontSize: 20.sp, color: Colors.blueAccent),
                          ),
                          Text("Please login"),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 48.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  child: Icon(
                                    Icons.email_outlined,
                                    size: 20.w,
                                  )),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _emailSign,
                                  decoration: InputDecoration(
                                    hintText: "mdsobujcmt@gmail.com",
                                    hintStyle: TextStyle(fontSize: 16.sp,color: Colors.black),
                                    labelText: "Email",
                                    labelStyle: TextStyle(fontSize: 16.sp,color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15.h,),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Icon(Icons.password_outlined)),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _passSign,
                                  decoration: InputDecoration(
                                    hintText: "At least 6 characters",
                                    hintStyle: TextStyle(fontSize: 16.sp,color: Colors.black),
                                    labelText: "Password",
                                    labelStyle: TextStyle(fontSize: 16.sp,color: Colors.grey)
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Center(
                            child: ElevatedButton(onPressed: (){
                              signIn();
                            }, child: Text("Sign In",style: TextStyle(fontSize: 16.sp),)),
                          ),
                          SizedBox(height: 25.h,),
                          Center(child: Text("Don't have an account?",style: TextStyle(fontSize: 24.sp,color: Colors.black),)),
                          SizedBox(height: 5.h,),
                          Center(
                            child: TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            }, child: Text("Sign Up",style: TextStyle(fontSize: 30.sp,color: Colors.blueAccent),)),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
