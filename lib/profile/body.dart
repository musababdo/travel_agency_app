
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flightbooking/constants.dart';
import 'package:flightbooking/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class proInfo {
  //Constructor
  String username;
  String password;
  String phone;
  String email;

  proInfo.fromJson(Map json) {
    username = json['username'];
    password = json['password'];
    phone    = json['phone'];
    email    = json['email'];
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _username,_phone,_password,_email;

  TextEditingController  username = new TextEditingController();
  TextEditingController  phone    = new TextEditingController();
  TextEditingController  password = new TextEditingController();
  TextEditingController  email    = new TextEditingController();

  SharedPreferences preferences;
  Future editUserProfile() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    try{
      var url = Uri.parse('http://192.168.43.66/flightbooking/profile/edit_user_profile.php');
      var response=await http.post(url, body: {
        'id'       : preferences.getString("id"),
        'username' : username.text,
      });
      json.decode(response.body);
      Navigator.pushNamed(context, Home.id);
    }catch(e){

    }
  }

  Future editPasswordProfile() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    try{
      var url = Uri.parse('http://192.168.43.66/flightbooking/profile/edit_password_profile.php');
      var response=await http.post(url, body: {
        'id'       : preferences.getString("id"),
        'password' : password.text,
      });
      json.decode(response.body);
      setState(() {
        Navigator.pushNamed(context, Home.id);
      });
    }catch(e){

    }
  }

  Future editPhoneProfile() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    try{
      var url = Uri.parse('http://192.168.43.66/flightbooking/profile/edit_phone_profile.php');
      var response=await http.post(url, body: {
        'id'    : preferences.getString("id"),
        'phone' : phone.text,
      });
      json.decode(response.body);
      Navigator.pushNamed(context, Home.id);
    }catch(e){

    }
  }

  Future editEmailProfile() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    try{
      var url = Uri.parse('http://192.168.43.66/flightbooking/profile/edit_email_profile.php');
      var response=await http.post(url, body: {
        'id'    : preferences.getString("id"),
        'email' : email.text,
      });
      json.decode(response.body);
      Navigator.pushNamed(context, Home.id);
    }catch(e){

    }
  }

  Future deleteProfile() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    var url = Uri.parse('http://192.168.43.66/flightbooking/profile/delete_profile.php');
    http.post(url,body: {
      'id' : preferences.getString("id"),
    });
    setState(() {
      Fluttertoast.showToast(
          msg: "تم حذف الملف الشخصي",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {
        preferences.remove("value");
        preferences.remove("id");
        SystemNavigator.pop();
      });
    });
    SystemNavigator.pop();
  }

  Future getProfile() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    var url = Uri.parse('http://192.168.43.66/flightbooking/profile/display_profile.php');
    var response = await http.post(url, body: {
      "id" : preferences.getString("id"),
    });
    var data = json.decode(response.body);
    setState(() {
      final items = (data['login'] as List).map((i) => new proInfo.fromJson(i));
      for (final item in items) {
        username.text = item.username;
        phone.text    = item.phone;
        password.text = item.password;
        email.text    = item.email;

        _username = item.username;
        _phone    = item.phone;
        _password = item.password;
        _email    = item.email;
      }
    });
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          //painter: ProfileHeader(),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 7),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 20),
                        _username == null ?
                        Expanded(child: Text("Waiting...",style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ):
                        Expanded(child: Text(_username,style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ),
                        GestureDetector(
                            onTap:(){
                              nameDialog();
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 20),
                        _phone == null ?
                        Expanded(child: Text("Waiting...",style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ):
                        Expanded(child: Text(_phone,style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ),
                        GestureDetector(
                            onTap:(){
                              phoneDialog();
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 20),
                        _email == null ?
                        Expanded(child: Text("Waiting...",style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ):
                        Expanded(child: Text(_email,style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ),
                        GestureDetector(
                            onTap:(){
                              emailDialog();
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.lock),
                        SizedBox(width: 20),
                        _password == null ?
                        Expanded(child: Text("Waiting...",style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ):
                        Expanded(child: Text(_password,style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),)
                        ),
                        GestureDetector(
                            onTap:(){
                              passwordDialog();
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                ),
                elevation: 8,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.delete,size: 35,),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    myDialog();
                  },
                  label: Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15,right: 45,left: 45),
                    child: Text(
                      'حذف الحساب'.toUpperCase(),
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
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
//                    Text("تحذير",style: GoogleFonts.cairo(
//                      textStyle: TextStyle(
//                          fontSize: 22,
//                          fontWeight: FontWeight.bold
//                      ),
//                    ),),
                    const SizedBox(height:8),
                    Text('هل تود حذف حسابك ؟',style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
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
                                deleteProfile();
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
  nameDialog(){
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
                    Text("قم بادخال أسمك",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15),
                      child: TextField(
                        controller: username,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.blue),
                            hintText: "أسم المستخدم"
                        ),
                      ),
                    ),
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
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                setState(() {
                                  if (username.text.isEmpty){
                                    Fluttertoast.showToast(
                                        msg: "الرجاء أدخال أسمك",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }else {
                                    editUserProfile();
                                    Fluttertoast.showToast(
                                        msg: "تم تعديل الملف الشخصي",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    Navigator.pushNamed(context, Home.id);
                                    Navigator.of(context).pop();
                                  }
                                });
                              });
                            },
                            child: Text('حفظ',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 20,
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
    },
      isScrollControlled: true,
    );
  }
  phoneDialog(){
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
                    Text("قم بادخال رقم الهاتف",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15),
                      child: TextField(
                        controller: phone,
                        keyboardType:TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.blue),
                            hintText: "رقم الهاتف"
                        ),
                      ),
                    ),
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
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                if (phone.text.isEmpty){
                                  Fluttertoast.showToast(
                                      msg: "الرجاء أدخال رقم الهاتف",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else {
                                  editPhoneProfile();
                                  Fluttertoast.showToast(
                                      msg: "تم تعديل الملف الشخصي",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                  Navigator.pushNamed(context, Home.id);
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: Text('حفظ',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 20,
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
    },
      isScrollControlled: true,
    );
  }
  emailDialog(){
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
                    Text("قم بادخال رقم البريد الالكتروني",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15),
                      child: TextField(
                        controller: email,
                        keyboardType:TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.blue),
                            hintText: "البريد الالكتروني"
                        ),
                      ),
                    ),
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
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                if (email.text.isEmpty){
                                  Fluttertoast.showToast(
                                      msg: "الرجاء أدخال البريد الالكتروني",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else {
                                  editPhoneProfile();
                                  Fluttertoast.showToast(
                                      msg: "تم تعديل الملف الشخصي",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                  Navigator.pushNamed(context, Home.id);
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: Text('حفظ',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 20,
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
    },
      isScrollControlled: true,
    );
  }
  passwordDialog(){
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
                    Text("قم بادخال كلمه السر",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15),
                      child: TextField(
                        controller: password,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.blue),
                            hintText: "كلمه السر"
                        ),
                      ),
                    ),
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
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                if (password.text.isEmpty){
                                  Fluttertoast.showToast(
                                      msg: "الرجاء أدخال كلمه المرور",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else {
                                  editPasswordProfile();
                                  Fluttertoast.showToast(
                                      msg: "تم تعديل الملف الشخصي",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                  Navigator.pushNamed(context, Home.id);
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: Text('حفظ',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 20,
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
    },
      isScrollControlled: true,
    );
  }
}
