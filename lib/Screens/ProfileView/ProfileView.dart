import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_card_swipper/widgets/flutter_page_indicator/flutter_page_indicator.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Screens/AdView/AdView.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // color: Colors.red,
        child: ListView(
          children: [
            Container(
              height: 100,
              child: Stack(
                children: [
                  wallImage(screenW),
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              // color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: AutoSizeText.rich(
                    TextSpan(
                      style: fontStyle,
                      children: [
                        TextSpan(
                          text: "إعلاناتي",
                        ),
                        TextSpan(
                          style: fontStyle,
                          // text: "  (${ad.adImages!.length})",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            controller.adList.length == 0
                ? Container(
                    child: Center(child: Text("لايوجد إعلانات")),
                  )
                :

            LimitedBox(maxHeight: 200, child: adsList(context)),
            // LimitedBox(maxHeight: 400, child: adsList(context)),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget adsList(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (c) {
      print(c.adList.length);
      return Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Swiper(
          itemCount: controller.adList.length,
          layout: SwiperLayout.STACK,
          autoplay: false,
          itemWidth: 300.00,
          itemHeight: 100.00,
          indicatorLayout: PageIndicatorLayout.NONE,

          itemBuilder: (BuildContext context, int index) {
            var item = controller.adList[index];
            var image = "$BaseUrl${controller.adList[index].adImages![0].url}";

            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(() => AdView(item));
                    // controller.adList.clear();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: Colors.black26, width: 0.4),
                        boxShadow: [
                          BoxShadow(
                              // color: Theme.of(context).primaryColor.withOpacity(0.1),
                              // color: Theme.of(context).shadowColor.withOpacity(0.15),
                              color: Colors.black12,
                              blurRadius: 22,
                              offset: Offset(-10, 5)),
                        ],
                      ),
                      child: ListTile(
                        onTap: () => Get.to(() => AdView(item)),
                        isThreeLine: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,

                          foregroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            image,
                            // fit: BoxFit.fill,
                          ),
                        ),
                        title: Text('${item.title}'),
                        subtitle: Text(
                            '${item.content!.substring(0, 20).toString()}'),
                      )),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget adsList2(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (c) {
      print(c.adList.length);
      return Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: ListView.builder(
          itemCount: controller.adList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = controller.adList[index];
            var image = "$BaseUrl${controller.adList[index].adImages![0].url}";

            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(() => AdView(item));
                    controller.adList.clear();
                  },
                  child: Container(
                      color: Colors.red,
                      child: Column(
                        children: [
                          // Expanded(
                          //     child: Container(
                          //   color: Colors.green,
                          //   child: Image.network(
                          //     image,
                          //     fit: BoxFit.fill,
                          //   ),
                          // )),
                          Expanded(child: Placeholder()),
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget wallImage(double screenW) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 505,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ClipPath(
        clipper: ClippingClass(),
        child: Container(
          width: screenW,
          height: 200.0,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 30,
                ),
                Container(
                  // color: Colors.red,
                  child: Text(
                    "${controller.user!.email}",
                    // "User Name",
                    style: fontStyle.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue, boxShadow: [],
            // color: Colors.blue.shade300,
          ),
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Future showAlert(BuildContext context, Ad ad, ProfileController pc) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Confirmation"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${ad.title} Removed."),
                  backgroundColor: Colors.red,
                ));
              },
              child: const Text("Delete")),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}

/// crash code  ==================
//              return Dismissible(
//               background: Container(
//                 color: Colors.red,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Row(
//                     textDirection: TextDirection.rtl,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Icon(Icons.delete, color: Colors.white),
//                       SizedBox(width: 20),
//                       Text('حذف', style: fontStyle),
//                     ],
//                   ),
//                 ),
//               ),
//               secondaryBackground: Container(
//                 color: Colors.blue,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Row(
//                     textDirection: TextDirection.rtl,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.favorite, color: Colors.white),
//                       SizedBox(width: 20),
//                       Text('إضافة إلى المفضلة', style: fontStyle),
//                     ],
//                   ),
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(const Radius.circular(10.0)),
//                   color: Colors.white,
//                   border: Border.all(color: Colors.black26, width: 0.4),
//                   boxShadow: [
//                     BoxShadow(
//                         // color: Theme.of(context).primaryColor.withOpacity(0.1),
//                         // color: Theme.of(context).shadowColor.withOpacity(0.15),
//                         color: Colors.black12,
//                         blurRadius: 22,
//                         offset: Offset(-10, 5)),
//                   ],
//                 ),
//                 child: ListTile(
//                   isThreeLine: true,
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.blue,
//                     child: Text('${item.title!.substring(0, 1).toString()}'),
//                     foregroundColor: Colors.white,
//                   ),
//                   title: Text('${item.title}'),
//                   subtitle:
//                       Text('${item.content!.substring(0, 20).toString()}'),
//                 ),
//               ),
//               onDismissed: (direction) {
//                 if (direction == DismissDirection.startToEnd) {
//                   print("Add to favorite list");
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text("${item.title} Removed."),
//                     backgroundColor: Colors.red,
//                   ));
//
//                   /// todo send delete request to backend
//
//                   print("Delete From Cart List");
//                 }
//               },
//               confirmDismiss: (DismissDirection direction) async {
//                 if (direction == DismissDirection.endToStart) {
//                   print("Add to favorite list");
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("${item.title} Added."),
//                       backgroundColor: Colors.green,
//                     ),
//                   );
//                 } else {
//                   await showAlert(context, item, controller);
//                 }
//               },
//               key: Key('item ${controller.adList[index]}'),
//             );
