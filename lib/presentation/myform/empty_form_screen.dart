import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals.dart';
import '../component/form_field.dart';
import 'bloc/myform_bloc.dart';
import 'bloc/myform_event.dart';
import 'bloc/myform_state.dart';

class EmptyFormScreen extends StatefulWidget {
  const EmptyFormScreen({Key? key}) : super(key: key);
  static const String id = 'emptyForm';

  @override
  _EmptyFormScreenState createState() => _EmptyFormScreenState();
}

class _EmptyFormScreenState extends State<EmptyFormScreen> {
  late final Map<String, TextEditingController> controllers;

  @override
  void initState() {
    controllers = <String, TextEditingController>{
      nameKey: TextEditingController(),
      addressKey: TextEditingController(),
      bankAccountNumKey: TextEditingController(),
      bankIfscCodeKey: TextEditingController(),
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
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (BuildContext context, MyFormState state) {
        if (state is MyFormSuccessState) {
          Future<void>.delayed(const Duration(seconds: 1),
              () async => Navigator.of(context).pop());
          return _buildSuccessPage(context);
        }
        return _builAddBankDetailsWidget(context, state);
      },
    );
  }

  Widget _builAddBankDetailsWidget(BuildContext context, MyFormState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Form'),
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
                    isEnabled: true,
                    headerText: 'Name',
                    errorText: (state is MyFormErrorState)
                        ? state.errorMap[nameKey]
                        : null,
                  ),
                  CustomTextField(
                    controller: controllers[addressKey]!,
                    isEnabled: true,
                    headerText: 'Address',
                    errorText: (state is MyFormErrorState)
                        ? state.errorMap[addressKey]
                        : null,
                  ),
                  CustomTextField(
                    controller: controllers[bankAccountNumKey]!,
                    isEnabled: true,
                    headerText: 'Account Number',
                    errorText: (state is MyFormErrorState)
                        ? state.errorMap[bankAccountNumKey]
                        : null,
                  ),
                  CustomTextField(
                    controller: controllers[bankIfscCodeKey]!,
                    isEnabled: true,
                    headerText: 'IFSC Code',
                    errorText: (state is MyFormErrorState)
                        ? state.errorMap[bankIfscCodeKey]
                        : null,
                  ),
                ],
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
              'Submit',
              style: TextStyle(
                color: Colors.deepPurple[50],
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessPage(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Form submitted successfully!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
