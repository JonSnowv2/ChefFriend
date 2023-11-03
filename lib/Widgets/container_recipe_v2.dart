import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Styles/Gradients.dart';
import 'package:my_app/Styles/Shadows.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../Classes/recipe.dart';

class ContainerRecipeV2 extends StatefulWidget {
  final Recipe recipe;
  final String? imageUrl;
  final VoidCallback Function;


  ContainerRecipeV2({super.key, required this.recipe, required this.imageUrl, required this.Function});

  @override
  State<ContainerRecipeV2> createState() => _ContainerRecipeV2State();
}

class _ContainerRecipeV2State extends State<ContainerRecipeV2> {
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
                        : Container(child: Text("Chef'sFriend"),),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.recipe.ingredients.map((item){
                              return Text(
                                '• $item',
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.recipe.instructions.map((item){
                              return Text(
                                '• $item',
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Row(
                    children: [
                      widget.recipe.public == 1 ?
                          Row(
                            children: [
                              Text('Public', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),),
                              Icon(Icons.check, color: Colors.green,),
                            ],
                          ):
                      Row(
                        children: [
                          Text('Public', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),),
                          Icon(Icons.close, color: Colors.red,),
                        ],
                      ),
                      IconButton(onPressed: (){deleteRecipe(widget.recipe.id); widget.Function();}, icon: const Icon(Icons.highlight_remove_outlined)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.edit),)
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
