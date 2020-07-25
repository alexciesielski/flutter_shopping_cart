import 'dart:async';

import 'package:flutter_shopping_cart/core/bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';

class PlanetBloc implements Bloc {
  Planet planet;

  Planet get selectedPlanet => planet;

  final planetController = StreamController<Planet>();

  Stream<Planet> get planetStream => planetController.stream;

  void selectPlanet(Planet planet) {
    planet = planet;
    planetController.sink.add(planet);
  }

  @override
  void dispose() {
    planetController.close();
  }
}
