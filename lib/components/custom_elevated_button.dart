import 'package:flutter/material.dart';
typedef authFunction = void Function() ;
class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton({super.key,required this.text,required this.onClicked});
  String text;
  authFunction onClicked;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
      onPressed: onClicked, child:  Row(
      children: [
        Text(text,style:const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        const Spacer(),
        const Icon(Icons.arrow_forward,color: Colors.white,),
      ],
    ),);
  }
}
