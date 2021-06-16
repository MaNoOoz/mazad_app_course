import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_card_swipper/widgets/flutter_page_indicator/flutter_page_indicator.dart';
import 'package:get/get.dart';
import 'package:mazad_app/controllers/AdViewContoller/AdViewContoller.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdView extends GetView<AdViewContoller> {
  final Ad model;

  AdView(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: UniqueKey(),
      // resizeToAvoidBottomInset: true,
      // extendBody: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // status bar color
        brightness: Brightness.light,
        elevation: 0,
        title: Text("${model.title.toString()}",style: fontStyle.copyWith(color: Colors.white,fontSize: 16),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.share))
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
                      style: fontStyle,
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
                      style: fontStyle,
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
                            style: fontStyle,
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
    var time2 = timeago.format(
      model.updatedAt!,
      locale: 'ar',
    );

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
                    TextSpan(text: "  ${model.user?.username ?? "No Name"}  "),
                  ],
                ),
              ),
              Spacer(),
              AutoSizeText.rich(
                TextSpan(
                  style: fontStyle.copyWith(fontSize: 14,color: Colors.black45),
                  children: [
                    TextSpan(
                      text: "منذ ",
                    ),
                    TextSpan(
                      text: "${time2} ",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 10,
          ),
          ListTile(
            title: Text(
              "${model.title}",
              style: fontStyle,
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
                              style: fontStyle,
                              children: [
                                TextSpan(
                                  text: " صور الإعلان",
                                ),
                                TextSpan(
                                  style: fontStyle,
                                  text: "  (${model.adImages!.length})",
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
            LimitedBox(maxHeight: 300, child: AdImagesCards2()),
            Divider(
              thickness: 1,
              color: kPrimaryColorShadow,
            ),
            LimitedBox(
              maxHeight: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: fontStyle,
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
            ),
            LimitedBox(
              maxHeight: 250,
              // padding: const EdgeInsets.all(16.0),
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Row(
                    // textDirection: TextDirection.rtl,
                    children: [
                      Flexible(
                        child: AutoSizeText.rich(
                          TextSpan(
                            style: fontStyle.copyWith(
                                fontSize: 22, color: Colors.black45),
                            children: [
                              TextSpan(
                                text: "${model.content.toString()} ",
                              ),
                            ],
                          ),
                          textDirection: TextDirection.rtl,
                          maxFontSize: 44,
                          minFontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
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
                        style: fontStyle,
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "${model.comments!.length.toString()}"),
                            TextSpan(text: " "),
                            WidgetSpan(
                              child: Icon(
                                Icons.message,
                                color: kPrimaryColorShadow,
                              ),
                            ),
                          ],
                        ),
                        style: fontStyle,
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
                        style: fontStyle,
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

  Widget AdImagesCards2() {
    return Swiper(
      itemCount: model.adImages!.length == 0 ? 5 : model.adImages!.length,
      layout: SwiperLayout.STACK,
      autoplay: false,
      itemWidth: 250.00,
      itemHeight: 300.00,
      viewportFraction: 0.11,
      indicatorLayout: PageIndicatorLayout.NONE,
      pagination: SwiperPagination(margin: new EdgeInsets.all(0.0)),
      // itemCount: ad.adImages!.length,
      scale: 0.9,
      // fade: 50,
      // layout: SwiperLayout.TINDER,
      control: new SwiperControl(color: Colors.black38),
      itemBuilder: (BuildContext context, int index) {
        var image = "$BaseUrl${model.adImages![index].url}";

        return Container(
          // color: Colors.blue.shade50,
          height: 360,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // child: new Image.network("https://static.autox.com/uploads/2018/10/Royal-Enfield-Thunderbird-350X-story-2-.jpg",
            child: Image.network(
              "$image",
              fit: BoxFit.contain,
              // fit: BoxFit.fill,
            ),
          ),
        );
      },
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
                    TextSpan(text: "  ${model.user?.username ?? "No Name"}  "),
                    WidgetSpan(
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColorShadow,
                      ),
                    ),
                  ],
                ),
                style: fontStyle,
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
                        text: "  ${model.user?.email ?? " No Name "}  ",
                        style: fontStyle),
                    WidgetSpan(
                      child: Icon(
                        Icons.mail,
                        color: kPrimaryColorShadow,
                      ),
                    ),
                  ],
                  style: fontStyle,
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
          reverse: true,
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: model.comments!.length,
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
                  width: 200,
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
                              style: fontStyle.copyWith(color: Colors.black45,fontSize: 14),
                              children: [
                                TextSpan(
                                    text:
                                        "  ${model.user?.username ?? "No Name"}  "),
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
                                      text: "${model.comments?[i].id ?? "1"}",
                                      style: fontStyle.copyWith(color: Colors.black45,fontSize: 14))
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
                            style: fontStyle,
                            children: [
                              TextSpan(
                                  text:
                                      "  ${model.comments?[i].commentText ?? "No Name"}")
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
          itemCount: model.tags!.length,
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
                      "${model.tags![i].tagName}",
                      style: fontStyle.copyWith(color: Colors.white,fontSize: 14),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
