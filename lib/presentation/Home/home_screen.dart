import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../myform/empty_form_screen.dart';
import '../myform/filled_form_screen.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    final User user =
        User(name: '', address: '', bankAccountNum: '', bankIfscCode: '');
    final UserRepository repository = context.read<UserRepository>();
    if (!repository.isUserLoggedIn) {
      repository.registerUser(user);
    }
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is RouteState) {
          Navigator.of(context)
              .pushNamed(state.route)
              .then((Object? value) => context.read<HomeBloc>().add(
                    const HomeEvent(),
                  ));
        }
      },
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              final String route =
                  context.read<UserRepository>().isFormDetailsSaved
                      ? FilledFormScreen.id
                      : EmptyFormScreen.id;
              context.read<HomeBloc>().add(RouteEvent(route: route));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: Text(
              'Your Details',
              style: TextStyle(
                color: Colors.deepPurple[50],
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
