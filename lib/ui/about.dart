import 'package:flutter/material.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end:  Alignment.topRight,
                  colors:[
                    Colors.green,
                    Color.fromRGBO(108,211,115, 30),
                    Colors.lightGreen,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 80),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/editThree.png"),
                    backgroundColor: Colors.white,
                    //Image.asset("assets/editOne.png", width: 150, height: 150,),
                  ),
                  SizedBox(height: 25),
                  Text("ABOUT DEVELOPERS",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "NeonClubMusic", color: Colors.white),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}