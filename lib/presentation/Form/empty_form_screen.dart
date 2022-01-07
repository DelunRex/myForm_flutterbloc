import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myform/presentation/component/form_field.dart';
import 'bloc/myform_bloc.dart';
import 'package:myform/presentation/Form/bloc/myform_state.dart';
import 'bloc/myform_event.dart';
import 'package:myform/data/constants/app_assets.dart';

class EmptyFormScreen extends StatefulWidget {
  static const String id = 'EmptyForm';
  const EmptyFormScreen({Key? key}) : super(key: key);

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
    controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (context, state) {
        if (state is MyFormSuccessState) {
          Future.delayed(const Duration(seconds: 1),
              () async => Navigator.of(context).pop());
          return _buildSuccessPage(context);
        } else if (state is MyFormErrorState) {
          return Center(
            child: Text('Oops how did you end up here!'),
          );
        } else {
          return _builAddBankDetailsWidget(context);
        }
      },
    );
  }

  Widget _builAddBankDetailsWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Form'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  CustomTextField(
                    controller: controllers[nameKey]!,
                    isEnabled: true,
                    headerText: 'Name',
                  ),
                  CustomTextField(
                    controller: controllers[addressKey]!,
                    isEnabled: true,
                    headerText: 'Address',
                  ),
                  CustomTextField(
                    controller: controllers[bankAccountNumKey]!,
                    isEnabled: true,
                    headerText: 'Account Number',
                  ),
                  CustomTextField(
                    controller: controllers[bankIfscCodeKey]!,
                    isEnabled: true,
                    headerText: 'IFSC Code',
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              var formData = controllers.map<String, String>(
                  (key, value) => MapEntry<String, String>(key, value.text));
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
