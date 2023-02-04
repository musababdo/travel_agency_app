import 'dart:convert';
import 'package:flightbooking/constants.dart';
import 'package:flightbooking/screens/mybooked.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class BookedDetails extends StatefulWidget {
  static String id='bookeddetails';

  final List list;
  final int index;
  BookedDetails({this.list,this.index});

  @override
  _BookedDetailsState createState() => _BookedDetailsState();
}

class _BookedDetailsState extends State<BookedDetails> {

  String name,phone,type,category,departure_city,desination_City,children,disabled;
  var data,image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name             = widget.list[widget.index]['name'];
    phone            = widget.list[widget.index]['phone'];
    type             = widget.list[widget.index]['type'];
    category         = widget.list[widget.index]['category'];
    departure_city   = widget.list[widget.index]['departure_city'];
    desination_City  = widget.list[widget.index]['desination_city'];
    children         = widget.list[widget.index]['children'];
    disabled         = widget.list[widget.index]['disabled'];
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop:(){
        Navigator.pop(context);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            elevation: 0,
            title: Text(
              'تفاصيل الحجز',
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color:Colors.white,
                ),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                //Navigator.pop(context);
                Navigator.popAndPushNamed(context, MyBooked.id);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      name,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : الأسم',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      phone,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : رقم الهاتف',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      type,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : نوع الرحله',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      category,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : فئه الرحله',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      departure_city,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : بلد المغادره',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      desination_City,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : الوجهه',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      children,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : عدد الأطفال',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      disabled,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '  : عدد ذوي الأحتياجات الخاصه',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}