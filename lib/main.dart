import 'package:flutter/material.dart';
import 'package:flutter_app/dummy_data.dart';
import 'package:flutter_app/screens/filter_screen.dart';
import 'models/meal.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';
void main(){
  runApp(MaterialApp(home: MyApp(),
    debugShowCheckedModeBanner: false,
    title: 'HumHum !',));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool>_filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
};
  List<Meal>_availableMeals=DUMMY_MEALS;
  List<Meal>_favoritesMeals=[];

  void _setFilters(Map<String,bool>filterData){
    setState(() {
      _filters=filterData;
      _availableMeals=DUMMY_MEALS.where((meal){
        if(_filters['gluten']&& !meal.isGlutenFree){
          return false;
        } if(_filters['lactose']&& !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegetarian']&& !meal.isVegetarian){
          return false;
        }
        if(_filters['vegan']&& !meal.isVegan){
          return false;
        }
        return true;
      }).toList();
    });
  }
  void _toggleFavorites(String mealId){
    final existingIndex=
        _favoritesMeals.indexWhere((meal) => meal.id == mealId );
    if(existingIndex >=0){
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool isMealFavorite(String id){
   return _favoritesMeals.any((meal) => meal.id==id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme:ThemeData.light().textTheme.copyWith(
        body1:TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1)
        ),
          body2:TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1)          ),
        title: TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold
        )
      ),
      ),
      title: "DeliMeals",
      initialRoute: 'categories',
      routes: {
        '/':(context)=>TabScreen(_favoritesMeals),
        CategoriesMeal.routName:(context)=>CategoriesMeal(_availableMeals),
        MealDetails.routName:(context)=>MealDetails(_toggleFavorites,isMealFavorite),
        FiltersScreen.routName:(context)=>FiltersScreen(_filters,_setFilters),
      },
    );
  }
}
