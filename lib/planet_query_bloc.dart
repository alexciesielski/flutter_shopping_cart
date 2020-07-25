import 'dart:async';
import 'dart:convert';

import 'package:flutter_shopping_cart/bloc.dart';
import 'package:flutter_shopping_cart/planet_model.dart';
import 'package:flutter_shopping_cart/swapi_response_model.dart';
import 'package:http/http.dart' as http;

class PlanetQueryBloc implements Bloc {
  final controller = StreamController<List<Planet>>();

  Stream<List<Planet>> get planetStream => controller.stream;

  final url = "https://swapi.dev/api/planets";

  query(String query) async {
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
  dispose() {
    controller.close();
  }
}
