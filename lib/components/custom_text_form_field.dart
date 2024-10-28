import 'package:flutter/material.dart';
typedef validator =String? Function(String?) ;
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {super.key,
      required this.label,
      required this.keyboardType,
      this.isPassword = false,
        required this.validate,
        required this.controller,
      });
  validator validate;
  String label;
  TextInputType keyboardType;
  bool isPassword;
  TextEditingController controller = TextEditingController() ;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:widget.controller,
      obscuringCharacter: "*",
      obscureText:widget.isPassword == true? isObscure:false,
      validator:widget.validate ,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 18),
      decoration: InputDecoration(
        suffixIcon:widget.isPassword? IconButton(
          onPressed: (){
            isObscure=!isObscure;
            setState(() {

            });
          },
          icon:isObscure? Icon(Icons.visibility_off,  color: Theme.of(context).colorScheme.primary,
            size: 30,):Icon(
          Icons.visibility,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
        ):null,
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
