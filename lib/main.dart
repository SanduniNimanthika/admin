import 'package:admin/module/staff.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/textstyle.dart';
import 'package:admin/mainpages/splash.dart';
import 'package:admin/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:admin/notifer/subcatergorynotifier.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/notifer/oderhistorynotifer.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return (MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => CatergoryNotifier(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => SubCatergoryNotifier(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => ProductOrderHistoryNotifier(),
                  ),

            ChangeNotifierProvider(
            create: (context) => ProductNotifier(),
            ),
               StreamProvider<Staff>.value(
                  value: AuthService().user)],
                  child: MaterialApp(
                    title: 'Ecommerce application',
                    theme:  AppTheme.lightTheme,
                    home: Splash(),
                    debugShowCheckedModeBanner: false,
                  )
              )
            );
          },
        );
      },
    );
  }
}

