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

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  bool uploading = false;
  bool isDisableImageButton = false;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  // ignore: prefer_final_fields
  List<File> _image = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final placeId = const Uuid().v4();

  // text Editing Controller
  TextEditingController categoryController =
      TextEditingController(text: 'اضغط لاختيار تصنيف');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _userPlacesFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('userPlaces');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        title: const Text('اضف مكان'),
        centerTitle: true,
      ),
      body: Form(
        key: _userPlacesFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ksliverGrid(),
              textFormField(
                onTapInk: () {
                  chooseCategoryDialog(context, size);
                },
                
                ktitle: 'اضغط للاختيار',
                valueKey: 'category',
                hint: 'اضغط لاختيار تصنيف',
                enabled: false,
                controller: categoryController,
              ),
              textFormField(
                onTapInk: () {},
                ktitle: 'العنوان',
                valueKey: 'title',
                hint: 'اكتب اسم دال علي المكان',
                controller: titleController,
              ),
              textFormField(
                  onTapInk: () {},
                  ktitle: 'وصف المكان الذي تريد مراجعته',
                  valueKey: 'description',
                  hint: 'اكتب وصف كامل عن المكان ..',
                  controller: descriptionController,
                  maxLines: 4,
                  maxLength: 250,
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
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.green),
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
                        text: 'رفع علي ',
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  AwesomeDialog chooseCategoryDialog(BuildContext context, Size size) {
    return AwesomeDialog(
                context: context,
                dialogType: DialogType.NO_HEADER,
                animType: AnimType.BOTTOMSLIDE,

                //  title: 'هل انت واثق من تسجيل الخروج ؟',
                btnCancelOnPress: () {},
                btnCancelText: 'اغلاق',
                body: Column(
                  children: [
                    const MyText(
                      title: 'اختار التصنيف المناسب',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: Constant.placeCatigoryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    categoryController.text =
                                      Constant.placeCatigoryList[index];
                                  });
                                  
                                  print(
                                      "categoryController = ${categoryController.text}");
                                      if (Navigator.of(context).canPop()) {
                                          Navigator.of(context).pop();
                                      }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    MyText(
                                      title:
                                          Constant.placeCatigoryList[index],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              )..show();
  }

  void supmitForm() async {
    User? user = _auth.currentUser;
    String _uid = user!.uid;
    final isValid = _userPlacesFormKey.currentState!.validate();
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
      } 
      else if( categoryController.text =='اضغط لاختيار تصنيف') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.NO_HEADER,
          animType: AnimType.BOTTOMSLIDE,
          btnOkOnPress: () {},
          body: const Text('برجاء اختيار تصنيف'),
        ).show();
      }
      else {
        setState(() {
          uploading = true;
          isDisableImageButton = true;
        });

        // upload data to firestore
        FirebaseFirestore.instance.collection('userPlaces').doc(placeId).set({
          'placeId': placeId,
          'uploadedBy': _uid,
          'placeTitle': titleController.text,
          'placeDescripton': descriptionController.text,
          'dateTimeStamp': Timestamp.now(),
          'userPlaceComment': [],
          'isDone': false,
          'userPlaceCategory': categoryController.text,
        });

        uploadFile().whenComplete(() => {
          Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute),
          AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
       
          body: Column(
            children:const [
               MyText(title: 'تم اضافة المراجعه بنجاح جاري مراجعه مشورك'),
               SizedBox(height: 10,)
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
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    // ignore: unnecessary_null_comparison
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    // ignore: deprecated_member_use
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
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
          imgRef!.doc(placeId).collection('imageUrl').add({'url': value});
          i++;
        });
      });
    }
    setState(() {
      uploading = false;
      isDisableImageButton = false;
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
