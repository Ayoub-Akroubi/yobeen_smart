// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yobeen_smart/Login/Pages/login_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Container(
            color: Color.fromARGB(255, 230, 227, 227),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 70 / 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("./assets/images/image/gp.png"),
              ),
            ),
          ),
          SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 35 / 100,
                    vertical: MediaQuery.of(context).size.height * 30 / 100),
                child: Image.asset("./assets/images/logo/logo.png"),
              )),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
              height: 60,
              child: FlatButton(
                onPressed: () => {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login()))
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color.fromARGB(218, 255, 86, 34),
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  "S'identifier",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
            // SizedBox(
            //   height: 60,
            //   child: FlatButton(
            //     onPressed: () => {
            //       Navigator.push(
            //           context, MaterialPageRoute(builder: (context) => Login()))
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10)),
            //     color: Color.fromARGB(218, 255, 255, 255),
            //     padding: EdgeInsets.only(left: 55, right: 55),
            //     child: Text(
            //       "S'inscrire",
            //       style: TextStyle(
            //           color: Color.fromARGB(255, 3, 3, 3), fontSize: 20),
            //     ),
            //   ),
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
            Container(
              alignment: Alignment.center,
              child: FlatButton(
                  onPressed: () => {},
                  child: Text(
                    'yobeen.com',
                    style: TextStyle(
                      color: Color.fromARGB(153, 122, 120, 120),
                      fontSize: 14,
                    ),
                  )),
            ),
          ])
        ]));
  }
}
