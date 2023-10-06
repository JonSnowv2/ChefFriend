import 'package:flutter/material.dart';
import '../Styles/Shadows.dart';
import '../Classes/recipe.dart';
import '../Service/recipe_service.dart';

class ContainerRecipe extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback Function;

  const ContainerRecipe({Key? key, required this.recipe, required this.Function}) : super(key: key);

  @override
  _ContainerRecipeState createState() => _ContainerRecipeState();
}

class _ContainerRecipeState extends State<ContainerRecipe> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue,
          gradient: LinearGradient(
            colors: [Colors.blue.withOpacity(0.7), Colors.deepOrange.withOpacity(0.7)],
            stops: [0.5, 0.9],
          ),
          boxShadow: [dariusShadow],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  child: Image(image: AssetImage('assets/food.jpg')),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(widget.recipe.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  Text(widget.recipe.category, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  // Display ingredients as a column
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.recipe.ingredients
                    .map((ingredient) => Text('- $ingredient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)))
                    .toList(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    deleteRecipe(widget.recipe.id);
                    widget.Function();
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
