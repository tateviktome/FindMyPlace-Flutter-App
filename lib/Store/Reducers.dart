import 'Actions.dart';
import 'AppState.dart';

AppState reducer(previousState, action) {
  if (action is FetchPlacesAction) {
    return AppState(action.places, previousState.placeImages);
  } else if (action is FetchPlaceImagesAction) {
    return AppState(previousState.places, action.images);
  }
  return previousState;
}
