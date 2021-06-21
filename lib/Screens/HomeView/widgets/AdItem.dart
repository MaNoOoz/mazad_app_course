import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart' show Ad;
import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeago;
class AdCard extends StatelessWidget {
  Ad model;
  final GestureTapCallback? press;

  AdCard({
    Key? key,
    required this.model,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.width;

    var checkImages = model.adImages!.length == 0;
    // if (checkImages) {
    //   print("this add has no  images ");
    //   print("${model.adImages![0]!.url}");
    // }

    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
          // boxShadow: [
            // BoxShadow(
            //     color: Colors.black12,
                // blurRadius: 11,
                // offset: Offset(-12, 12)),
          // ],
        ),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 1,
                  offset: Offset(0, 5)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              header(screenWidth, screenH, model),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      ///Right Side
                      !checkImages ? rightSide() : Container(),

                      Container(
                        width: 1,
                        color: Colors.black26,
                      ),

                      /// leftSide
                      leftSide(model)
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              fotter(
                screenWidth,
                screenH,
                model,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rightSide() {
    var image = "$BaseUrl${model.adImages![0].url}";

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: Uuid(),
              child: Container(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: "$image",
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.network(
                      "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded leftSide(ad) {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AutoSizeText(
                    "${model.title}",
                    maxFontSize: 20,
                    maxLines: 3,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    // softWrap: false,
                    style: fontStyle.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 60),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  header(screenWidth, screenH, dynamic ad) {

    var time2 = timeago.format(model.updatedAt!,locale: 'ar',);

    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        color: Colors.white,

        // borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 25,
      child: Row(
        children: [
          Spacer(),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: " منذ : ",
                    style:
                        fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                  ),
                  TextSpan(
                    // text: "${model.createdAt.toString()}",
                    text: "${time2}",
                    style:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                  ),
                  // TextSpan(
                  //   text: " ساعة",
                  //   style:
                  //       fontStyle.copyWith(color: Colors.black45, fontSize: 12),
                  // ),
                ],
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  fotter(
    screenWidth,
    screenH,
    dynamic ad,
  ) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        // color: Colors.red,

        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 30,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(4),
        width: screenWidth,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.favorite_border,
                          size: 22,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "  ( ${model.likes!.length} )  ",
                      style: fontStyle.copyWith(
                          color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
              ),
            ),
            Spacer(),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        child: Icon(
                          Icons.mode_comment_outlined,
                          size: 22,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "  ( ${model.comments!.length} )  ",
                      style: fontStyle.copyWith(
                          color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
