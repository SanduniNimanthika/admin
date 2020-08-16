import 'package:admin/StoreDisplay/store.dart';
import 'package:admin/profile/proflie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/module/staff.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/mainpages/home.dart';
import 'package:admin/loginsignup/signup.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:admin/product/productcollection.dart';
import 'package:admin/StoreDisplay/productnotifer.dart';
import 'package:admin/profile/setting&privacy.dart';
class StaffPanel extends StatefulWidget {
  @override
  _StaffPanelState createState() => _StaffPanelState();
}
bool loading = false;

class _StaffPanelState extends State<StaffPanel> {

  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    final staff = Provider.of<Staff>(context, listen: false);
    return SafeArea(
      child: StreamBuilder<Staff>(
          stream: DatabaseService(uid: staff.staffkey).profileData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ));
            }
            final profile = snapshot.data;
            return loading
                ? Loading()
                :Scaffold(
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: ClippingPath(),
                        child: Container(
                          height:(SizeConfig.isMobilePortrait?(MediaQuery.of(context).size.height/5*2):(MediaQuery.of(context).size.height/4*3)),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF185a9d),
                                const Color(0xFF43cea2)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 3 * SizeConfig.heightMultiplier,
                            top: 8 * SizeConfig.heightMultiplier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Hello,",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(fontSize: 35.0),
                            ),
                            Text(
                              profile.fullname!=null?profile.fullname:'',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(fontSize: 30.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:25*SizeConfig.heightMultiplier,left: 4*SizeConfig.heightMultiplier,
                            right: 4*SizeConfig.heightMultiplier,bottom: 4*SizeConfig.heightMultiplier),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                                onTap: (){},
                                child: dashbord(context,"Order","images/dashbord/drug_basket.png",'255',MediaQuery.of(context).size.width,)
                            ),

                            //product

                            Padding(
                              padding:  EdgeInsets.only(top:4*SizeConfig.heightMultiplier, ),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Store()));
                                  },
                                  child: dashbord(context,"Product","images/dashbord/drug_basket.png",productNotifier.productList.length.toString(),MediaQuery.of(context).size.width,)
                              ),
                            ),





                            Padding(
                              padding:  EdgeInsets.only(top:4*SizeConfig.heightMultiplier,bottom: 4*SizeConfig.heightMultiplier ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:  EdgeInsets.only(right:2*SizeConfig.heightMultiplier),

                                      //my account
                                      child: InkWell(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Setting()),
                                            );
                                          },
                                          child:dashbord(context,"Settings","images/dashbord/person-icon-blue-9.png",'',MediaQuery.of(context).size.width,)


                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left:2*SizeConfig.heightMultiplier),
                                      child: InkWell(
                                          onTap: ()async {
                                            await _auth.signOut(context);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                        Homepage()));

                                          },
                                          child: dashbord(context,"Logout","images/dashbord/secu.png",'',MediaQuery.of(context).size.width,)
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ),
                          ],
                        ),
                      )

                    ],

                    //  body:AdminPanel()
                  ),
                ));
          }),
    );
  }
}


Widget dashbord(BuildContext context,String name,String img,String count,double width){
  return  Material(
    shadowColor: Colors.teal,
    color: Color(0xFFE3F2FD),
    elevation: 10,
    type: MaterialType.canvas,
    borderRadius: BorderRadius.circular(27.0),
    child: Container(
      width: width,
      height:(SizeConfig.isMobilePortrait?(MediaQuery.of(context).size.height/7*2):(MediaQuery.of(context).size.height/2)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Text(name,style: Theme.of(context).textTheme.display1.copyWith(fontSize: 23,color: Color(0xFF185a9d)))),
            Expanded(
                flex: 6,
                child: Image(image:AssetImage(img),)),

            Expanded(
                flex:3,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(count,style: Theme.of(context).textTheme.display1.copyWith(fontSize: 23,color: Color(0xFF185a9d))),
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
