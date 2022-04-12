import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../taps.dart';


class AddCover extends StatefulWidget {
  static const String addCover = 'AddCover';
  const AddCover({Key? key}) : super(key: key);

  @override
  State<AddCover> createState() => _AddCoverState();
}

class _AddCoverState extends State<AddCover> {
  // ignore: prefer_final_fields
  TextEditingController _nameCoverController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _imageUrlController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _plasesController = TextEditingController();
final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameCoverController.dispose();
    _imageUrlController.dispose();
    _plasesController.dispose();
    super.dispose();
  }
 void upload() async{
 final isValde = _formKey.currentState!.validate() ;
 FocusScope.of(context).unfocus();
 if ( isValde){
debugPrint('valed');
final _goverId = const Uuid().v4();
await FirebaseFirestore.instance.collection('gover').doc(_goverId).set({
  'id' : _goverId ,
  'imageUrl' : _imageUrlController.text ,
  'name' :_nameCoverController.text , 
  'places' : _plasesController.text,

});
 }else{
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
            Navigator.of(context)
                .pushReplacementNamed(TapsScreen.tapsRoute);
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
                    const MyText(
                      title: 'addUrl',
                      fontSize: 20,
                    ),
                    const Divider(height: 3),
                    _textFormFilds(
                      hint: 'name',
                      controller: _nameCoverController,
                      enabled: true,
                      maxLines: 1,
                      maxLinght: 10,
                      valueKey: 'name',
                      function: () {},
                    ),
                    _textFormFilds(
                      hint: 'url',
                      controller: _imageUrlController,
                      enabled: true,
                      maxLines: 3,
                      maxLinght: 200,
                      valueKey: 'imageUrl',
                      function: (){},
                    ),
                    _textFormFilds(
                      hint: 'places',
                      controller: _plasesController,
                      enabled: true,
                      maxLines: 1,
                      maxLinght: 2,
                      valueKey: 'places',
                      function: (){},
                    ),
                    MaterialButton(onPressed: upload,
                    child: const Text('upload'),
                    ),
                    MaterialButton(onPressed: (){
                        _imageUrlController.text  = '';
                        _nameCoverController.text = '';
                        _plasesController.text = '';
                    },
                    child: const Text('rest'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textFormFilds({
    required String valueKey,
    required String hint,
    required TextEditingController controller,
    required bool enabled,
    required VoidCallback function,
    required int maxLinght,
    required int maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: function,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'is empty';
            } else {
              return null;
            }
          },
          key: ValueKey(valueKey),
          enabled: enabled,
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLinght,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
