import 'package:flutter/material.dart';
import 'package:myform/domain/repositories/user_repository.dart';
import 'package:myform/presentation/Form/empty_form_screen.dart';
import 'package:myform/presentation/Form/filled_form_screen.dart';
import 'package:myform/presentation/Home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myform/presentation/Home/bloc/home_bloc.dart';
import 'package:myform/presentation/Form/bloc/myform_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute<HomeScreen>(
          builder: (context) => BlocProvider(
            create: (context) => HomeBloc(),
            child: HomeScreen(),
          ),
        );
      case EmptyFormScreen.id:
        return MaterialPageRoute<EmptyFormScreen>(
          builder: (context) => BlocProvider(
            create: (context) => MyFormBloc(
              userRepository: context.read<UserRepository>(),
              isEditing: true,
            ),
            child: EmptyFormScreen(),
          ),
        );
      case FilledFormScreen.id:
        return MaterialPageRoute<FilledFormScreen>(
          builder: (context) => BlocProvider(
            create: (context) => MyFormBloc(
              userRepository: context.read<UserRepository>(),
              isEditing: false,
            ),
            child: FilledFormScreen(),
          ),
        );
      default:
        return MaterialPageRoute<Widget>(
          builder: (_) => const Center(
            child: Text('Undefined Route'),
          ),
        );
    }
  }
}
