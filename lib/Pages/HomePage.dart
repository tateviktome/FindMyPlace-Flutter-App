import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Store/AppState.dart';
import 'package:my_app/Store/ThunkActions.dart';
import 'package:redux/redux.dart';
import 'PlaceDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _typeController = TextEditingController();
  final _radiusController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    this._radiusController.dispose();
    this._typeController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _radiusController.text = "10000";
    _typeController.text = "coffee";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildTextFields(context),
            Expanded(child: _buildList(context))
          ],
        ));
  }

  Widget _buildTextFields(BuildContext context) {
    return StoreConnector<AppState, Store>(
        converter: (store) => store,
        builder: (_, store) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                      controller: _typeController,
                      onChanged: (value) => {
                            store.dispatch(
                                fetchPlaces(value, _radiusController.text))
                          },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "type")),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                      controller: _radiusController,
                      onChanged: (value) => {
                            store.dispatch(
                                fetchPlaces(_typeController.text, value))
                          },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "radius")),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildList(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onInit: (store) {
          store.dispatch(
              fetchPlaces(_typeController.text, _radiusController.text));
        },
        converter: (store) => store.state,
        builder: (_, state) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: state.places.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(color: Colors.transparent),
            itemBuilder: (context, index) {
              return ListTile(
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: Colors.black.withAlpha(10),
                  ),
                ),
                title: Text(state.places[index].name),
                subtitle: Text(state.places[index].description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlaceDetailsPage(place: state.places[index]),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
