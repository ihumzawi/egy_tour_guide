import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/constant/constant.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../taps.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// ignore: library_prefixes
import 'package:path/path.dart' as Path;

class AddAdsScreen extends StatefulWidget {
  const AddAdsScreen({Key? key}) : super(key: key);

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  String? userName;
  String? userImageURL;
  bool uploading = false;
  bool isDisableImageButton = false;
  bool isDisableTextInput = true;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  // ignore: prefer_final_fields
  List<File> _image = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final addId = const Uuid().v4();

  // text Editing Controller
  
  TextEditingController locationController =
      TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _adsFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
    imgRef = FirebaseFirestore.instance.collection('ads');
  }

  void getData() async {
    try {
      User? user = _auth.currentUser;
      String _uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          userImageURL = userDoc.get('userImageURL');
          userName = userDoc.get('name');
        });
      }
    } catch (err) {
      print('------------------errer ------------');
      print(err);
    } finally {}
    print('$userImageURL ____________________________');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Constant.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
            },
            icon: const Icon(Icons.arrow_back_ios),
          );
        }),
        title: const Text('اضف اعلان'),
        centerTitle: true,
      ),
      body: Form(
        key: _adsFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ksliverGrid(),
              textFormField(
                onTapInk: () {},
                ktitle: 'عنوان الاعلان',
                valueKey: 'title',
                hint: 'اكتب عنوان الاعلان ',
                enabled: isDisableTextInput,
                controller: titleController,
              ),
              textFormField(
                onTapInk: () {},
                ktitle: 'رقم الهاتف',
                valueKey: 'phone',
                hint: 'رقم الهاتف للتواصل علي الهاتف و الواتس اب ',
                controller: phoneController,
                 enabled: isDisableTextInput,
                textInputType: TextInputType.phone
                
              ),
              textFormField(
                onTapInk: () {},
                ktitle: 'مكان الرحلة',
                valueKey: 'location',
                hint: 'مكان الرحلة ',
                 enabled: isDisableTextInput,
                controller: locationController,
              ),    
              textFormField(
                  onTapInk: () {},
                  ktitle: 'المميزات الخاصة بلاعلان',
                  valueKey: 'description',
                  hint: 'اكتب وصف كامل عن الاعلان ..',
                  controller: descriptionController,
                  maxLines: 15,
                  maxLength: 250,
                  enabled: isDisableTextInput,
                  enabledBorderRadius: false),
              const SizedBox(
                height: 20,
              ),
              uploading
                  ? Center(
                      child: Column(
                        children: [
                          const MyText(
                            title: 'جاري الرفع ..',
                          ),
                          CircularProgressIndicator(
                            color: Colors.grey,
                            value: val,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyButton(
                        isVsabilIcon: true,
                        onPressed: supmitForm,
                        icon: Icons.upload_file,
                        width: double.infinity,
                        text: 'رفع للمراجعه',
                      ),
                    ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

 

  void supmitForm() async {
    User? user = _auth.currentUser;
    String _uid = user!.uid;
    final isValid = _adsFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      if (_image.isEmpty) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.NO_HEADER,
          animType: AnimType.BOTTOMSLIDE,
          btnOkOnPress: () {},
          body: const Text('برجاء اختيار صورة'),
        ).show();
      }else {
        setState(() {
          uploading = true;
          isDisableImageButton = true;
          isDisableTextInput = true ;
        });

        // upload data to firestore
        FirebaseFirestore.instance.collection('ads').doc(addId).set({
          'placeId': addId,
          'uploadedBy': _uid,
          'location': locationController.text,
          'placeTitle': titleController.text,
          'phone': phoneController.text,
          'placeDescripton': descriptionController.text,
          'dateTimeStamp': Timestamp.now(),
          'isDone': false,
          'userImage': userImageURL.toString(),
          'userName': userName.toString(),
        });

        uploadFile().whenComplete(() => {
              Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute),
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                body: Column(
                  children: const [
                    MyText(title: 'تم اضافة المراجعه بنجاح جاري مراجعه مشورك'),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ).show()
            });
      }
      print('is Valid');
    } else {
      print('Not Valid');
    }
    // data
  }

  Column textFormField({
    required String valueKey,
    required String hint,
    required String ktitle,
    required TextEditingController controller,
    required VoidCallback onTapInk,
    bool enabled = true,
    bool enabledBorderRadius = true,
    bool isIconVisiblePrefix = false,
    int maxLines = 1,
    int maxLength = 25,
     TextInputType   textInputType =  TextInputType.name
  }) =>
      Column(
        children: [
          kTitle(ktitle),
          InkWell(
            onTap: onTapInk,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyTextField(
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
                textInputType: textInputType,
                
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

  Container ksliverGrid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: 150,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemCount: _image.length + 1,
        itemBuilder: (ctx, index) {
          return index == 0
              ? Center(
                  child: imageButton(onPressed: () {
                    choseImage();
                  }),
                )
              : Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(_image[index - 1]),
                          fit: BoxFit.cover)),
                );
        },
      ),
    );
  }

  void choseImage() async {
    final pickedFile = await ImagePicker()
        // ignore: deprecated_member_use
        .getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    } else {
      print('_______________response.isEmpty_______________');
      return;
    }
    // ignore: unnecessary_null_comparison
    // if (pickedFile!.path == null) retrieveLostData();
  }

  Future uploadFile() async {
    setState(() {
      isDisableTextInput = false ;
    });
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');

      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          imgRef!.doc(addId).collection('imageUrl').add({'url': value});
          if (i == 1) {
            imgRef!.doc(addId).update({'placeImage': value});
          }
          i++;
        });
      });
    }
    setState(() {
      uploading = false;
      isDisableImageButton = false;
      isDisableTextInput = true ;
    });
  }

  Widget imageButton({VoidCallback? onPressed}) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
        ),
        onPressed: isDisableImageButton ? null : onPressed,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                color: Colors.grey,
                size: 40,
              ),
              MyText(
                title: 'أضف صورة',
                color: Colors.grey,
              )
            ],
          ),
        ),
      );
}
