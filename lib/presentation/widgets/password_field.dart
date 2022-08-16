import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'text_field_container.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController _passwordController;
  const PasswordField(
    this._passwordController,
  );

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        controller: _passwordController,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
