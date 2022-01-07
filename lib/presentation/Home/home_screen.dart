import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myform/domain/models/user_model.dart';
import 'package:myform/domain/repositories/user_repository.dart';
import 'package:myform/presentation/Form/empty_form_screen.dart';
import 'package:myform/presentation/Form/filled_form_screen.dart';
import 'package:myform/presentation/Home/bloc/home_bloc.dart';
import 'package:myform/presentation/Home/bloc/home_state.dart';
import 'package:myform/presentation/Home/bloc/home_event.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user =
        User(name: '', address: '', bankAccountNum: '', bankIfscCode: '');
    UserRepository repository = context.read<UserRepository>();
    if (!repository.isUserLoggedIn) {
      repository.registerUser(user);
    }
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is RouteState) {
          Navigator.of(context)
              .pushNamed(state.route)
              .then((value) => context.read<HomeBloc>().add(
                    HomeEvent(),
                  ));
        }
      },
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              var route = context.read<UserRepository>().isFormDetailsSaved
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
