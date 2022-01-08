import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class RouteState extends HomeState {
  final String route;
  const RouteState({
    required this.route,
  });

  @override
  List<Object?> get props => [route];
}
