import '../Models/Place.dart';
import '../Models/PlaceImage.dart';
import 'dart:convert';
import 'package:http/http.dart';

abstract class PlacesServiceInterface {
  Future<List<Place>> fetchPlaces(String type, String radius);
  Future<List<PlaceImage>> fetchPlaceDetails(String id);
}

class PlacesService extends PlacesServiceInterface {
  @override
  Future<List<Place>> fetchPlaces(String type, String radius) async {
    List<Place> places;
    Response response = await get(
        Uri.parse(
            'https://api.foursquare.com/v3/places/search?query=$type&radius=$radius'),
        headers: {
          "Accept": "application/json",
          "Authorization": "fsq3LmITbjy064nWLkOiY01nNygo5HxGfRQLoUCqayVv9hM="
        });
    if (response.statusCode == 200) {
      Map results = json.decode(response.body);
      List<dynamic> list = results['results'];
      places = list.map((e) => Place.fromJson(e)).toList();
    } else {
      places = <Place>[];
    }
    return places;
  }

  @override
  Future<List<PlaceImage>> fetchPlaceDetails(String id) async {
    List<PlaceImage> images;
    Response response = await get(
        Uri.parse('https://api.foursquare.com/v3/places/$id/photos'),
        headers: {
          "Accept": "application/json",
          "Authorization": "fsq3LmITbjy064nWLkOiY01nNygo5HxGfRQLoUCqayVv9hM="
        });
    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body);
      images = results.map((e) => PlaceImage.fromJson(e)).toList();
    } else {
      images = <PlaceImage>[];
    }
    return images;
  }
}
