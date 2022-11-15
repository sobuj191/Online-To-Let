import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_let/ui/log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();
  SignUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _pass.text,
      );
      var authCredential=userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Fluttertoast.showToast(msg: 'Registration successful');
        Navigator.push(context, MaterialPageRoute(builder: (contest)=>LogIn()));
      }
      else{
        Fluttertoast.showToast(msg: 'Pleas check again');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SafeArea(
  child:   Column(
    children: [
      SizedBox(
        height: 150.h,
        width: ScreenUtil().screenWidth,
        child: Text("Sign Up",style: TextStyle(fontSize:24.sp,color: Colors.blue),),
      ),
      SizedBox(height: 10.h,),
      Expanded(
        child: Container(
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Welcome to On line to-let",style: TextStyle(fontSize: 24.sp,color: Colors.blue),),
                  Text("Please fill up"),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Container(
                        height: 48.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(Icons.email_outlined),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: TextStyle(fontSize: 20.sp,),
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 48.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(Icons.password_outlined),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextField(
                          controller: _pass,
                          decoration: InputDecoration(
                            hintText: "At least 8 characters",
                            hintStyle: TextStyle(fontSize: 20.sp,),
                            labelText: "Passward",
                            labelStyle: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Center(
                    child: ElevatedButton(onPressed: (){
                      SignUp();
                    }, child: Text("Register"),
                    ),
                  ),
                  SizedBox(height: 25.h,),
                  Center(child: Text("Do have an account?",style: TextStyle(fontSize: 24.sp,color: Colors.black),)),
                  SizedBox(height: 5.h,),
                  Center(
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                    }, child: Text("Sign In",style: TextStyle(fontSize: 30.sp,color: Colors.blueAccent),)),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ],
  ),
),
    );
  }
}
