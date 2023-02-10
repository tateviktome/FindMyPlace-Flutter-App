import 'dart:convert';

import 'package:my_app/Models/PlaceImage.dart';
import 'package:my_app/Store/Actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../Models/Place.dart';
import 'package:http/http.dart';

ThunkAction fetchPlaces(String type, String radius) {
  return (Store store) async {
    List<Place> places;
    try {
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
    } catch (e) {
      return;
    }
    store.dispatch(FetchPlacesAction(places));
  };
}

ThunkAction fetchPlaceImages(String id) {
  return (Store store) async {
    List<PlaceImage> images;

    try {
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
    } catch (e) {
      return;
    }

    store.dispatch(FetchPlaceImagesAction(images));
  };
}
