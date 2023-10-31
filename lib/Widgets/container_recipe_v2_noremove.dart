import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Styles/Gradients.dart';
import 'package:my_app/Styles/Shadows.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:my_app/Widgets/users_recipes_page.dart';

import '../Classes/recipe.dart';

class ContainerRecipeV2Public extends StatefulWidget {
  final Recipe recipe;
  final String? imageUrl;


  ContainerRecipeV2Public({super.key, required this.recipe, required this.imageUrl});

  @override
  State<ContainerRecipeV2Public> createState() => _ContainerRecipeV2StatePublic();
}

class _ContainerRecipeV2StatePublic extends State<ContainerRecipeV2Public> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 400,
          maxWidth: 450,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              dariusShadow
            ],
            color: Blue,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Image(
                        height: 56,
                        image: AssetImage('assets/pin-nobg.png'),
                      )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 8.0,           // Border width
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        shadowImage
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.imageUrl != null
                          ? Image.network(widget.imageUrl!)
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(widget.recipe.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        dariusShadow
                      ],
                      color: Bluev2,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.recipe.ingredients.map((item){
                              return Text(
                                '• $item',
                                style: TextStyle(fontSize: 18),
                              );
                            }).toList(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.recipe.instructions.map((item){
                              return Text(
                                '• $item',
                                style: TextStyle(fontSize: 18),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Row(
                      children: [
                        Text('Created by: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsersRecipesPage(username: widget.recipe.user_username)));
                        },
                          child: Text(widget.recipe.user_username, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Persian_Orange)),)
                      ],
                    ),
                  )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
