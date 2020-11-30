import 'package:admin/Dashborad/Admindashbord.dart';
import 'package:admin/AddItem/addcat.dart';
import 'package:admin/AddItem/addsubcat.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/database/Catdatabase.dart';
import 'package:flutter/material.dart';
import 'package:admin/AddItem/addproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:admin/StoreDisplay/store.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  void initState() {
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: linearcolor()
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 3 * SizeConfig.heightMultiplier,
                top: 8 * SizeConfig.heightMultiplier),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminPanel()));
                },
                child: Icon(
                  Icons.clear,
                  size: 25.0,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 20 * SizeConfig.heightMultiplier,
                left: 4 * SizeConfig.heightMultiplier,
                right: 4 * SizeConfig.heightMultiplier,
                bottom: 4 * SizeConfig.heightMultiplier),
            child: Column(
              children: <Widget>[
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


                          child:  InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddProduct(text: 'AddItem',)));
                              },
                              child: dashbord(
                                context,
                                "Add Product",
                                "images/dashbord/medi.png",
                                productNotifier.productList.length.toString(),
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
                                        builder: (context) =>Store()));
                              },
                              child: dashbord(
                                context,
                                "Visit Store",
                                "images/dashbord/shop-icon.png",
                                null,
                                MediaQuery.of(context).size.width,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),



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
                                        builder: (context) => AddSubCat(text: 'AddItem',)));
                              },
                              child: dashbord(
                                context,
                                "Add Subcategory",
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
                                        builder: (context) => AddCat(text: 'AddItem',)));
                              },
                              child: dashbord(
                                context,
                                "Add Category",
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
                        .copyWith(fontSize: 18, color: Color(0xFF185a9d)))),
            Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage(img),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (count!=null)?Text(count,
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontSize: 20, color: Color(0xFF185a9d))):null
                ))
          ],
        ),
      ),
    ),
  );
}


