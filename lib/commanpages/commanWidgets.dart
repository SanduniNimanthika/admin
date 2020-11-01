import 'package:flutter/material.dart';


Widget listBar(BuildContext context,String name,IconData icon){
  return ListTile(
    leading: Icon(icon),
    title: Text(
      name,
      style: Theme.of(context).textTheme.display1,
    ),
  );
}


Widget buttonContainer(BuildContext context,String name,double height,double width){
  return  Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF185a9d),
          const Color(0xFF43cea2)
        ],
      ),
      borderRadius: BorderRadius.circular(
          20 ),
    ),
    child: Center(
      child: Text(name,
          style: Theme.of(context).textTheme.subhead),
    ),
  );
}