
import 'dart:convert';

import 'package:flightbooking/constants.dart';
import 'package:flightbooking/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Booked extends StatefulWidget {
  static String id='booked';
  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _id,_username,_phone,_email,_typeValue,_categoryValue,_childrenValue,_disabledValue;
  bool visible = false;

  String selectedDepartur_city,selectedDesination_city;
  List myDepartur_city=[];
  List myDesination_city=[];

  Future getDepartureCity() async{
    var url = Uri.parse('http://192.168.6.213/flightbooking/display_departure_city.php');
    var response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      myDepartur_city=data;
    });
    return data;
  }
  Future getDesinationCity() async{
    var url = Uri.parse('http://192.168.6.213/flightbooking/display_desination_city.php');
    var response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      myDesination_city=data;
    });
    return data;
  }

  TextEditingController  username       = new TextEditingController();
  TextEditingController  phone          = new TextEditingController();
  TextEditingController  email          = new TextEditingController();
  TextEditingController  departure_time = new TextEditingController();
  TextEditingController  return_time    = new TextEditingController();

  SharedPreferences preferences;
  Future getOrder() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      _id       = preferences.getString("id");
      _username = preferences.getString("username");
      _phone    = preferences.getString("phone");
      _email    = preferences.getString("email");

      username.text  = _username;
      phone.text     = _phone;
      email.text     = _email;
    });
  }

  Future sendNow() async{
    var url = Uri.parse('http://192.168.6.213/flightbooking/save_booked.php');
    //var url = Uri.parse('https://h-o.sd/medicalcare/doctor_order.php');
    var response=await http.post(url, body: {
      "name"           : username.text,
      "phone"          : phone.text,
      "email"          : email.text,
      "type"           : _typeValue,
      "departure_time" : departure_time.text,
      "return_time"    : return_time.text,
      "category"       : _categoryValue,
      "departure_city" : selectedDepartur_city,
      "desination_city": selectedDesination_city,
      "children"       : _childrenValue,
      "disabled"       : _disabledValue,
      "user_id"        : _id,
    });
    //json.decode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrder();
    getDepartureCity();
    getDesinationCity();
    departure_time.text = "";
    return_time.text = "";
  }

  String _errorMessage(String hint) {
    if(hint=="الاسم"){
      return 'الرجاء ادخال الاسم';
    }else if(hint=="رقم الهاتف"){
      return 'الرجاء ادخال رقم الهاتف';
    }else if(hint=="البريد الالكتروني"){
      return 'الرجاء ادخال البريد الالكتروني';
    }else if(hint=="بلد المغادره"){
      return 'الرجاء ادخال بلد المغادره';
    }else if(hint=="الوجهه"){
      return 'الرجاء ادخال الوجهه';
    }else if(hint=="تاريخ المغادره"){
      return 'الرجاء ادخال تاريخ المغادره';
    }else if(hint=="تاريخ الرجوع"){
      return 'الرجاء ادخال تاريخ الرجوع';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _globalKey,
      child: SafeArea(
        child: WillPopScope(
          onWillPop:(){
            Navigator.pop(context);
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kMainColor,
              elevation: 0,
              title: Text(
                'أحجز الأن',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, Home.id);
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 9,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.3,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all()),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: TextFormField(
                                          validator:(value) {
                                            if (value.isEmpty) {
                                              return _errorMessage("الاسم");
                                              // ignore: missing_return
                                            }
                                          },
                                          controller: username,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.blue),
                                              hintText: "الاسم"
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all()),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          validator:(value) {
                                            if (value.isEmpty) {
                                              return _errorMessage("رقم الهاتف");
                                              // ignore: missing_return
                                            }
                                          },
                                          controller: phone,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.blue),
                                              hintText: "رقم الهاتف"
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all()),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          validator:(value) {
                                            if (value.isEmpty) {
                                              return _errorMessage("البريد الالكتروني");
                                              // ignore: missing_return
                                            }
                                          },
                                          controller: email,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.blue),
                                              hintText: "البريد الالكتروني"
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all()),
                                        child: Padding(
                                          padding:const EdgeInsets.only(left: 30, right: 30),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:const EdgeInsets.only(left: 30, right: 30),
                                              child: DropdownButton<String>(
                                                value: _typeValue,
                                                //elevation: 5,
                                                style: TextStyle(color: Colors.black),

                                                items: <String>[
                                                  'ذهاب',
                                                  'ذهاب وعوده',
                                                ].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                hint: Text(
                                                  "أختر نوع الرحله",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _typeValue = value;
                                                    try{
                                                      if(value == "ذهاب"){
                                                        visible = false;
                                                      }else if(value == "ذهاب وعوده"){
                                                        visible = true;
                                                      }
                                                    }on PlatformException catch(e){

                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all()),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: TextFormField(
                                            validator:(value) {
                                              if (value.isEmpty) {
                                                return _errorMessage("تاريخ المغادره");
                                                // ignore: missing_return
                                              }
                                            },
                                            controller: departure_time,
                                            decoration: InputDecoration(
                                                hintStyle: TextStyle(color: Colors.blue),
                                                hintText: "تاريخ المغادره"
                                            ),
                                            onTap: () async {
                                              DateTime pickedDate = await showDatePicker(
                                                  context: context, initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101)
                                              );

                                              if(pickedDate != null ){
                                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  departure_time.text = formattedDate; //set output date to TextField value.
                                                });
                                              }else{
                                                print("Date is not selected");
                                              }
                                            }
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: visible,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all()),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                          child: TextFormField(
                                            // validator:(value) {
                                            //   if (value.isEmpty) {
                                            //     return _errorMessage("تاريخ الرجوع");
                                            //     // ignore: missing_return
                                            //   }
                                            // },
                                              controller: return_time,
                                              decoration: InputDecoration(
                                                  hintStyle: TextStyle(color: Colors.blue),
                                                  hintText: "تاريخ الرجوع"
                                              ),
                                              onTap: () async {
                                                DateTime pickedDate = await showDatePicker(
                                                    context: context, initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime(2101)
                                                );

                                                if(pickedDate != null ){
                                                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    return_time.text = formattedDate; //set output date to TextField value.
                                                  });
                                                }else{
                                                  print("Date is not selected");
                                                }
                                              }
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all()),
                                        child: Padding(
                                          padding:const EdgeInsets.only(left: 30, right: 30),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:const EdgeInsets.only(left: 30, right: 30),
                                              child: DropdownButton<String>(
                                                value: _categoryValue,
                                                //elevation: 5,
                                                style: TextStyle(color: Colors.black),

                                                items: <String>[
                                                  'الدرجه السياحيه',
                                                  'درجه رجال الأعمال',
                                                  'الدرجه الاولي',
                                                  'الدرجه السياحيه المميزه',
                                                ].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                hint: Text(
                                                  "أختر فئه الرحله",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _categoryValue = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all()),
                                        child: Padding(
                                          padding:const EdgeInsets.only(left: 30, right: 30),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:const EdgeInsets.only(left: 30, right: 30),
                                              child: DropdownButton(
                                                value: selectedDepartur_city,
                                                hint: Text('اختر بلد المغادره'),
                                                items: myDepartur_city.map(( map){
                                                  return DropdownMenuItem(
                                                    child: Text(map['city_name']),
                                                    value: map['city_name'],
                                                  );
                                                }).toList(),
                                                onChanged:(value){
                                                  setState(() {
                                                    selectedDepartur_city=value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all()),
                                        child: Padding(
                                          padding:const EdgeInsets.only(left: 30, right: 30),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding:const EdgeInsets.only(left: 30, right: 30),
                                              child: DropdownButton(
                                                value: selectedDesination_city,
                                                hint: Text('اختر الوجهه'),
                                                items: myDesination_city.map(( map){
                                                  return DropdownMenuItem(
                                                    child: Text(map['name']),
                                                    value: map['name'],
                                                  );
                                                }).toList(),
                                                onChanged:(value){
                                                  setState(() {
                                                    selectedDesination_city=value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Text(
                        'المسافرون',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 9,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Text(
                                    'الأطفال',
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all()),
                                  child: Padding(
                                    padding:const EdgeInsets.only(left: 30, right: 30),
                                    child: DropdownButtonHideUnderline(
                                      child: Padding(
                                        padding:const EdgeInsets.only(left: 30, right: 30),
                                        child: DropdownButton<String>(
                                          value: _childrenValue,
                                          //elevation: 5,
                                          style: TextStyle(color: Colors.black),

                                          items: <String>[
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5',
                                            '6',
                                            '7',
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "أختر عدد الأطفال",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              _childrenValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Text(
                                    'ذوي الأحتياجات الخاصه',
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all()),
                                  child: Padding(
                                    padding:const EdgeInsets.only(left: 30, right: 30),
                                    child: DropdownButtonHideUnderline(
                                      child: Padding(
                                        padding:const EdgeInsets.only(left: 30, right: 30),
                                        child: DropdownButton<String>(
                                          value: _disabledValue,
                                          //elevation: 5,
                                          style: TextStyle(color: Colors.black),

                                          items: <String>[
                                            '1',
                                            '2',
                                            '3',
                                            '4',
                                            '5',
                                            '6',
                                            '7',
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "أختر عدد ذوي الأحتياجات الخاصه",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              _disabledValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8,top: 8),
                    child: Builder(
                      builder: (context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          if (_globalKey.currentState.validate()){
                            _globalKey.currentState.save();
                            try{
                              sendNow();
                              Fluttertoast.showToast(
                                  msg: "تم تأكيد الحجز",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pushNamed(context, Home.id);
                            }on PlatformException catch(e){

                            }
                          }
                        },
                        color: kMainColor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 5),
                          child: Center(
                            child: Text(
                                "تأكيد الحجز",
                                style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
