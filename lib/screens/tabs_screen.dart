import 'package:flutter/material.dart';
import 'package:flutter_app/models/meal.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import 'package:flutter_app/widgets/main_drawer.dart';
class TabScreen extends StatefulWidget {
  final List<Meal>favoritesMeals;

  const TabScreen(this.favoritesMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
   List<Map<String,Object>>_page;
  int _SIndex=0;
  @override
  void initState() {
    _page=[{'page':CategoriesScreen(),'title':"Categories"},{'page':FavoritesScreen(widget.favoritesMeals),'title':"Your Favorite"}];
    super.initState();
  }
  void _selectedPage(int index){
    setState(() {
      _SIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_SIndex]['title']),
      ),
      drawer:MainDrawer(),
      body: _page[_SIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categories")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorites")
        ),
        ],
      currentIndex: _SIndex,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Colors.white,
      onTap: _selectedPage,
      ),
    );
  }
}

