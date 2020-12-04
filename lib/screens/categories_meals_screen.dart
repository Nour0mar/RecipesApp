import 'package:flutter/material.dart';
import 'package:flutter_app/dummy_data.dart';
import 'package:flutter_app/models/meal.dart';
import 'package:flutter_app/widgets/meal_item.dart';

class CategoriesMeal extends StatefulWidget {
  static String routName = 'categories_meal';
  final List<Meal>availableMeal;

   CategoriesMeal(this.availableMeal);



  @override
  _CategoriesMealState createState() => _CategoriesMealState();
}

class _CategoriesMealState extends State<CategoriesMeal> {
  String categoryTitle;
  List<Meal>displayedMeals;
  var _l=false;
  @override
  void didChangeDependencies() {
    if(! _l){
      final routArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routArgs['title'];
      final categoryId = routArgs['id'];
      displayedMeals = widget.availableMeal.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _l=true;
    }
    super.didChangeDependencies();
  }
  void _removeMeal(String mealId){
    setState(() {
     displayedMeals.removeWhere((meal) => meal.id==mealId);
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
      ),
      body: ListView.builder(
          itemCount: displayedMeals.length,
          itemBuilder: (context, index) {
            return MealItems(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              imageUrl: displayedMeals[index].imageUrl,
              complexity: displayedMeals[index].complexity,
            );
          }),
    );
  }
}
