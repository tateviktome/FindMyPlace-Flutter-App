import 'PlacesService.dart';

class Services {
  static final shared = Services();
  final PlacesService placesService;

  Services() : placesService = PlacesService();
}
