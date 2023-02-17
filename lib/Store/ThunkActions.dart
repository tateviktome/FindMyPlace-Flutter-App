import '../Services/Services.dart';
import 'package:my_app/Store/Actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction fetchPlaces(String type, String radius) {
  return (Store store) async {
    final places =
        await Services.shared.placesService.fetchPlaces(type, radius);
    store.dispatch(FetchPlacesAction(places));
  };
}

ThunkAction fetchPlaceImages(String id) {
  return (Store store) async {
    final images = await Services.shared.placesService.fetchPlaceDetails(id);
    store.dispatch(FetchPlaceImagesAction(images));
  };
}
