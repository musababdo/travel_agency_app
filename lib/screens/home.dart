
import 'package:flightbooking/constants.dart';
import 'package:flightbooking/profile/profilescreen.dart';
import 'package:flightbooking/screens/booked.dart';
import 'package:flightbooking/screens/login.dart';
import 'package:flightbooking/screens/mybooked.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Info {
  //Constructor
  String username;
  String phone;

  Info.fromJson(Map json) {
    username = json['username'];
    phone    = json['phone'];
  }
}

class Home extends StatefulWidget {
  static String id='home';
  final List list;
  final int index;
  Home({this.list,this.index});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Uri _url = Uri.parse('tel://+24996778525');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop:(){
        exitDialog();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height:height* .1,
                  ),
                  Text(
                      'وكاله هايكور للسفر والسياحه',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                  SizedBox(
                    height:height* .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'أحجز او أتصل',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.phone,color: kMainColor,)
                    ],
                  ),
                  SizedBox(
                    height:height* .02,
                  ),
                  GestureDetector(
                    onTap:(){
                      launchUrl(_url);
                    },
                    child: Text(
                        '+24996778525',
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    height:height* .06,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context, Booked.id);
                          },
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: kMainColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: new Center(
                                  child: new Text("أحجز الأن",
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white
                                      ),
                                    ),
                                    textAlign: TextAlign.center,),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context, MyBooked.id);
                          },
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color:kMainColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: new Center(
                                  child: new Text("الحجوزات",
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white
                                      ),
                                    ),
                                    textAlign: TextAlign.center,),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height* .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap:(){
                            launchUrl(_url);
                          },
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: kMainColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: new Center(
                                  child: new Text("اتصل بنا",
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white
                                      ),
                                    ),
                                    textAlign: TextAlign.center,),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context, ProfileScreen.id);
                          },
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color:kMainColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: new Center(
                                  child: new Text("الصفحه الشخصيه",
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                      ),
                                    ),
                                    textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height* .02,
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
  myDialog(){
    showModalBottomSheet(context: context, builder: (context){
      return WillPopScope(
        onWillPop:(){
          Navigator.pop(context);
          return Future.value(false);
        },
        child: SafeArea(
            child: Container(
              color: Color(0xFF737373),
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text("تنبيه",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 22,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Text('ليس لديك حساب قم بعمل حساب الأن ',style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 19,
                      ),
                    ),),
                    const SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('الغاء',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, Login.id).then((_){
                                  Navigator.of(context).pop();
                                });
                              });
                            },
                            child: Text('موافق',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      );
    });
  }
  exitDialog(){
    showModalBottomSheet(context: context, builder: (context){
      return WillPopScope(
        onWillPop:(){
          Navigator.pop(context);
          return Future.value(false);
        },
        child: SafeArea(
            child: Container(
              color: Color(0xFF737373),
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text("الخروج من التطبيق",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 22,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Text('هل تود الخروج من التطبيق ',style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 19,
                      ),
                    ),),
                    const SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('الغاء',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                SystemNavigator.pop();
                              });
                            },
                            child: Text('موافق',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      );
    });
  }
}
