import 'dart:ui';
import 'package:admin/database/Catdatabase.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/StoreDisplay/subcatergorylist.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/StoreDisplay/productdisplay.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context);

    return Scaffold(
      key: _key,
      drawer: Drawer(
        // linear background
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                tileMode: TileMode.repeated,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Text(
                      "Product catergories",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.white),
                    ),
                  )),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: catergoryNotifier.catergoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.blueGrey,
                              thickness: 1,
                            ),
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    catergoryNotifier.currentCatergory =
                                        catergoryNotifier
                                            .catergoryList[index];
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return SubCatergorylist();
                                    }));
                                  },
                                  child: Text(
                                      catergoryNotifier
                                          .catergoryList[index].catergory,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subhead),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ],
            )),
      ),
      body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
         // physics: ScrollPhysics(),
        children:<Widget> [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/dashbord/epharmacy.jpg"),
                          fit: BoxFit.fill)),
                  height: (MediaQuery.of(context).size.height / 3) * 1,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    // make sure we apply clip it properly
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Opacity(
                        opacity: .5,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF185a9d),
                                const Color(0xFF43cea2)
                              ],
                              tileMode: TileMode.repeated,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 3.5 * SizeConfig.heightMultiplier,
                      left: 2 * SizeConfig.heightMultiplier,
                      right: 2 * SizeConfig.heightMultiplier),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              UserManagment().authorizedAccess(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25.0,
                              color: Color(0xFF185a9d),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.list,
                            size: 5 * SizeConfig.heightMultiplier,
                            color: Color(0xFF185a9d),
                          ),
                          onPressed: () {
                            _key.currentState.openDrawer();
                          },
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Text(
                                  "Medicare",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(fontSize: 30),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: 5 * SizeConfig.heightMultiplier,
                                    color: Color(0xFF185a9d),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5 * SizeConfig.heightMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text(
                        "Offers",
                        style: Theme.of(context).textTheme.subtitle,
                      )),
                ],
              ),
            ),
            OfferDisplay(),
          ],
        ),]
      ),
    );
  }
}

class OfferDisplay extends StatefulWidget {
  @override
  _OfferDisplayState createState() => _OfferDisplayState();
}

class _OfferDisplayState extends State<OfferDisplay> {
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProductsOffer(productNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:
      MediaQuery.of(context).size.width /
    MediaQuery.of(context).size.height/0.85),
      itemCount: productNotifier.productList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: ()async{
            setState(() {
              productNotifier.currentProduct =
              productNotifier.productList[index];
            });

            Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ProductDisplay();
            }));},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
              shadowColor: Colors.greenAccent,
              elevation: 5,
              child: Container(

                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0))),
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 5,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(productNotifier
                                                .productList[index].images),
                                            fit: BoxFit.fill)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 37,
                                      width: 57.0,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              bottomRight: Radius.circular(25.0)),
                                          ),
                                      child: Center(
                                        child: Text( '${productNotifier.productList[index].offer.toString()}%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead

                                    ),
                                      ),
                                    ),
                                  )],
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    productNotifier
                                        .productList[index].productname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                            color: Color(0xFF185a9d),
                                            fontSize: 18.0),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Rs.${productNotifier.productList[index].offerprice.toString()}',
                                        style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red),
                                      ),
                                      Text(
                                        'Rs.${productNotifier.productList[index].price.toString()}',
                                        style: Theme.of(context).textTheme.display1.copyWith(decoration: TextDecoration.lineThrough )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
