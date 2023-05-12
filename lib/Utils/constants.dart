import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/Utils/color_util.dart';


import '../controller/auth_controller.dart';
import '../view/screens/chat_screen.dart';



//Screen size

double screenHeight = 0;
double screenWidth = 0;


//Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//Controllers

var authcontroller = AuthenticationClontroller.instance;



//Colors
//final backGroundColor  = '#f7d5e1'.toColor();
const backGroundColor = Colors.black;
const textColor = Colors.green;
//const buttonColor = Colors.deepOrangeAccent;
//final buttonColor = '#ffcc00'.toColor();
//final buttonColor = '#ff5500'.toColor();
//final buttonColor ='#f7d5e1'.toColor();
const buttonColor = Colors.green;
final borderColor = Colors.black54;
final borderFocusedColor = Colors.green;



String lol = "Test person";
var pages = [

  Text("2"),
  Text("3"),

];