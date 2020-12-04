import 'package:flutter/material.dart';
import 'package:flutter_app/models/meal.dart';
import 'package:flutter_app/widgets/meal_item.dart';
class FavoritesScreen extends StatefulWidget {
  final List<Meal>favoritesMeals;

  const FavoritesScreen(this.favoritesMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    if(widget.favoritesMeals.isEmpty){
      return Center(
        child: Text("You have no favorites yet-start adding some !"),
      );
    }
    return ListView.builder(
        itemCount: widget.favoritesMeals.length,
        itemBuilder: (context, index) {
          return MealItems(
            id: widget.favoritesMeals[index].id,
            title: widget.favoritesMeals[index].title,
            duration: widget.favoritesMeals[index].duration,
            affordability: widget.favoritesMeals[index].affordability,
            imageUrl: widget.favoritesMeals[index].imageUrl,
            complexity: widget.favoritesMeals[index].complexity,
          );
        });
  }
}
