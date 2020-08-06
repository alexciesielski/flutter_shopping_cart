import 'dart:async';
import 'dart:convert';

import 'package:flutter_shopping_cart/core/bloc.dart';
import 'package:flutter_shopping_cart/core/swapi_response_model.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:http/http.dart' as http;

class PlanetDetailBloc implements Bloc {
  final Planet planet;
  final controller = StreamController<List<Planet>>();

  Stream<List<Planet>> get stream => controller.stream;
  PlanetDetailBloc(this.planet);

  final url = "https://swapi.dev/api/planets";

  void query(String query) async {
    // final results = await _client.fetchPlanetDetails(planet, query);
    // controller.sink.add(results);
    final response =
        await http.get(query == null ? url : "$url/?search=$query");

    if (response.statusCode == 200) {
      SwapiResponse swapi = SwapiResponse.fromJson(json.decode(response.body));
      Iterable list = swapi.results;
      List<Planet> planets =
          list.map((model) => Planet.fromJson(model)).toList();
      controller.sink.add(planets);
    } else {
      throw Exception('Failed to load planets');
    }
  }

  @override
  void dispose() {
    controller.close();
  }
}
