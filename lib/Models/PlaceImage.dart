import 'package:my_app/Models/Place.dart';

class PlaceImage {
  final String prefix;
  final String suffix;

  PlaceImage(this.suffix, this.prefix);

  factory PlaceImage.fromJson(Map<String, dynamic> json) {
    return PlaceImage(json['suffix'], json['prefix']);
  }

  String urlString() {
    return prefix + "original" + suffix;
  }
}
