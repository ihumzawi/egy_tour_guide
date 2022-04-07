import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/screens/profile/profile_screen.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_button.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_text_field.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class EditProfile extends StatefulWidget {
  static const String route = 'EditProfile';

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _uid = '';
  void gitUserId() {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    _uid = user!.uid;
  }

  @override
  void initState() {
    gitUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Constant.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(ProfileScreen.route);
            },
            icon: const Icon(Icons.arrow_back_ios),
          );
        }),
        title: const Text('تعديل معلومات المستخدم'),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const MyText(),
              const MyText(title: 'تعديل الاسم'),
              MyTextField(
                controller: _nameController,
                hint: 'تعديل الاسم',
                icon: const Icon(Icons.person),
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
              ),
               const SizedBox(
                height: 20.0,
              ),
              MyButton(
                isVsabilIcon: true,
                text: 'حفظ',
                onPressed: () {
                  try {
                    if (_nameController.text.length >= 4) {
                      DocumentReference docRefUser = FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid);
                      docRefUser.update({
                        'name': _nameController.text,
                      });
                       // ignore: avoid_single_cascade_in_expression_statements
                     AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        //  title: 'هل انت واثق من تسجيل الخروج ؟',
                        desc:
                            'تمت العمليه بنجاح اضغط موافق للخروج',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          Navigator.of(context)
                              .pushReplacementNamed(ProfileScreen.route);
                        },
                      )..show();
                      _nameController.text = '' ;
                    } else {
                      // ignore: avoid_single_cascade_in_expression_statements
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        //  title: 'هل انت واثق من تسجيل الخروج ؟',
                        desc:
                            'برجاء كتابه اسم صحيح يتكون من اربعه حروف او اكثر .',
                       
                      )..show();
                    }
                    
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icons.save,
              )
            ],
          ),
        ),
      ),
    );
  }
}
