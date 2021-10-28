import 'package:flutter/material.dart';
import 'package:newsapplication/Screens/CategoryScreen.dart';

class CategoriesButton extends StatelessWidget {
  String? textCategories;
  String? categories;
  Color? colorButtom;

  CategoriesButton({this.textCategories, this.categories, this.colorButtom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>CategoryScreen("$categories")));
          print("$categories");
        },
        child:
        Text("$textCategories ", style: TextStyle(
        color: Colors.white,
      ),
      ),

      color: colorButtom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),

    ),);
  }
}
