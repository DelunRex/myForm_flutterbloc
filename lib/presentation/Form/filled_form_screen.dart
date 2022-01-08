import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/constants/app_assets.dart';
import '../../domain/repositories/user_repository.dart';
import '../component/form_field.dart';
import 'bloc/myform_bloc.dart';
import 'bloc/myform_event.dart';
import 'bloc/myform_state.dart';

class FilledFormScreen extends StatefulWidget {
  const FilledFormScreen({Key? key}) : super(key: key);
  static const String id = 'FilledForm';

  @override
  _FilledFormScreenState createState() => _FilledFormScreenState();
}

class _FilledFormScreenState extends State<FilledFormScreen> {
  late final Map<String, TextEditingController> controllers;

  @override
  void initState() {
    final UserRepository repo = context.read<UserRepository>();
    controllers = <String, TextEditingController>{
      nameKey: TextEditingController(
        text: repo.currentUser.name,
      ),
      addressKey: TextEditingController(
        text: repo.currentUser.address,
      ),
      bankAccountNumKey: TextEditingController(
        text: repo.currentUser.bankAccountNum,
      ),
      bankIfscCodeKey: TextEditingController(
        text: repo.currentUser.bankIfscCode,
      ),
    };
    super.initState();
  }

  @override
  void dispose() {
    controllers.forEach((String key, TextEditingController value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserRepository repo = context.read<UserRepository>();
    return BlocConsumer<MyFormBloc, MyFormState>(
      listener: (BuildContext context, MyFormState state) {
        if (state is MyFormSuccessState) {
          context.read<MyFormBloc>().add(const MyFormSaveEvent());
        }
        if (!state.isEditing) {
          controllers[nameKey]!.text = repo.currentUser.name!;
          controllers[bankAccountNumKey]!.text =
              repo.currentUser.bankAccountNum!;
          controllers[addressKey]!.text = repo.currentUser.address!;
          controllers[bankIfscCodeKey]!.text = repo.currentUser.bankIfscCode!;
        }
      },
      builder: (BuildContext context, MyFormState state) {
        if (state is MyFormErrorState) {
          return const Center(
            child: Text('Oops how did you end up here!'),
          );
        } else {
          return _builBankDetailsWidget(context, state);
        }
      },
    );
  }

  Widget _builBankDetailsWidget(BuildContext context, MyFormState state) {
    return Scaffold(
      appBar: AppBar(
        title:
            state.isEditing ? const Text('Edit Form') : const Text('Your Form'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  CustomTextField(
                    controller: controllers[nameKey]!,
                    isEnabled: state.isEditing,
                    headerText: 'Name',
                  ),
                  CustomTextField(
                    controller: controllers[addressKey]!,
                    isEnabled: state.isEditing,
                    headerText: 'Address',
                  ),
                  CustomTextField(
                    controller: controllers[bankAccountNumKey]!,
                    isEnabled: state.isEditing,
                    headerText: 'Account Number',
                  ),
                  CustomTextField(
                    controller: controllers[bankIfscCodeKey]!,
                    isEnabled: state.isEditing,
                    headerText: 'IFSC Code',
                  ),
                ],
              ),
            ),
          ),
          if (state.isEditing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    context.read<MyFormBloc>().add(
                          const MyFormSaveEvent(),
                        );
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
                    'Cancel',
                    style: TextStyle(
                      color: Colors.deepPurple[50],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final Map<String, String> formData =
                        controllers.map<String, String>(
                            (String key, TextEditingController value) =>
                                MapEntry<String, String>(key, value.text));
                    context
                        .read<MyFormBloc>()
                        .add(MyFormSubmitEvent(formData: formData));
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
                    'Save',
                    style: TextStyle(
                      color: Colors.deepPurple[50],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            )
          else
            const SizedBox(
              height: 0,
            )
        ],
      ),
      floatingActionButton: !state.isEditing
          ? FloatingActionButton(
              onPressed: () {
                context.read<MyFormBloc>().add(const MyFormEditingEvent());
              },
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}
