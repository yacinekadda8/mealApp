import 'package:flutter/material.dart';
import './dummy_data.dart';
import './modules/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegetarian' : false,
    'vegan' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> _filtersData){
    _filters = _filtersData;
    _availableMeals = DUMMY_MEALS.where((meal) {
      if(_filters['gluten'] && !meal.isGlutenFree){
        return false;
      }
      if(_filters['lactose'] && !meal.isLactoseFree){
        return false;
      }
      if(_filters['vegetarian'] && !meal.isVegetarian){
        return false;
      }
      if(_filters['vegan'] && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
  }

  void _toggleFavorites(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex>=0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorites(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Color.fromARGB(255, 255, 190, 15),
        canvasColor: Color.fromARGB(255, 246, 233, 209),
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(

            color:Color.fromARGB(255, 3, 18, 41),
          ),
          body2: TextStyle(
            color:Color.fromARGB(255, 3, 18, 41),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          ),
        )),

       /* home:Directionality(
        textDirection: TextDirection.rtl,
        //child: MyHomePage(),
        child: CategoriesScreen(),
      ), */

      routes: {
          '/': (context) => TabsScreen(_favoriteMeals),
        MealScreen.routName:(context)=>MealScreen(_availableMeals),
        MealDetailScreen.routName:(context)=>MealDetailScreen(_toggleFavorites,_isMealFavorites),
        FiltersScreen.routeName:(context)=>FiltersScreen(_filters,_setFilters)
      } ,


    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal"),
      ),
      body: null,
    );
  }
}
