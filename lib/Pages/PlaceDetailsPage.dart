import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/Place.dart';
import 'package:my_app/Models/PlaceImage.dart';
import 'package:my_app/Store/AppState.dart';
import 'package:my_app/Store/ThunkActions.dart';
import 'package:redux/redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key, required this.place});

  final Place place;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place details"),
        ),
        body: StoreConnector<AppState, List<PlaceImage>>(
            onInit: (store) {
              store.dispatch(fetchPlaceImages(widget.place.id));
            },
            converter: (store) => store.state.placeImages,
            builder: (_, placeImages) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Text(widget.place.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(widget.place.description),
                  ),
                  getTextWidgets(placeImages)
                ],
              );
            }));
  }

  Widget getTextWidgets(List<PlaceImage> placeImages) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < placeImages.length; i++) {
      list.add(
          CachedNetworkImage(imageUrl: placeImages[i].urlString(), width: 260));
    }
    return SizedBox(
        height: 260,
        child: ListView(scrollDirection: Axis.horizontal, children: list));
  }
}
