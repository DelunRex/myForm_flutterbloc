import 'dart:io';

import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {
      emit(HomeState());
    });
    on<RouteEvent>((event, emit) {
      emit(RouteState(route: event.route));
    });
  }
}
