import 'package:flutter_shopping_cart/core/bloc.dart';
import 'package:flutter_shopping_cart/planet/planet_model.dart';
import 'package:flutter_shopping_cart/planet/planet_query_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PlanetBloc implements Bloc {
  PlanetBloc();

  PlanetQueryBloc queryBloc = PlanetQueryBloc();

  final selectedPlanetController = BehaviorSubject<String>.seeded('');
  final favoritesController = BehaviorSubject<List<String>>.seeded([]);
  final showFavoritesController = BehaviorSubject<bool>.seeded(false);

  get favoritesStream => favoritesController.stream.startWith([]);
  Stream<bool> get showFavoritesStream => showFavoritesController.stream;

  get planetsStream => Rx.combineLatest3(
          queryBloc.planetStream, favoritesStream, showFavoritesStream,
          (List<Planet> planets, List<String> favorites, bool showFavorites) {
        for (var planet in planets) {
          planet.favorite = favorites.contains(planet.name);
        }

        return showFavorites
            ? planets.where((planet) => planet.favorite).toList()
            : planets;
      });

  get selectedPlanetStream =>
      Rx.combineLatest2(planetsStream, selectedPlanetController.stream,
          (List<Planet> planets, String selected) {
        return planets.firstWhere((element) => element.name == selected);
      });

  void query(String query) {
    return queryBloc.query(query);
  }

  void selectPlanet(Planet planet) {
    planet = planet;
    selectedPlanetController.sink.add(planet.name);
  }

  void toggleShowFavorites() {
    final showFavorites = showFavoritesController.value;
    showFavoritesController.sink.add(!showFavorites);
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
  void dispose() {
    selectedPlanetController.close();
    favoritesController.close();
    showFavoritesController.close();

    queryBloc.dispose();
  }
}
