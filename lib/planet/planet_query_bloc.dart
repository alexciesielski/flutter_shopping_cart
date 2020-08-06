import 'dart:async';
import 'dart:convert';

import 'package:flutter_shopping_cart/core/bloc.dart';
import 'package:flutter_shopping_cart/core/swapi_response_model.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class PlanetQueryBloc implements Bloc {
  final planetsController = BehaviorSubject<List<Planet>>();
  final favoritesController = BehaviorSubject<List<String>>.seeded([]);

  Stream<List<String>> get favoritesStream =>
      favoritesController.stream.startWith([]);

  Stream<List<Planet>> get planetStream =>
      Rx.combineLatest2(planetsController.stream, favoritesStream,
          (List<Planet> planets, List<String> favorites) {
        for (var planet in planets) {
          planet.favorite = favorites.contains(planet.name);
        }

        return planets;
      });

  final url = "https://swapi.dev/api/planets";

  PlanetQueryBloc() {
    query('');
  }

  void query(String query) async {
    final response =
        await http.get(query == null ? url : "$url/?search=$query");

    if (response.statusCode == 200) {
      SwapiResponse swapi = SwapiResponse.fromJson(json.decode(response.body));
      Iterable list = swapi.results;
      List<Planet> planets =
          list.map((model) => Planet.fromJson(model)).toList();
      planetsController.sink.add(planets);
    } else {
      throw Exception('Failed to load planets');
    }
  }

  void addFavorite(Planet planet) {
    final favorites = favoritesController.value;
    favorites.add(planet.name);
    favoritesController.sink.add(favorites);
  }

  void removeFavorite(Planet planet) {
    final favorites = favoritesController.value;
    favorites.remove(planet.name);
    favoritesController.sink.add(favorites);
  }

  @override
  dispose() {
    planetsController.close();
    favoritesController.close();
  }
}
