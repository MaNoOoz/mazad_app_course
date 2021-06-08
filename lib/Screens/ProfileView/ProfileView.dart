import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';
import 'package:mazad_app/helpers/Constants.dart';

class ProfileView extends GetView<ProfileController> {


  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: Stack(
                  children: [
                    wallImage(screenW),
                    userImage(),
                  ],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: headingStylePrimary,
                        children: [
                          TextSpan(
                            text: "إعلاناتي",
                          ),
                          TextSpan(
                            style: titlesStyleBlack80,
                            // text: "  (${ad.adImages!.length})",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      10, (index) => ListTile(leading: Text("AA"))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                  height: 32,
                ),
                Text(
                  "يمان",
                  style: headingStyleWhite2,
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

  Widget userImage() {
    return Positioned(
        top: 130,
        left: 0,
        right: 0,
        child: CircleAvatar(
          backgroundColor: Colors.blue.shade400,
          radius: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/icons/home.png",
              scale: 1.5,
            ),
          ),
        ));
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
