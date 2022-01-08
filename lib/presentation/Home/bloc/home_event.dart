import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class RouteEvent extends HomeEvent {
  final String route;
  const RouteEvent({
    required this.route,
  });

  @override
  List<Object?> get props => [route];
}
