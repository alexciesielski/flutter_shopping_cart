import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';

typedef void PlanetCallback(Planet planet);

class PlanetTile extends StatelessWidget {
  const PlanetTile({Key key, @required this.planet, @required this.onFavorited})
      : super(key: key);

  final Planet planet;
  final PlanetCallback onFavorited;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(planet.name),
                subtitle: Text("Population " + planet.population)),
            ButtonBar(children: <Widget>[
              FlatButton(
                child: Icon(
                    planet.favorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  onFavorited(planet);
                },
              )
            ])
          ])),
    );
  }
}
