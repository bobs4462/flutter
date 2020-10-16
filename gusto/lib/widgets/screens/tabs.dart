import 'package:flutter/material.dart';
import 'package:gusto/widgets/screens/categories_screen.dart';
import 'package:gusto/widgets/drawer.dart';
import 'package:gusto/widgets/screens/favorites.dart';
import 'package:gusto/models/meal.dart';

// class TabsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext ctx) {
//     return DefaultTabController(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Meals'),
//           bottom: TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Categories',
//               ),
//               Tab(
//                 icon: Icon(Icons.favorite),
//                 text: 'Favorites',
//               )
//             ],
//           ),
//         ),
//         body: TabBarView(children: [
//           CategoriesScreen(),
//           FavoritesScreen(),
//         ]),
//       ),
//       length: 2,
//     );
//   }
// }

class TabsScreenBottom extends StatefulWidget {
  static final String route = '/';
  final List<Meal> favorites;
  TabsScreenBottom(this.favorites);
  @override
  State<TabsScreenBottom> createState() => _TabsScreenBottomState();
}

class _TabsScreenBottomState extends State<TabsScreenBottom> {
  List<Map<String, Widget>> _pages;

  int _selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      {'Categories': CategoriesScreen()},
      {'Favorites': FavoritesScreen(widget.favorites)},
    ];
  }

  @override
  Widget build(BuildContext ctx) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex].keys.first),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex].values.first,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(ctx).accentColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(ctx).primaryColor,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(ctx).accentColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(ctx).accentColor,
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
