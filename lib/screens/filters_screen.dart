import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  static const routeName = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegetarian = false;
  var _isVegan = false;
  var _isLactoseFree = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['gluten']!;
    _isLactoseFree = widget.currentFilters['lactose']!;
    _isVegan = widget.currentFilters['vegan']!;
    _isVegetarian = widget.currentFilters['vegetarian']!;

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description, bool currentValue, Function f) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.onSecondary,
      title: Text(title),
      value: currentValue,
      onChanged: (v) => f,
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _isGlutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile('Gluten-free', 'Only include gluten-free meals', _isGlutenFree, (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }),
                _buildSwitchListTile('Vegetarian', 'Only include vegetarian meals', _isVegetarian, (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }),
                _buildSwitchListTile('Vegan', 'Only include vegan meals', _isVegan, (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }),
                _buildSwitchListTile('Lactose-free', 'Only include lactose-free meals', _isLactoseFree, (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
