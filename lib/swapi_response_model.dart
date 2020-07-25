class SwapiResponse<T> {
  int count;
  List<T> results;

  SwapiResponse({this.count, this.results});

  factory SwapiResponse.fromJson(Map<String, dynamic> json) {
    return SwapiResponse(
      count: json['count'],
      results: json['results'],
    );
  }
}
