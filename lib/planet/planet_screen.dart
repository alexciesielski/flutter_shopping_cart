import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/core/bloc_provider.dart';
import 'package:flutter_shopping_cart/planet/planet_bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:flutter_shopping_cart/planet_detail/planet_detail_screen.dart';

class PlanetsScreen extends StatelessWidget {
  final bool isFullScreenDialog;
  const PlanetsScreen(
      {Key key,
      this.isFullScreenDialog = false,
      @required this.bloc,
      @required this.planets})
      : super(key: key);

  final PlanetBloc bloc;
  final List<Planet> planets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Where do you want to eat?'), actions: [
        IconButton(
            icon: StreamBuilder<bool>(
                stream: bloc.showFavoritesStream,
                builder: (context, snapshot) {
                  bool showFavorites = snapshot.data == true;
                  return Icon(
                      showFavorites ? Icons.favorite : Icons.favorite_border);
                }),
            onPressed: () {
              bloc.toggleShowFavorites();
            })
      ]),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter a planet'),

              // 3
              onChanged: (query) => bloc.query(query),
            ),
          ),
          // 4
          Expanded(
            child: _buildResults(planets),
          )
        ],
      ),
    );
  }

  Widget _buildResults(List<Planet> planets) {
    if (planets == null) {
      return Center(child: Text('Enter a planet'));
    }

    if (planets.isEmpty) {
      return Center(child: Text('No Results'));
    }

    return _buildSearchResults(planets);
  }

  Widget _buildSearchResults(List<Planet> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final planet = results[index];
        return ListTile(
          title: Text(planet.name),
          trailing: IconButton(
            onPressed: () {
              planet.favorite
                  ? bloc.removeFavorite(planet)
                  : bloc.addFavorite(planet);
            },
            icon:
                Icon(planet.favorite ? Icons.favorite : Icons.favorite_border),
          ),
          onTap: () {
            // 3
            final planetBloc = BlocProvider.of<PlanetBloc>(context);
            planetBloc.selectPlanet(planet);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlanetDetailScreen(planet: planet, bloc: bloc)),
            );
          },
        );
      },
    );
  }
}
