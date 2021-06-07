import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mazad_app/controllers/AuthController/AdViewContoller/AdViewContoller.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

class AdView extends GetView<AdViewContoller> {
  final Ad ad;

  AdView(this.ad);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // extendBody: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor, // status bar color
        brightness: Brightness.light,
        elevation: 0,
        title: Text("${ad.title.toString()}"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.share))
        ],


      ),

      bottomSheet: _buildBottomSheet(),

      body: Container(
        padding: EdgeInsets.all(4),
        color: Colors.blue.shade50,
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),

          child: Column(
            children: [
              header(),
              body(),
              fotter(context),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "كلمات دلالية"),
                        ],
                      ),
                      style: headingStylePrimary,
                    ),
                  ],
                ),
              ),
              keywords(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "  التعليقات"),
                        ],
                      ),
                      style: headingStylePrimary,
                    ),
                  ],
                ),
              ),
              comments(context),
              Container(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: 80,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        // IconButton(
                        //   padding: const EdgeInsets.all(0.0),
                        //   // disabledColor: iconColor,
                        //   // color: iconColor,
                        //   icon: Icon(Icons.insert_emoticon),
                        //   onPressed: () {},
                        // ),
                        Flexible(
                          child: TextField(
                            style: headingStylePrimary,
                            textDirection: TextDirection.rtl,
                            // controller: textFieldController,
                            textCapitalization: TextCapitalization.sentences,
                            // textInputAction: _textInputAction,
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.rtl,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(0.0),
                              hintText: 'كتابة تعليق',
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                              ),
                              counterText: '',
                            ),
                            onSubmitted: (String text) {
                              // if(_textInputAction == TextInputAction.send) {
                              //   _sendMessage();
                              // }
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 100,
                          ),
                        ),
                        // IconButton(
                        //   // color: iconColor,
                        //   icon: Icon(Icons.attach_file),
                        //   onPressed: () {},
                        // ),
                        // _message.isEmpty || _message == null
                        //     ? IconButton(
                        //   color: iconColor,
                        //   icon: Icon(Icons.camera_alt),
                        //   onPressed: () {},
                        // )
                        //     : Container(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: FloatingActionButton(
                    mini: true,
                    elevation: 2.0,
                    // backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    onPressed: () {},
                    // todo
                    child: Icon(Icons.send),
                    // onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      height: 140,
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue.shade200,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "  ${ad.user?.username ?? "No Name"}  "),
                  ],
                ),
              ),
              Spacer(),
              AutoSizeText.rich(TextSpan(style: lableStylePrimary, children: [
                TextSpan(
                  text: "منذ ",
                ),
                TextSpan(
                  text: "${ad.createdAt!.toLocal().day.toString()} ",
                ),
                TextSpan(
                  text: "أيام ",
                ),
              ])),
            ],
          ),
          Container(
            height: 10,
          ),
          ListTile(
            title: Text(
              "${ad.title}",
              style: headingStylePrimary,
            ),
          ),
        ],
      ),
    ));
  }

  Widget body() {
    return Container(
      height: 800,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LimitedBox(
              maxHeight: 60,
              child: Container(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: AutoSizeText.rich(
                            TextSpan(
                              style: headingStylePrimary,
                              children: [
                                TextSpan(
                                  text: " صور الإعلان",
                                ),
                                TextSpan(
                                  style: titlesStyleBlack80,
                                  text: "  (${ad.adImages!.length})",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(10),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  pageSnapping: true,
                  allowImplicitScrolling: true,
                  itemCount: ad.adImages?.length == 0 ? 5 : ad.adImages?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      // child: Image.network(
                      //   "${ad.adImages?[index].name ?? ""}",
                      //   semanticLabel: "صور الإعلان",
                      // ),
                      child: Placeholder(),
                    );
                  },
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: kPrimaryColorShadow,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText.rich(
                    TextSpan(
                      style: headingStylePrimary,
                      children: [
                        TextSpan(
                          text: "التفاصيل",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Flexible(
                      child: AutoSizeText.rich(
                        TextSpan(
                          style: headingStyleBlack,
                          children: [
                            TextSpan(
                              text: "${ad.content.toString()} ",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: kPrimaryColorShadow,
              thickness: 1,
            ),

            /// bar
            LimitedBox(
              maxHeight: 60,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.share,
                                color: kPrimaryColorShadow,
                              ),
                            ),
                          ],
                        ),
                        style: contentStyleBlack,
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "${ad.comments!.length.toString()}"),
                            TextSpan(text: " "),
                            WidgetSpan(
                              child: Icon(
                                Icons.message,
                                color: kPrimaryColorShadow,
                              ),
                            ),
                          ],
                        ),
                        style: contentStyleBlack,
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.bookmark_border,
                                color: kPrimaryColorShadow,
                              ),
                            ),
                          ],
                        ),
                        style: contentStyleBlack,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fotter(context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "  ${ad.user?.username ?? "No Name"}  "),
                    WidgetSpan(
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColorShadow,
                      ),
                    ),
                  ],
                ),
                style: contentStyleBlack,
              ),
            ],
          ),
          Divider(
            color: kPrimaryColorShadow,
            thickness: 1,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "  ${ad.user?.email ?? " No Name "}  ",
                        style: contentStyleBlack),
                    WidgetSpan(
                      child: Icon(
                        Icons.mail,
                        color: kPrimaryColorShadow,
                      ),
                    ),
                  ],
                  style: contentStyleBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget comments(context) {
    return Container(
      height: 400,
      padding: EdgeInsetsDirectional.all(12),
      child: ListView.builder(
          itemCount: ad.comments!.length,
          itemBuilder: (context, i) {
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue.shade200,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: titlesStyleBlack,
                              children: [
                                TextSpan(
                                    text:
                                        "  ${ad.user?.username ?? "No Name"}  "),
                              ],
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue.shade200,
                            child: AutoSizeText.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "${ad.comments?[i].id ?? "1"}",
                                      style: titlesStyleWhite)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: kPrimaryColorShadow,
                      ),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText.rich(
                          TextSpan(
                            style: contentStyleBlack,
                            children: [
                              TextSpan(
                                  text:
                                      "  ${ad.comments?[i].commentText ?? "No Name"}")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  Widget keywords(context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ad.tags!.length,
          shrinkWrap: true,

          // padding: EdgeInsets.all(10),
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputChip(
                elevation: 5,
                backgroundColor: kPrimaryColor,
                onPressed: () {},
                label: Semantics(
                  container: true,
                  textDirection: TextDirection.rtl,
                  button: true,
                  child: Container(
                    margin: EdgeInsets.all(1),
                    child: Text(
                      "${ad.tags![i].tagName}",
                      style: contentStylWhite,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
