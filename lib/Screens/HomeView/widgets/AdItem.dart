import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart' show Ad;
import 'package:uuid/uuid.dart';

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

    // print(model['ad_images'][0]['name'].runtimeType);

    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                blurRadius: 1,
                offset: Offset(-10, 12)),
          ],
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
                color: Colors.black26,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      ///Right Side
                      rightSide(),

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
                color: Colors.black26,
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
    var checkImages = model.adImages!.length == 0;
    if (checkImages) {
      print("this add has no  images ");
    }
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
                child: checkImages
                    ? Image.asset('assets/icons/home.png')
                    : Image.network(model.adImages![0].name.toString()),
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
        padding: EdgeInsets.all(10),
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
                    maxFontSize: 22,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    // softWrap: false,
                    style: headingStylePrimary,
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
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        color: Colors.white,

        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 25,
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: " منذ : ", style: lableStyleBlack),
                  TextSpan(
                      // text: "${cat.createdAt!.toLocal().day.toString()}",
                      text: "${model.createdAt!.toLocal().day.toString()}",
                      style: lableStyleBlack),
                  TextSpan(text: "يوم", style: lableStyleBlack),
                ],
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
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
      height: 40,
      child: Center(
        child: Container(
          // color: Colors.red,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.favorite,
                              size: 22,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: " ${model.comments!.length}",
                            style: titlesStyleBlack),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            child: Icon(
                              Icons.comment,
                              size: 22,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: " ${model.comments!.length}",
                            style: titlesStyleBlack),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}