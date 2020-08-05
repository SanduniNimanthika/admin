import 'package:admin/loginsignup/login.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
bool loading = false;

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  loading
        ? Loading()
        :SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).size.height/5*3,

                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: ClippingPath(),
                      child: Container(
                          height: MediaQuery.of(context).size.height/5*3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:AssetImage("images/mainpages/5555.jpg"),)
                          ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Image.asset("images/mainpages/Online-Pharmacy.png"),
                      ),
                    )
                  ],
                ),
              ),
              Button(),
            ],
          ),
        ),
      ),
    );
  }
}


class Button extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 13*SizeConfig.heightMultiplier),
      child: Padding(
        padding:  EdgeInsets.only(left:6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier ),
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          elevation: 4.0,
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signin()));
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text("Login",
                    style:Theme.of(context).textTheme.subhead),
              ),
            ),
          ),
        ),
      ),
    );
  }
}







class ClippingPath extends CustomClipper<Path>{
  @override
  Path getClip (Size size){
    var path= Path();
    path.lineTo(0.0, size.height-40);
    path.quadraticBezierTo(size.width/4,size.height, size.width/2, size.height);
    path.quadraticBezierTo(size.width-(size.width/4), size.height, size.width, size.height-40);
    path.lineTo(size.width, size.height/1.5);
    path.lineTo(size.width,0.0,);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldCliper)=>false;
}