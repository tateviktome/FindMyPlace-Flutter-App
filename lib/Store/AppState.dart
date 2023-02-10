import 'package:meta/meta.dart';
import 'package:my_app/Models/PlaceImage.dart';
import '../Models/Place.dart';

@immutable
class AppState {
  final List<Place> places;
  final List<PlaceImage> placeImages;
  AppState(this.places, this.placeImages);

  AppState.initialState()
      : places = [],
        placeImages = [];
}
