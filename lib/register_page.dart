import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/user_service.dart';
import 'Service/user_service.dart';
import 'Widgets/input_text_create.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextBarCreateRecipe(Controller: usernameController, type: 'Username'),
            TextBarCreateRecipe(Controller: nameController, type: 'Name'),
            TextBarCreateRecipe(Controller: passwordController, type: 'Password'),
            TextButton(
                onPressed: (){
                  registerUser(usernameController.text, nameController.text, passwordController.text);
                },
                child: Text("Register")
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Log In"),
            )
          ],
        ),
      ),
    );
  }
}
