import 'package:flutter/material.dart';
import 'package:gusto/widgets/drawer.dart';

class SettingsScreen extends StatefulWidget {
  static final String route = '/settings';
  final Function setFilters;
  final Map<String, bool> filters;
  SettingsScreen({@required this.setFilters, @required this.filters});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  void _updateState(bool value, String key) {
    setState(() {
      switch (key) {
        case 'Gluten':
          _isGlutenFree = value;
          break;
        case 'Lactose':
          _isLactoseFree = value;
          break;
        case 'Vegan':
          _isVegan = value;
          break;
        case 'Vegetarian':
          _isVegetarian = value;
          break;
        default:
          throw UnimplementedError();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isVegetarian = widget.filters['Vegetarian'];
    _isGlutenFree = widget.filters['Gluten'];
    _isLactoseFree = widget.filters['Lactose'];
    _isVegan = widget.filters['Vegan'];
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> filters = {
                'Gluten': _isGlutenFree,
                'Lactose': _isLactoseFree,
                'Vegan': _isVegan,
                'Vegetarian': _isVegetarian,
              };
              widget.setFilters(filters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            child: Text(
              'Meal Selection filters',
              style: Theme.of(ctx).textTheme.headline6,
            ),
            padding: EdgeInsets.all(10),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: Text('Gluten-free'),
                  value: _isGlutenFree,
                  onChanged: (val) => _updateState(val, 'Gluten'),
                ),
                SwitchListTile(
                  title: Text('Lactose-free'),
                  value: _isLactoseFree,
                  onChanged: (val) => _updateState(val, 'Lactose'),
                ),
                SwitchListTile(
                  title: Text('Vegan'),
                  value: _isVegan,
                  onChanged: (val) => _updateState(val, 'Vegan'),
                ),
                SwitchListTile(
                  title: Text('Vegetarian'),
                  value: _isVegetarian,
                  onChanged: (val) => _updateState(val, 'Vegetarian'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
