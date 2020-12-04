import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static String routName = 'filter_screen';

  final Function saveFilters;
  final Map<String,bool>currentFilter;

  FiltersScreen(this.currentFilter,this.saveFilters);


  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;



  Widget _buildSwitchListTile(
      String title, String description, bool currentValue, Function newValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: newValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }
  @override
  void initState() {
    _glutenFree=widget.currentFilter['gluten'];
    _lactoseFree=widget.currentFilter['lactose'];
    _vegetarian=widget.currentFilter['vegetarian'];
    _vegan=widget.currentFilter['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilters(selectedFilters);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                "Gluten-free",
                "Only include gluten-free meals.",
                _glutenFree,
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                "vegetarian",
                "Only include vegetarian meals.",
                _vegetarian,
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                "vegan",
                "Only include vegan meals.",
                _vegan,
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                "Lactose-free",
                "Only include Lactose-free meals.",
                _lactoseFree,
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
