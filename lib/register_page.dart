import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/user_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Styles/Gradients.dart';
import 'package:my_app/Styles/Shadows.dart';
import 'package:my_app/Widgets/message_complete.dart';
import 'package:my_app/log_in_page.dart';
import 'Service/user_service.dart';
import 'Widgets/input_text_create.dart';
import 'Widgets/input_text_password.dart';
import 'package:overlay_support/overlay_support.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser2(String username, String name, String password) async {

    if (_formKey.currentState!.validate()) {
      bool userExists = await checkUserExists(usernameController.text);

      if(userExists){
        showOverlayNotification((context) {
          return CompleteMessage(
            message: 'Username Already Exists',
          );
        });
      }
      else{
        showOverlayNotification((context) {
          return CompleteMessage(
            message: 'Registration Complete',
          );
        });
        registerUser(usernameController.text, nameController.text, passwordController.text);
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
          image: DecorationImage(image: ExactAssetImage('assets/background4.jpg',), fit: BoxFit.cover),
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
                        Text("Register", style: TextStyle(color: White_Anti_Flash, fontWeight: FontWeight.bold, fontSize:  32),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: CoolTextBar(
                            Controller: usernameController,
                            type: 'Username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CoolTextBar(
                            Controller: nameController,
                            type: 'Name',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter a name';
                              }
                            },
                          ),
                        ),
                        CoolTextBarPassword(
                          Controller: passwordController,
                          type: 'Password',
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Please enter a password.';
                            }
                            if (value!.length < 6) {
                              return 'Password must be at least 6 characters.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: (){
                        registerUser2(usernameController.text, nameController.text, passwordController.text);
                      },
                      child: Text("Register", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(height: 20,),
                  Text('already have an account?', style: TextStyle(color: Colors.blue),),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInPage()));
                    },
                      child: Text("Log In", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
