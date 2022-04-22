import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/screens/screens.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// ignore: use_key_in_widget_constructors
class CreatAccount extends StatefulWidget {
  static const String creatRoute = 'Creat';

  @override
  State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool visblty = true;
  bool visbltyConferm = true;
  bool obpass = true;
  bool obpassConferm = true;
  File? imageFile;
  String? url;
  bool _isLoading = false;
  final TextEditingController _passward = TextEditingController();
  final TextEditingController _confermPassward = TextEditingController();
  // ignore: prefer_final_fields
  late TextEditingController _fullNameController =
      TextEditingController(text: '');
  // ignore: prefer_final_fields
  late TextEditingController _myemailController =
      TextEditingController(text: '');
  // ignore: prefer_final_fields
  late TextEditingController _mypasswordController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _fullNameController.dispose();
    _myemailController.dispose();
    _mypasswordController.dispose();
    super.dispose();
  }

  void _pickedImageWhithCamera() async {
    PickedFile? picedFile = await ImagePicker()
        // ignore: deprecated_member_use
        .getImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    // setState(() {
    //   imageFile = File(picedFile!.path);
    // });
    cropImage(picedFile!.path);
    Navigator.of(context).pop();
  }

  void _pickedImageWhithgallery() async {
    PickedFile? picedFile = await ImagePicker()
        // ignore: deprecated_member_use
        .getImage(source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);

    cropImage(picedFile!.path);
    Navigator.of(context).pop();
  }

  void _showImageDiloge() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const MyText(
              title: 'من فضلك اختار طريقة انشاء صورة :',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _pickedImageWhithCamera,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera,
                        color: kBlue,
                      ),
                      MyText(
                        title: 'الكاميرا',
                        color: kBlue,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                InkWell(
                  onTap: _pickedImageWhithgallery,
                  child: Row(
                    children: const [
                      Icon(Icons.image, color: kBlue),
                      MyText(
                        title: 'معرض الصور',
                        color: kBlue,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void cropImage(filePath) async {
    File? cropImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1)
    );

    if (cropImage != null) {
      setState(() {
        imageFile = cropImage;
      });
    }
  }

  signIn() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (imageFile == null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          btnOkOnPress: () {},
          body: const MyText(title: 'برجاء اختيار صورة'),
        ).show();
      }
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _myemailController.text.toLowerCase().trim(),
                password: _mypasswordController.text.trim());
        final User? _user = FirebaseAuth.instance.currentUser;
        final _uid = _user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(_uid + '.jpg');
        await ref.putFile(imageFile!);
        url = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _myemailController.text,
          'userImageURL': url,
          'isAdmin': false,
          'createdAd': Timestamp.now(),
        });
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                   btnOkOnPress: () {},
                  body: const MyText(title: 'كلمه المرور ضعيفه جدا'))
              .show();
          // ignore: avoid_print
          print('The password provided is too weak.');
          setState(() {
            _isLoading = false;
          });
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              btnOkOnPress: () {},
              body: const MyText( title :
                'هذا الايميل مستعمل من قبل يمكنك الضغط علي تسجيل الدخول وتسجيل الدخول بحسابك',
                textAlign: TextAlign.center,
              )).show();

          // ignore: avoid_print
          print('The account already exists for that email.');
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e);
        print('===========');
      }
    } else {
      print('not valide');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDebWhite,
      appBar: AppBar(
        backgroundColor: kDebWhite,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        const MyText(
                          color: kBlack,
                          title: "هيا بنا نبدأ!",
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        const MyText(
                          title: "انشاء حساب يجعلك تحصل علي حميع المميزات",
                          color: kGray,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: kBlue),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: imageFile == null
                                    ? Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        imageFile!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _showImageDiloge();
                                print('show image');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 2, color: kBlue),
                                  shape: BoxShape.circle,
                                ),
                                child: imageFile == null
                                    ? const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 18,
                                            color: kBlue,
                                          ),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: kBlue,
                                      ),
                              ),
                            )
                          ],
                        ),
                        MyTextField(
                          autofocus: true,
                          controller: _fullNameController,
                          hint: 'ادخل الاسم ',
                          icon: const Icon(Icons.person),
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          onChanged: (v) {
                            print('full name : ${_fullNameController.text}');
                          },
                        ),
                        MyTextField(
                            autofocus: true,
                            onSaved: (value) {
                              _myemailController.text = value;
                            },
                            validator: (val) {
                              if (val.length > 50 || val.length < 7) {
                                return "لا يمكن ان يكون الايميل بهذا الحجم";
                              }

                              if (val.contains('@')) {
                                return null;
                              } else {
                                return 'يجب كتابه ايميل صحيح في هذا الحقل';
                              }
                            },
                            hint: 'البريد الالكترونى',
                            icon: const Icon(Icons.email_outlined),
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next),
                        MyTextField(
                          contentpading: const EdgeInsets.only(
                              top: 12, left: 15, bottom: 12, right: 15),
                          controller: _passward,
                          validator: (val) {
                            if (val.length > 30 || val.length < 4) {
                              return "لا يمكن ان تكون كلمه المرور بهذا الحجم";
                            } else {
                              return null;
                            }
                          },
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
                          hint: 'كلمه المرور',
                          icon: const Icon(Icons.lock_outline),
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: obpass,
                        ),
                        MyTextField(
                          contentpading: const EdgeInsets.only(
                              top: 12, left: 15, bottom: 12, right: 15),
                          suffix: InkWell(
                            child: visbltyConferm
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.blue,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: Colors.blue),
                            onTap: () {
                              setState(() {
                                obpassConferm = !obpassConferm;
                                visbltyConferm = !visbltyConferm;
                              });
                            },
                          ),
                          onSaved: (value) {
                            _mypasswordController.text = value;
                          },
                          controller: _confermPassward,
                          validator: (val) {
                            if (val.length > 30 || val.length < 4) {
                              return "لا يمكن ان تكون كلمه المرور بهذا الحجم";
                            }
                            if (_passward.text != _confermPassward.text) {
                              return "كلمه المرور غير متطابقة";
                            } else {
                              return null;
                            }
                          },
                          hint: 'تأكيد كلمة المرور',
                          icon: const Icon(Icons.lock_outline),
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: visbltyConferm,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : MyButton(
                                onPressed: () async {
                                  UserCredential respon = await signIn();
                                  // ignore: avoid_print
                                  print('===========');

                                  // ignore: unnecessary_null_comparison
                                  if (respon != null) {
                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    if (user != null && !user.emailVerified) {
                                      await user.sendEmailVerification();
                                    }
                                    // ignore: avoid_print
                                    print(respon.user!.email);
                                    Navigator.of(context).pushReplacementNamed(
                                        WelcomeScreen.welcomeRoute);
                                    // ignore: avoid_single_cascade_in_expression_statements
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        btnOkOnPress: () {},
                                        body: Column(
                                          children: [
                                            const MyText(
                                                title:
                                                    ' تم التسجيل بنجاح برجاء تفعيل الحساب'),
                                            const MyText(
                                                title:
                                                    ' تم ارسال رساله الي برديك'),
                                            // ignore: unnecessary_string_interpolations
                                            MyText(
                                                title:
                                                    _myemailController.text.trim().toLowerCase()),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ))
                                      ..show();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else {
                                    // ignore: avoid_print
                                    print('signUp field');
                                  }
                                  // ignore: avoid_print
                                  print('===========');
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                isVsabilIcon: true,
                                icon: Icons.app_registration_rounded,
                                text: 'انشاء حساب',
                                left: 40,
                                right: 40,
                                width: 200,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MyText(
                              title: "هل لديك حساب بالفعل ؟",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                              color: kBlack,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    WelcomeScreen.welcomeRoute);
                              },
                              child: const MyText(
                                  title: 'تسجيل الدخول', fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
