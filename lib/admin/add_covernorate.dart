import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../taps.dart';
import '../widgets/form_widgets/my_text_field.dart';

class AddItem extends StatefulWidget {
  static const String addCover = 'AddItem';
  const AddItem({Key? key}) : super(key: key);
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  // ignore: prefer_final_fields
  TextEditingController _nameCoverController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _idController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _placeIdController = TextEditingController();
  TextEditingController latLongController = TextEditingController();

  TextEditingController activitysController = TextEditingController();
  TextEditingController faceBookControllere = TextEditingController();
  // ignore: prefer_final_fields
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameCoverController.dispose();
    _imageUrlController.dispose();
    descriptionController.dispose();
    _idController.dispose();
    _placeIdController.dispose();
    latLongController.dispose();
    activitysController.dispose();

    super.dispose();
  }

  void upload() async {
    final isValde = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValde) {
      debugPrint('valed');
      final _goverId = const Uuid().v4();
      await FirebaseFirestore.instance.collection('places').doc(_goverId).set({
        'gid': _idController.text,
        'imageUrl': _imageUrlController.text,
        'name': _nameCoverController.text,
        'des': descriptionController.text,
        'placeID': _goverId.toString(),
        'latLong': latLongController.text,
        'placeComment': [],
        'placeActivitys': activitysController.text,
      });
      _imageUrlController.clear();
      _nameCoverController.clear();
      descriptionController.clear();
      latLongController.clear();
      activitysController.clear();
    } else {
      debugPrint('not valed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("اضافة محافظة"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                      onTapInk: () {},
                      ktitle: 'العنوان',
                      valueKey: 'title',
                      hint: 'اكتب اسم دال علي المكان',
                      controller: _nameCoverController,
                    ),
                    textFormField(
                      onTapInk: () {},
                      ktitle: 'كود المحافظة',
                      valueKey: 'gid',
                      hint: 'تأكد من كتابه الكود بطريقه صحيحة ',
                      controller: _idController,
                    ),
                    textFormField(
                      onTapInk: () {},
                      ktitle: 'الموقع علي الخريطة',
                      valueKey: 'latLong',
                      hint: 'latLong اكتب كود ',
                      controller: latLongController,
                    ),
                    textFormField(
                      onTapInk: () {},
                      ktitle: 'رابط الصورة',
                      valueKey: 'imageUrl',
                      hint: 'ضع هنا رابط الصورة ',
                      controller: _imageUrlController,
                    ),
                    textFormField(
                        onTapInk: () {},
                        ktitle: 'اكتب الوصف',
                        valueKey: 'description',
                        hint: 'اكتب وصف كامل عن المكان ..',
                        controller: descriptionController,
                        maxLines: 4,
                        maxLength: 250,
                        enabledBorderRadius: false),
                    textFormField(
                        onTapInk: () {},
                        ktitle: 'اكتب النشطات',
                        valueKey: 'activitys',
                        hint:
                            'اكتب النشاطات التي يمكن للذائر القيام بيها داخل المكان',
                        controller: activitysController,
                        maxLines: 4,
                        maxLength: 250,
                        enabledBorderRadius: false),
                    MaterialButton(
                      onPressed: () {
                        upload();
                      },
                      child: const Text('upload'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
