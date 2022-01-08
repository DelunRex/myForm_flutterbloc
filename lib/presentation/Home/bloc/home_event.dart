import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => <Object?>[];
}

class RouteEvent extends HomeEvent {
  const RouteEvent({
    required this.route,
  });
  final String route;

  @override
  List<Object?> get props => <Object?>[route];
}
