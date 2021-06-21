import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
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
        title: Text(
          "${model.title.toString()}",
          style: fontStyle.copyWith(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.share))
        ],
      ),

      bottomSheet: _buildBottomSheet(),

      body: Container(
        padding: EdgeInsets.all(4),
        color: Color(0xFFF2F4FA),
        // color: Colors.red,
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header(),
              body(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      padding: EdgeInsets.all(12),
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0), bottomLeft: Radius.circular(0)),
      ),
      child: Column(
        children: [
          TextFormField(
            maxLength: 300,
            minLines: 1,
            keyboardType: TextInputType.text,
            // controller: controller.titleController,
            maxLines: 1,
            validator: (value) {
              return value!.length < 3
                  ? 'Name must be greater than 10 characters'
                  : null;
            },
            style: fontStyle.copyWith(
              color: Colors.black54,
            ),
            // style: UtilsImporter().uStyleUtils.loginTextFieldStyle(),
            decoration: textFieldDecorationCircle(
              hint: "مثال: 500 ريال",
              lable: 'تعليق جديد',
              style: fontStyle.copyWith(
                color: Colors.black26,
              ),
              icon: Icon(Icons.title),
            ),
            textDirection: TextDirection.rtl,
            onSaved: (String? val) {
              // controller.title = val!;
            },

            onChanged: (String? val) {
              // controller.title = val!;
            },
          ),
          LimitedBox(
            maxHeight: 50,
            maxWidth: 150,
            child: OutlineButton(
              onPressed: () {
                print("OutlineButton");
              },
              child: Text(
                "إرسال",
                style: fontStyle.copyWith(color: Colors.blue),
              ),
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

    return Container(
      color: Color(0xFFFFFFFF),
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
                  style:
                  fontStyle.copyWith(fontSize: 14, color: Colors.black45),
                  children: [
                    TextSpan(
                      text: "منذ ",
                    ),
                    TextSpan(
                      text: "${time2} ",
                    ),
                  ],
                ),
                textDirection: TextDirection.rtl,
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
    );
  }

  Widget body() {
    return LimitedBox(
      // color: Colors.red,
      maxHeight: 5000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          LimitedBox(
            maxHeight: 60,
            child: Container(
              color: Color(0xFFFFFFFF),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: fontStyle,
                        children: [
                          TextSpan(
                            text: " صور الإعلان",
                          ),
                          TextSpan(
                            style: fontStyle.copyWith(color: Colors.blue),
                            text: "  (${model.adImages!.length})",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // images
          model.adImages!.length ==0?  Container(child: Text("لايوجد صور"),):LimitedBox(maxHeight: 400, child: adImages()),

          // title
          Container(
            color: Color(0xFFFFFFFF),
            child: LimitedBox(
              maxHeight: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.center,
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
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ad content
          Flexible(
            child: Container(
              // color: Color(0xFFFFFFFF),
              color: Color(0xFFFFFFFF),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText.rich(
                  TextSpan(
                    style:
                    fontStyle.copyWith(fontSize: 22, color: Colors.black45),
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
            ),
          ),

          /// share card
          LimitedBox(
            maxHeight: 60,
            child: Container(
              color: Color(0xFFFFFFFF),
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
          SizedBox(
            height: 10,
          ),

          // contact card
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.all(10),
            height: 100,
            child: Column(
              children: [
                Row(
                  // textDirection: TextDirection.rtl,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.phone,
                              color: kPrimaryColorShadow,
                            ),
                          ),
                          TextSpan(
                              text: "  ${model.user?.username ?? "No Name"}  "),
                        ],
                      ),
                      style: fontStyle,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.mail,
                              color: kPrimaryColorShadow,
                            ),
                          ),
                          TextSpan(
                              text: "  ${model.user?.email ?? " No Name "}  ",
                              style: fontStyle),
                        ],
                        style: fontStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // title

          Container(
            color: Color(0xFFFFFFFF),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: AutoSizeText.rich(
                  TextSpan(
                    style: fontStyle,
                    children: [
                      TextSpan(
                        text: "التعليقات",
                      ),
                      TextSpan(
                        style: fontStyle.copyWith(color: Colors.blue),
                        text: "  (${model.comments!.length})",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          model.adImages!.length ==0? LimitedBox(
            maxHeight: 350,
            child: adComments(),
          ):Container(child: Text("لا يوجد تعليقات"),),
          Container(
            height: 150,
          ),



        ],
      ),
    );
  }

  Widget adImages() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Swiper(
        itemCount: model.adImages!.length == 0 ? 5 : model.adImages!.length,
        layout: SwiperLayout.STACK,
        autoplay: false,
        itemWidth: 250.00,
        itemHeight: 300.00,
        // viewportFraction: 10.11,
        // indicatorLayout: PageIndicatorLayout.SLIDE,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: new EdgeInsets.only(top: 10.0),
        ),
        // itemCount: ad.adImages!.length,
        // scale: 1.1,
        // fade: 50,
        // layout: SwiperLayout.TINDER,
        control: new SwiperControl(
          color: Colors.black38,
        ),
        itemBuilder: (BuildContext context, int index) {
          var image = "$BaseUrl${model.adImages![index].url}";

          return Container(
            height: 360,
            width: 300,
            child: Image.network(
              "$image",
              fit: BoxFit.contain,
              // fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }

  Widget adComments() {
    return Swiper(
      itemCount: model.comments!.length,
      layout: SwiperLayout.STACK,
      autoplay: false,
      itemWidth: 300.00,
      itemHeight: 300.00,
      // viewportFraction: 10.11,
      // indicatorLayout: PageIndicatorLayout.SLIDE,
      // pagination: SwiperPagination(
      //   alignment: Alignment.bottomCenter,
      //   margin: new EdgeInsets.only(top: 10.0),
      // ),
      // itemCount: ad.adImages!.length,
      // scale: 1.1,
      // fade: 50,
      // layout: SwiperLayout.TINDER,
      control: new SwiperControl(
        color: Colors.black38,
      ),
      itemBuilder: (BuildContext context, int i) {
        return Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
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
                        style: fontStyle.copyWith(
                            color: Colors.black45, fontSize: 14),
                        children: [
                          TextSpan(
                              text: "  ${model.user?.username ?? "No Name"}  "),
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
                                style: fontStyle.copyWith(
                                    color: Colors.black26, fontSize: 14))
                          ],
                        ),
                        maxFontSize: 20,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),
                Expanded(
                  flex: 4,
                  child: AutoSizeText.rich(
                    TextSpan(
                      style: fontStyle.copyWith(
                          fontSize: 20, color: Colors.black45),
                      children: [
                        TextSpan(
                            text:
                            "  ${model.comments?[i].commentText ?? "No Name"}")
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 12,
                )
              ],
            ),
          ),
        );

      },
    );
  }
}
