class Planet {
  String climate;
  String diameter;
  String gravity;
  String name;
  String orbital_period;
  String population;
  String terrain;

  Planet(
      {this.climate,
      this.diameter,
      this.gravity,
      this.name,
      this.orbital_period,
      this.population,
      this.terrain});

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      climate: json['climate'],
      diameter: json['diameter'],
      gravity: json['gravity'],
      name: json['name'],
      orbital_period: json['orbital_period'],
      population: json['population'],
      terrain: json['terrain'],
    );
  }
}
