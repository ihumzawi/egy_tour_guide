// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:egy_tour_guide/root.dart';
import 'package:egy_tour_guide/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class ForgetPassword extends StatefulWidget {
  static const String forgetPaswword = 'forgetPaswword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? _email ; 
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDebWhite,
      appBar: AppBar(
        backgroundColor: kDebWhite,
        elevation: 0,
        leading:GestureDetector(
          onTap: ()=> Navigator.of(context).pushReplacementNamed(WelcomeScreen.welcomeRoute),
          child: const Icon(Icons.arrow_back_ios,color: Colors.blue,)),
      ),
      body: SafeArea(
        
        child: Center(

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                
                    const MyText(
                      color: kBlack,
                      title: 'استرجاع كلمة المرور',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    const MyText(
                      title: 'سنقوم بأرسال رساله الي بريدك الاليكترونى لاسترجاع كلمة المرور',
                      color: kGray,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    MyTextField(
                      onChanged: (value){
                        setState(() {
                          _email = value ;
                        });
                      },
                      validator: (val) {
                        if (val.length > 30 || val.length < 7) {
                          return "لا يمكن ان يكون الايميل بهذا الحجم";
                        }

                        if (val.contains('@')) {
                          return null;
                        } else {
                          return 'يجب كتابه ايميل صحيح في هذا الحقل';
                        }
                      },
                      hint: 'أدخال بريدك الاليكترونى',
                      icon:  const Icon(Icons.email_outlined),
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      textInputType: TextInputType.emailAddress,
                    ),
                   const  SizedBox(
                      height: 20 ,
                    ),
                    MyButton(
                      onPressed: () async {
                        var formData = formState.currentState ;
                        if (formData!.validate()){
                         User? user = FirebaseAuth.instance.currentUser ;
                         
                        }else{

                        }
                      },
                      text: 'استرجاع كلمة المرور',
                      left: 30,
                      right: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
