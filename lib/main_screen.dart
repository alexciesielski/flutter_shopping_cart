import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/core/bloc_provider.dart';
import 'package:flutter_shopping_cart/planet/planet_bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:flutter_shopping_cart/planet/planet_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PlanetBloc>(context);

    return StreamBuilder<List<Planet>>(
        stream: bloc.planetsStream,
        builder: (context, snapshot) {
          return PlanetsScreen(bloc: bloc, planets: snapshot.data);
        });
  }
}
