import 'package:my_app/Models/PlaceImage.dart';

import '../Models/Place.dart';

class FetchPlacesAction {
  final List<Place> places;

  FetchPlacesAction(this.places);
}

class FetchPlaceImagesAction {
  final List<PlaceImage> images;

  FetchPlaceImagesAction(this.images);
}
