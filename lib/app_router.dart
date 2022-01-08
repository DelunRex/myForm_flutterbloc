import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repositories/user_repository.dart';
import 'presentation/Form/bloc/myform_bloc.dart';
import 'presentation/Form/empty_form_screen.dart';
import 'presentation/Form/filled_form_screen.dart';
import 'presentation/Home/bloc/home_bloc.dart';
import 'presentation/Home/home_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute<HomeScreen>(
          builder: (BuildContext context) => BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
            child: const HomeScreen(),
          ),
        );
      case EmptyFormScreen.id:
        return MaterialPageRoute<EmptyFormScreen>(
          builder: (BuildContext context) => BlocProvider<MyFormBloc>(
            create: (BuildContext context) => MyFormBloc(
              userRepository: context.read<UserRepository>(),
              isEditing: true,
            ),
            child: const EmptyFormScreen(),
          ),
        );
      case FilledFormScreen.id:
        return MaterialPageRoute<FilledFormScreen>(
          builder: (BuildContext context) => BlocProvider<MyFormBloc>(
            create: (BuildContext context) => MyFormBloc(
              userRepository: context.read<UserRepository>(),
              isEditing: false,
            ),
            child: const FilledFormScreen(),
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
