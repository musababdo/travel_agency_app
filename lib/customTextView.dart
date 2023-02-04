import 'package:flutter/material.dart';
import 'package:flightbooking/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {

  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final Function onClick;
  final Function myfun;
  final Function showHide;
  bool secure=true;
  String _errorMessage(String str) {
    switch (hint) {
      case 'أسم المستخدم':
        return 'الرجاء ادخال الاسم ';
      case 'رقم الهاتف':
        return 'الرجاء ادخال رقم الهاتف';
      case 'من':
        return 'الرجاء ادخال الموقع';
      case 'الي':
        return 'الرجاء ادخال  الوجهه';
      case 'عنوان السكن':
        return 'الرجاء ادخال  عنوان السكن';
      case 'المقاعد':
        return 'الرجاء ادخال المقاعد';
    }
  }

  CustomTextField({@required this.showHide,@required
  this.myfun,@required this.onClick, @required this.icon,
    @required this.hint, @required this.controller});

  @override
  stateCustom createState() => stateCustom();

}

class stateCustom extends State<CustomTextField>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value.isEmpty) {
            return widget._errorMessage(widget.hint);
            // ignore: missing_return
          }
        },
        onSaved: widget.onClick,
        onTap:widget.myfun,
        obscureText: widget.hint == 'كلمه المرور' ? widget.secure : false,
        keyboardType: widget.hint == 'الهاتف' ? TextInputType.number : TextInputType.text ,
        cursorColor: blueColor,
        readOnly: widget.hint == 'من' ? true : false,
        decoration: InputDecoration(
          labelText: widget.hint == 'من' ? "بورتسودان" : null,
          hintText: widget.hint,
          hintStyle: GoogleFonts.cairo(
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: blueColor,
          ),
          suffixIcon: IconButton(
            onPressed: (){
              setState(() {
                widget.secure = !widget.secure;
              });
            },
            icon: Icon(widget.hint == 'كلمه المرور' ? widget.secure
                ? Icons.visibility_off
                : Icons.visibility : null),
          ),
          filled: true,
          fillColor: blueOpenColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Colors.white)
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
      ),
    );
  }

}