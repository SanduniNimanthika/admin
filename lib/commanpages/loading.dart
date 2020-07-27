import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
      ),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10.0),
            child:CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
            )
    ));
  }
}
