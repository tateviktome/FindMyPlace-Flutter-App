import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'Store/AppState.dart';
import 'Store/Reducers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final store = Store(reducer,
        initialState: AppState.initialState(), middleware: [thunkMiddleware]);

    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Find My Place'),
      ),
    );
  }
}
