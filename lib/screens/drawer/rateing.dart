import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../taps.dart';
import '../../widgets/form_widgets/my_button.dart';
import '../../widgets/form_widgets/my_text_field.dart';
import '../../widgets/my_text.dart';

class RateingScreen extends StatefulWidget {
  const RateingScreen({ Key? key }) : super(key: key);

  @override
  State<RateingScreen> createState() => _RateingScreenState();
}

class _RateingScreenState extends State<RateingScreen> {
TextEditingController controller = TextEditingController();
   // ignore: unused_field
   String _uid = '';
  String _mail = '';
  void gitUserId() {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    _uid = user!.uid;
    _mail = user.email! ;
  }

  @override
  void initState() {
    gitUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Constant.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('قيم البرنامج'),
        centerTitle: true,
      ),
      body:SingleChildScrollView (child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildSectionTitle(context , 'قيم البرنامج'),
              
               textFormField(
                      onTapInk: () {},
                      ktitle: 'البريد الذي سوف يتم ارسال الرد علية',
                      valueKey: 'gid',
                      hint: _mail,
                      isIconVisiblePrefix: true,
                    ),
                     textFormField(
                        onTapInk: () {},
                        ktitle: 'اكتب تقيمك',
                        valueKey: 'description',
                        hint: 'اجعل رئيك بناء',
                        controller: controller,
                        maxLines: 4,
                        maxLength: 250,
                        enabledBorderRadius: false),
                        const SizedBox(height: 20,),
                         MyButton(
                isVsabilIcon: true,
                text: 'ارسال',
                onPressed: () {
                  try {
                    if (controller.text.length >= 10) {
                     
                     AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        //  title: 'هل انت واثق من تسجيل الخروج ؟',
                        desc:
                            'تم الارسال بنجاح شكرا علي تقيمك',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          Navigator.of(context)
                              .pushReplacementNamed(TapsScreen.tapsRoute);
                        },
                      ).show();
                      controller.text = '' ;
                    } else {
                      // ignore: avoid_single_cascade_in_expression_statements
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        //  title: 'هل انت واثق من تسجيل الخروج ؟',
                        desc:
                            'برجاء كتابه تعليق عشرة حروف او اكثر .',
                       
                      )..show();
                    }
                    
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icons.send,
              )
          ],
        ),
      )) ,
    );
  }

    Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

   Column textFormField({
    required String valueKey,
    required String hint,
    required String ktitle,
     TextEditingController? controller,
    required VoidCallback onTapInk,
    bool enabled = true,
    bool enabledBorderRadius = true,
    bool isIconVisiblePrefix = false,
    int maxLines = 1,
    int maxLength = 25,
  }) =>
      Column(
        children: [
          kTitle(ktitle),
          InkWell(
            onTap: onTapInk,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyTextField(
                 icon: const Icon(Icons.email_rounded),
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل مطلوب';
                  }
                  return null;
                },
                enabledBorderRadius: enabledBorderRadius,
                isIconVisiblePrefix: isIconVisiblePrefix,
                hint: hint,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                enabled: enabled,
                isKey: ValueKey(valueKey),
                maxLines: maxLines,
                maxLength: maxLength,
              ),
            ),
          ),
        ],
      );

  Padding kTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 20),
      child: Row(
        children: [
          MyText(
            title: title,
            color: const Color.fromARGB(255, 101, 101, 101),
          ),
          const Text(
            ' *',
            style: TextStyle(color: Colors.red, fontSize: 20),
          )
        ],
      ),
    );
  }
}