import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_elevated_button.dart';
import 'package:todo_app/components/custom_text_form_field.dart';
import 'package:todo_app/styles/app_theme.dart';
import 'package:todo_app/styles/firebase_codes.dart';

import '../../constants.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  static const routeName = "register";

  GlobalKey<FormState> formKey = GlobalKey<FormState>() ;

  TextEditingController nameController = TextEditingController() ;

   TextEditingController emailController = TextEditingController() ;

   TextEditingController passwordController = TextEditingController() ;

   TextEditingController passwordVerificationController = TextEditingController() ;

   @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background.png'),
        ),
      ),
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Create Account",style: Theme.of(context).textTheme.titleMedium,),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: nameController,
                    validate: validateName,
                    label: "full Name",
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: height *.05,),
                  CustomTextFormField(
                    controller: emailController,
                    validate: validateEmail,
                    label: "email address",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height *.05,),
                  CustomTextFormField(
                    controller: passwordController,
                    validate: validatePassword,
                    isPassword:true,
                    label: "Password",
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  CustomTextFormField(
                    controller: passwordVerificationController,
                    validate: validatePasswordConfirm,
                    label: "Password confirmation",
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: height *.05,),
                  CustomElevatedButton(text: "Create Account", onClicked:(){
                    createAccount();

                  },)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 createAccount()async
 {

   if(formKey.currentState!.validate())
   {
     try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text,
       );
     } on FirebaseAuthException catch (e) {
       if (e.code == FirebaseCodes.weakPassword) {
         print('The password provided is too weak.');
       } else if (e.code ==FirebaseCodes.emailAlreadyInUse ) {
         print('The account already exists for that email.');
       }
     } catch (e) {
       print(e);
     }
     print("account created") ;
   }
 }

 String? validateName(String? value)
  {
    if(value == null || value.isEmpty)
      {
        return "field must not be empty" ;
      }
    else if (value.length <3)
      {
        return "must be a real name" ;
      }
    return null;
  }

   String? validateEmail(String? value)
   {
     if(value == null || value.isEmpty)
       {
         return "please enter your email" ;
       }
     else if(!isValidEmail(value))
       {
         return "Please Enter a Valid Email" ;
       }
     else
     return null;
   }

   String? validatePassword(String? value)
   {
     if(value== null || value.isEmpty)
       {
         return "enter password please " ;
       }
     else if (value.length<6)
       {
         return "weak password at least 6 characters" ;
       }
     return null;
   }

   String? validatePasswordConfirm(String? value)
   {
     if(value != passwordController.text){
       return "Not same password" ;
     }

     return null;
   }
}
