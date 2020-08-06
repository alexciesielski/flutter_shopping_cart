import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/core/bloc_provider.dart';
import 'package:flutter_shopping_cart/planet/planet_bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:flutter_shopping_cart/planet/planet_query_bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_screen.dart';
import 'package:rxdart/rxdart.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PlanetQueryBloc();
    final selectedPlanetStream =
        BlocProvider.of<PlanetBloc>(context).planetStream;

    return StreamBuilder<Planet>(
      stream: Rx.combineLatest2(bloc.planetStream, selectedPlanetStream,
          (List<Planet> planets, Planet selected) {
        return planets.firstWhere((element) => element.name == selected.name);
      }),
      builder: (context, snapshot) {
        return PlanetsScreen(bloc: bloc);
      },
    );
  }
}
