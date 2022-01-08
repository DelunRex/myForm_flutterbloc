import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.isEnabled,
    required this.headerText,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isEnabled;
  final String headerText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(
          headerText,
          style: isEnabled
              ? Theme.of(context).textTheme.headline4
              : Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyText1,
          enabled: isEnabled,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              hintStyle: Theme.of(context).textTheme.subtitle1,
              hintText: hintText,
              errorStyle: Theme.of(context).textTheme.overline,
              errorMaxLines: 3,
              filled: !isEnabled,
              fillColor: !isEnabled ? const Color(0xFFF3F3F5) : null,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF007EFA)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF007EFA)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),
      ],
    );
  }
}
