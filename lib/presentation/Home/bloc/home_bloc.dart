import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((HomeEvent event, Emitter<HomeState> emit) {
      emit(const HomeState());
    });
    on<RouteEvent>((RouteEvent event, Emitter<HomeState> emit) {
      emit(RouteState(route: event.route));
    });
  }
}
