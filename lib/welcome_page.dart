import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/Service/router.dart';
import 'package:my_app/Styles/Shadows.dart';

import 'Styles/Colors.dart';
import 'Styles/Gradients.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: ExactAssetImage('assets/image1.jpg',), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            width: width/4,
            height: height/2,
            decoration: BoxDecoration(
                boxShadow: [
                  dariusShadow
                ],
                borderRadius: BorderRadius.circular(24),
              color: White_Anti_Flash,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Chef's", style: TextStyle(color: Persian_Orange, fontWeight: FontWeight.bold, fontSize: 64)),
                      Text("Friend", style: TextStyle(color: Blue, fontWeight: FontWeight.bold, fontSize:  64),),
                    ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        context.goNamed(MyAppRouteConstants.registerRouteName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Blue,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            dariusShadow
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        context.goNamed(MyAppRouteConstants.loginRouteName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Persian_Orange,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              dariusShadow
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                        ),
                      ),
                    )
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
