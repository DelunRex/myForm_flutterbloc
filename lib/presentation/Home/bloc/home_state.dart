import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => <Object?>[];
}

class RouteState extends HomeState {
  const RouteState({
    required this.route,
  });
  final String route;

  @override
  List<Object?> get props => <Object?>[route];
}
