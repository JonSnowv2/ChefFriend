import 'dart:js';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/user_service.dart';
import 'package:my_app/Widgets/input_text_password.dart';
import 'package:my_app/Widgets/message_complete.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Service/user_service.dart';
import 'Styles/Colors.dart';
import 'Styles/Gradients.dart';
import 'Styles/Shadows.dart';
import 'Widgets/input_text_create.dart';
import 'homepage.dart';
import 'Classes/user.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void logInUser2(String username, String password, BuildContext context) async {

    if (_formKey.currentState!.validate()) {
      bool userExists = await checkUserExists(usernameController.text);

      if(!userExists){
        showOverlayNotification((context) {
          return CompleteMessage(
            message: 'Username does not exist',
          );
        });
      }
      else{
        showOverlayNotification((context) {
          return CompleteMessage(
            message: 'Log In Successful!',
          );
        });
          final user = await loginUser(usernameController.text, passwordController.text);
         if (user != null) {
           print(user.username);
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => HomePage(user: user),
             ),
         );
       }
      }
    }
    else{
      showOverlayNotification((context) {
        return CompleteMessage(
          message: 'Something went wrong!',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: ExactAssetImage('assets/background.jpg',), fit: BoxFit.cover),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(width/2-138, 0, 0, 0),
                    child: Row(
                        children: [
                          Text("Chef's", style: TextStyle(color: Persian_Orange, fontWeight: FontWeight.bold, fontSize: 48)),
                          Text("Friend", style: TextStyle(color: Blue, fontWeight: FontWeight.bold, fontSize:  48),),
                        ]
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: width/4,
                  height: height/2,
                  decoration: BoxDecoration(
                      boxShadow: [
                        dariusShadow
                      ],
                      borderRadius: BorderRadius.circular(24),
                      gradient: gradientRegister
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Log In", style: TextStyle(color: White_Anti_Flash, fontWeight: FontWeight.bold, fontSize:  32),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
                          child: CoolTextBar(
                            Controller: usernameController,
                            type: 'Username',
                            validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter a username";
                                }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: CoolTextBarPassword(
                            Controller: passwordController,
                            type: 'Password',
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter a password";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        logInUser2(usernameController.text, passwordController.text, context);
                      },
                      child: Text("Log In", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(height: 20,),
                  Text("don't have an account?", style: TextStyle(color: Colors.blue),),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  )
                ],
              )
                ],
              ),
        )
        ),
    );
  }
}



