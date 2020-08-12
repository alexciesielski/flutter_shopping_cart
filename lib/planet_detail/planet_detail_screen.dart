import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/planet/planet_bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:flutter_shopping_cart/planet_detail/planet_tile.dart';

class PlanetDetailScreen extends StatelessWidget {
  final PlanetBloc bloc;
  final Planet planet;

  const PlanetDetailScreen(
      {Key key, @required this.planet, @required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: StreamBuilder<List<Planet>>(
          stream: bloc.planetsStream,
          builder: (context, snapshot) {
            return PlanetTile(planet: planet, onFavorited: onFavorited);
          }),
    );
  }

  onFavorited(Planet planet) {
    planet.favorite ? bloc.removeFavorite(planet) : bloc.addFavorite(planet);
  }
}
