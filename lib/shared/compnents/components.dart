import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  @required var hintText,
  var Controller,
  Function validator,
  var textInputType,
  IconData prefixIcon,
})=>Padding(
  padding: const EdgeInsetsDirectional.only(top: 20,start: 20,end:20),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(
          prefixIcon,
      ),
    ),
    controller: Controller,
    validator: validator,
    keyboardType: textInputType,

  ),
);
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigatePop(context)=>Navigator.pop(context);
void showToast({
  @required String txt,
  @required ToastState state
}){
  Fluttertoast.showToast(
      msg:txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastState{SUCCESS,ERROR,WRONG}
Color chooseToastColor(ToastState state){

  Color color;
  switch(state){
    case ToastState.SUCCESS:
      color =Colors.green;
      break;
    case ToastState.ERROR:
      color =Colors.red;
      break;
    case ToastState.WRONG:
      color =Colors.yellow;
      break;
      return color;
  }
}
Widget defaultFormField2({
  String hintText,
  String labelText,
  @required IconData prefixIcon,
  @required TextInputType keyBoard,
  Function onSubmitted,
  Function validator,
  TextEditingController controller,
  bool obscure =false,
  IconData suffixIcon,
  Function suffixPressed,
})=>Padding(
  padding: EdgeInsets.symmetric(horizontal: 5),
  child: TextFormField(
    style: TextStyle(
        color: Colors.deepOrange
    ),
    keyboardType: keyBoard,
    onFieldSubmitted: onSubmitted,
    controller: controller,
    obscureText: obscure,
    validator: validator,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: Colors.grey[300],
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(
              color: Colors.deepOrange
          )
      ),
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.deepOrange[100]
      ),
      labelText: labelText,
      labelStyle: TextStyle(
          color: Colors.deepOrange[200]
      ),
      border: OutlineInputBorder(),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.deepOrange,
      ),
      suffixIcon: IconButton(
          icon:Icon(
            suffixIcon,
            color: Colors.deepOrange,
          ),
          onPressed:suffixPressed
      ),
    ),
  ),
);
