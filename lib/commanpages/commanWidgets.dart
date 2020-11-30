import 'package:flutter/material.dart';

Widget listBar(BuildContext context, String name, IconData icon) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      name,
      style: Theme.of(context).textTheme.display1,
    ),
  );
}

Widget buttonContainer(
    BuildContext context, String name, double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(name, style: Theme.of(context).textTheme.subhead),
    ),
  );
}

Widget buttonContainerWithBlue(BuildContext context,String name,double height,double width){
  return  Container(
    height: height,
    width: width,
    decoration:  BoxDecoration(
        color: Color(0xFF185a9d),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color:Colors.white,
            style: BorderStyle.solid,
            width: 2.0
        )
    ),
    child: Center(
      child: Text(name,
          style: Theme.of(context).textTheme.subhead),
    ),
  );
}

linearcolor() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
  );
}

boxDecarationhistory() {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)));
}

inputDecaration(BuildContext context, labelname, IconData data) {
  return InputDecoration(
    labelText: labelname,
    prefixIcon: Icon(data, color: Colors.blueGrey),
    labelStyle: Theme.of(context).textTheme.display1,
    fillColor: Colors.white,
    errorStyle:Theme.of(context).textTheme.display1.copyWith(color: Colors.red,
        fontSize: 12.0) ,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFF185a9d), style: BorderStyle.solid, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFF185a9d), style: BorderStyle.solid, width: 1),
    ),
  );
}
