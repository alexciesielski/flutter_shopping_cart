import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:flutter_shopping_cart/planet/planet_query_bloc.dart';
import 'package:flutter_shopping_cart/planet_detail/planet_tile.dart';

class PlanetDetailScreen extends StatelessWidget {
  final Planet planet;
  final PlanetQueryBloc bloc;

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
        body: PlanetTile(planet: planet, onFavorited: onFavorited));
  }

  onFavorited(Planet planet) {
    planet.favorite ? bloc.removeFavorite(planet) : bloc.addFavorite(planet);
  }

  // Widget _buildSearch(BuildContext context) {
  //   final bloc = PlanetDetailBloc(planet);

  //   return BlocProvider<PlanetDetailBloc>(
  //     bloc: bloc,
  //     child: Column(
  //       children: <Widget>[
  //         Padding(
  //             padding: const EdgeInsets.all(10.0), child: Text(planet.climate)),
  //         Expanded(
  //           child: _buildStreamBuilder(bloc),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildStreamBuilder(PlanetDetailBloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.stream,
  //     builder: (context, snapshot) {
  //       final results = snapshot.data;

  //       if (results == null) {
  //         return Center(child: Text('Enter a planet name'));
  //       }

  //       if (results.isEmpty) {
  //         return Center(child: Text('No Results'));
  //       }

  //       return _buildSearchResults(results);
  //     },
  //   );
  // }

  // Widget _buildSearchResults(List<Planet> results) {
  //   return ListView.separated(
  //     itemCount: results.length,
  //     separatorBuilder: (context, index) => Divider(),
  //     itemBuilder: (context, index) {
  //       final planet = results[index];
  //       return PlanetTile(planet: planet);
  //     },
  //   );
  // }
}
