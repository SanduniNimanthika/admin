import 'package:admin/Dashborad/Admindashbord.dart';
import 'package:admin/product/addcat.dart';
import 'package:admin/product/addsubcat.dart';
import 'package:flutter/material.dart';
import 'package:admin/product/addproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin/StoreDisplay/productnotifer.dart';
import 'package:admin/StoreDisplay/catergorynotifer.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ClippingPath(),
            child: Container(
              height: (SizeConfig.isMobilePortrait
                  ? (MediaQuery.of(context).size.height / 5 * 2)
                  : (MediaQuery.of(context).size.height / 4 * 3)),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 3 * SizeConfig.heightMultiplier,
                top: 8 * SizeConfig.heightMultiplier),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPanel()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25.0,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  flex: 13,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5 * SizeConfig.heightMultiplier,
                    ),
                    child: Text(
                      "Add Items",
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 35.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 25 * SizeConfig.heightMultiplier,
                left: 4 * SizeConfig.heightMultiplier,
                right: 4 * SizeConfig.heightMultiplier,
                bottom: 4 * SizeConfig.heightMultiplier),
            child: Column(
              children: <Widget>[
                //product

                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProduct()));
                    },
                    child: dashbord(
                      context,
                      "Product",
                      "images/dashbord/medi.png",
                      productNotifier.productList.length.toString(),
                      MediaQuery.of(context).size.width,
                    )),

                Padding(
                  padding: EdgeInsets.only(
                      top: 4 * SizeConfig.heightMultiplier,
                      bottom: 4 * SizeConfig.heightMultiplier),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 2 * SizeConfig.heightMultiplier),

                          //staff
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddSubCat()));
                              },
                              child: dashbord(
                                context,
                                "Subcategory",
                                "images/dashbord/drug_basket.png",'',

                                MediaQuery.of(context).size.width,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 2 * SizeConfig.heightMultiplier),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCat()));
                              },
                              child: dashbord(
                                context,
                                "Category",
                                "images/dashbord/drug_basket.png",
                                  catergoryNotifier.catergoryList.length.toString(),
                                MediaQuery.of(context).size.width,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                //order
              ],
            ),
          )
        ],

        //  body:AdminPanel()
      ),
    ));
  }
}

Widget dashbord(
    BuildContext context, String name, String img, String count, double width) {
  return Material(
    shadowColor: Colors.teal,
    color: Color(0xFFE3F2FD),
    elevation: 10,
    borderRadius: BorderRadius.circular(27.0),
    child: Container(
      width: width,
      height: (SizeConfig.isMobilePortrait
          ? (MediaQuery.of(context).size.height / 7 * 2)
          : (MediaQuery.of(context).size.height / 2)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(name,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontSize: 23, color: Color(0xFF185a9d)))),
            Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage(img),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(count,
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontSize: 23, color: Color(0xFF185a9d))),
                ))
          ],
        ),
      ),
    ),
  );
}

class ClippingPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(
      size.width,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldCliper) => false;
}
