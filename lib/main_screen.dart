import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/bloc_provider.dart';
import 'package:flutter_shopping_cart/planet_bloc.dart';
import 'package:flutter_shopping_cart/planet_model.dart';
import 'package:flutter_shopping_cart/planet_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Planet>(
      // 1
      stream: BlocProvider.of<PlanetBloc>(context).planetStream,
      builder: (context, snapshot) {
        final planet = snapshot.data;

        // 2
        if (planet == null) {
          return PlanetsScreen();
        }

        // This will be changed this later
        return Container();
      },
    );
  }
}
