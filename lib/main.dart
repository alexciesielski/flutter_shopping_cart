import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/core/bloc_provider.dart';
import 'package:flutter_shopping_cart/main_screen.dart';
import 'package:flutter_shopping_cart/planet/planet_bloc.dart';

void main() {
  runApp(MyApp());
}

//
//
// Tutorial
// https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern#toc-anchor-009
//
//

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlanetBloc>(
      bloc: PlanetBloc(),
      child: MaterialApp(
        title: 'Planet Finder',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: MainScreen(),
      ),
    );
  }
}
