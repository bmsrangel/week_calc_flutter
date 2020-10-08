import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final String hintText;
  final ValueChanged<String> validator;
  final bool enabled;
  final int maxLength;

  const CustomTextFieldWidget({
    Key key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.maxLength = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: TextFormField(
        controller: this.controller,
        focusNode: this.focusNode,
        textAlign: TextAlign.center,
        maxLength: this.maxLength,
        onChanged: this.onChanged,
        keyboardType: TextInputType.number,
        style:
            TextStyle(fontSize: 28.0, color: this.enabled ? null : Colors.grey),
        validator: this.validator,
        enabled: this.enabled,
        decoration: InputDecoration(
          hintText: this.hintText,
          hintStyle: TextStyle(fontSize: 28.0),
        ),
      ),
    );
  }
}
