import 'package:egy_tour_guide/layout.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_button.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class GovernorateDetails extends StatefulWidget {
  final String categoryId;
  final String categoryTitel;
  final String imageUrl;
  final String des;
  

  const GovernorateDetails(
      {required this.categoryId, required this.categoryTitel, required this.imageUrl, required this.des});

  @override
  State<GovernorateDetails> createState() => _GovernorateDetailsState();
}

class _GovernorateDetailsState extends State<GovernorateDetails> {
  bool _isCommenting = false;

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

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(LayOutScreen.covernorateRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title:  Text(widget.categoryTitel),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            buildSectionTitle(context, 'معلومات عن المكان'),
            buildListViewContainer(MyText(
              title: widget.des,
              lines: 10,
            )),
            buildSectionTitle(context, 'الأنشطة'),
            buildListViewContainer(
              ListView.builder(
                itemCount: 4,
                itemBuilder: (ctx, index) =>  Card(
                  elevation: 0.3,
                  child:  Padding(
                    padding:  EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child:  Text("نشاط"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            buildSectionTitle(context, 'البرنامج اليومي'),
            buildListViewContainer(
              ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('يوم ${index + 1}'),
                      ),
                      title: Text("البرنااامج"),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: _isCommenting
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 5,
                              child: _textFormFilds(
                                hint: 'اكتب تعليق',
                                enabled: true,
                                maxLines: 5,
                                maxLinght: 500,
                                valueKey: 'comment',
                                function: () {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyButton(
                                      isVsabilIcon: true,
                                      icon: Icons.send,
                                      text: "ارسال",
                                      onPressed: () {},
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isCommenting = !_isCommenting;
                                          });
                                        },
                                        child: const MyText(
                                          title: 'الغاء التعليق',
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      )
                    : MyButton(
                        text: ' تعليق',
                        icon: Icons.comment,
                        isVsabilIcon: true,
                        onPressed: () {
                          setState(() {
                            _isCommenting = !_isCommenting;
                          });
                        },
                      )),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return _commentWidget();
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _commentWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
            ),
          ),
        ),
        const SizedBox(width: 15,),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(title: 'Coment name'.toUpperCase(), fontWeight: FontWeight.bold, color: Colors.blue,),
              MyText(title: 'commmmmmmmmmmmmmmenKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKt ',),
            ],
          ),
        )
      ],
    );
  }

  _textFormFilds({
    required String valueKey,
    required String hint,
    //required TextEditingController controller,
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
          // controller: controller,
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
