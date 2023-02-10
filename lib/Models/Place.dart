class Place {
  final String id;
  final String name;
  final String description;

  Place(this.name, this.description, this.id);

  factory Place.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> location = json['location'];
    return Place(json['name'], location['formatted_address'], json['fsq_id']);
  }
}
