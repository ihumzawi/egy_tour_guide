// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:egy_tour_guide/screens/auth/forget_password.dart';
import 'package:egy_tour_guide/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';

import '../../taps.dart';

// ignore: use_key_in_widget_constructors
class WelcomeScreen extends StatefulWidget {
  static const String welcomeRoute = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var myemail, mypassword;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // TextEditingController _emailController = TextEditingController(text: 'ihumzawi@gmail.com');
  // TextEditingController _passController = TextEditingController(text: '199594');
  signIn() async {
    var formData = formState.currentState;

    if (formData!.validate()) {
      formData.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);

        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // ignore: avoid_print
          print('No user found for that email.');
          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            body: Center(
              child: Column(
                children: [
                  const Text('هذا الايميل '),
                  Text(myemail),
                  const Text('غير مسجل من قبل'),
                ],
              ),
            ),
          )..show();
        } else if (e.code == 'wrong-password') {
          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            body: const Center(
              child: Text('كلمه المرور غير صحيحه'),
            ),
          )..show();
          // ignore: avoid_print
          print('Wrong password provided for that user .');
        }
      }
    } else {
      // ignore: avoid_print
      print('Log in filed');
    }
  }

  bool visblty = true;

  bool obpass = true;

  late String email;
  late String password;
  late UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDebWhite,
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
                    Image.asset(
                      "assets/images/logo-welcome.png",
                      height: 180.0,
                    ),
                    const MyText(
                      color: kBlack,
                      title: 'أهلا بك',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    const MyText(
                      title: 'ادخل الي حسابك او قم بتسجيل حساب جديد',
                      color: kGray,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    // emali input fild
                    MyTextField(
                    
                      // controller: _emailController,
                      onSaved: (value) {
                       myemail = value;
                      //  _emailController.text = value;
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
                      
                      icon: const Icon(Icons.person_outline),
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      textInputType: TextInputType.emailAddress,
                      
                    ),
                    // password input fild
                    MyTextField(
                      // controller: _passController,
                      validator: (val) {
                        if (val.length > 30 || val.length < 4) {
                          return "لا يمكن ان تكون كلمه المرور بهذا الحجم";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                       mypassword = value;
                        // _passController.text = value;
                      },
                      contentpading: const EdgeInsets.only(
                          top: 12, left: 15, bottom: 12, right: 15),
                      suffix: InkWell(
                        child: visblty
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              )
                            : const Icon(Icons.visibility_off,
                                color: Colors.blue),
                        onTap: () {
                          setState(() {
                            obpass = !obpass;
                            visblty = !visblty;
                          });
                        },
                      ),
                      hint: "ادخل كلمة السر",
                      icon: const Icon(Icons.lock_outline),
                      obscureText: obpass,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                ForgetPassword.forgetPaswword);
                          },
                          child: const MyText(
                            title: 'نسيت كلمة المرور ؟',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            //  userCredential = await FirebaseAuth.instance.signInAnonymously();

                            //  print(userCredential);
                          },
                          // ignore: prefer_const_constructors

                          child: const MyText(
                            title: 'الدخول كازائر',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                            color: kBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButton(
                      onPressed: () async {
                        UserCredential response = await signIn();
                        // ignore: unnecessary_null_comparison
                        if (response != null) {
                          debugPrint("+++++++++++++++++++++++++++++++");
                          // ignore: avoid_print
                          print(response);
                          // ignore: avoid_print
                          print("+++++++++++++++++++++++++++++++");
                          debugPrint(response.user!.email);
                          if (response.user!.emailVerified) {
                            Navigator.of(context).pushReplacementNamed(
                                TapsScreen.tapsRoute);
                          } else {
                            // ignore: avoid_single_cascade_in_expression_statements
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.INFO,
                              body: Center(
                                child: Column(
                                  children: [
                                    const Text('ايميل لم يتم التحقق منه'),
                                    Text(myemail),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                        'برجاء تفعيل الاميل ثم المحاوله مرة اخري'),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                  ],
                                ),
                              ),
                            )..show();
                          }
                        }
                      },
                      textIcon: " ",
                      text: 'تسجيل الدخول',
                      left: 30,
                      right: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MyText(
                          title: "ليس لديك حساب ؟",
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: kBlack,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(CreatAccount.creatRoute);
                          },
                          child: const Text(
                            'سجل حساب جديد',
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'ElMessiri'),
                          ),
                        )
                      ],
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
