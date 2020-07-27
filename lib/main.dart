import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/textstyle.dart';
import 'package:admin/mainpages/splash.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return  MaterialApp(
              title: 'Ecommerce application',
              theme:  AppTheme.lightTheme,
              home: Splash(),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}

