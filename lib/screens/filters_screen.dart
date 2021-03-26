import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> filters;

  FiltersScreen(this.filters,this.saveFilters);


  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState(){
    _glutenFree = widget.filters['gluten'];
    _lactoseFree = widget.filters['lactose'];
    _vegan = widget.filters['vegetarian'];
    _vegetarian = widget.filters['vegan'];
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, bool currentValue, String subtitle, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed:(){
              final Map<String, bool> selectedFilters = {
                'gluten' : _glutenFree,
                'lactose' : _lactoseFree,
                'vegetarian' : _vegetarian,
                'vegan' : _vegan,
              };
              widget.saveFilters(selectedFilters);
            }
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                'Gluten-Free',
                _glutenFree,
                'Only include Gluten-free meals',
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                'Lactose-Free',
                _lactoseFree,
                'Only include Lactose-Free meals',
                    (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                'Vegan',
                _vegan,
                'Only include Vegan meals',
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                'Vegetarian',
                _vegetarian,
                'Only include Vegetarian meals',
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
