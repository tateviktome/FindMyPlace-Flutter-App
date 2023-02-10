import 'AppState.dart';
import 'Reducers.dart';
import 'package:redux/redux.dart';

final Store<AppState> store = Store<AppState>(reducer, initialState: AppState.initialState());