import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Category.dart';
import 'package:uuid/uuid.dart';

class HomeView extends GetView<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: controller.categories.length,
        initialIndex: 0,
        // width: double.infinity,
        child: Scaffold(
            body: Column(
          children: [
            _buildTabBar(controller),
            Container(
              height: 10,
              color: Colors.green.shade300,
            ),
            _buildTabBarView(
                controller, controller.categories.map((e) => e.ads)),
          ],
        )));
  }

  Widget _buildTabBarView(HomeViewController c, ads) {
    return Container(
      height: 400,
      color: Colors.white,
      child: TabBarView(
        children: List.generate(
          ads.length,
          (index) {
            var adsInCat = controller.categories[index].ads;
           return adsInCat.length != 0
                ? Container(
                    width: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: adsInCat.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, i) {
                        return AdCard(
                          model: adsInCat[i],
                          cat: controller.categories[index],
                          press: () => print("Clicked"),
                        );
                      },
                      separatorBuilder: (context, foodIndex) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  )
                : _EmptyView();
          },
        ),
      ),
    );
  }

  Widget _buildTabBar(HomeViewController c) {
    return Container(
      color: Colors.white,
      // height: 100,
      // width: 300,
      child: TabBar(
        onTap: (index) async {
          await c.getCategoryList();
          // print(c.categories.length);
        },
        labelColor: kPrimaryColor,
        isScrollable: true,
        indicatorColor: kPrimaryColor,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        tabs: List.generate(
          c.categories.length,
          (index) => Tab(
            text: c.categories[index].title,
          ),
        ),
      ),
    );
  }

  Widget _EmptyView() {
    return Container(
      color: Colors.white,
      // height: 100,
      // width: 300,
      child: Center(
        child: Text("لا يوجد إعلانات"),
      ),
    );
  }
}

class AdCard extends StatelessWidget {
  dynamic model;
  final Category cat;
  final GestureTapCallback? press;

  AdCard({
    Key? key,
    required this.cat,
    required this.model,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final oCcy = new NumberFormat("##,##,###", "en_INR");
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
              header(screenWidth, screenH, model!),
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
              fotter(screenWidth, screenH, model),
            ],
          ),
        ),
      ),
    );
  }

  Widget rightSide() {
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(model['ad_images'][0]['name']),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
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
                  Text(
                    "${model["title"]}",
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: headingStyleBlack,
                  ),
                  Text(
                    "${model["content"]}",
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: titlesStyleBlack,
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
                      text: "${cat.createdAt!.toLocal().day.toString()}",
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

  fotter(screenWidth, screenH, dynamic ad) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        color: Colors.white,

        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 40,
      child: Container(
        // color: Colors.red,
        width: screenWidth / 2.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Icon(
                  Icons.favorite_border,
                  size: 16,
                  color: Colors.black38,
                ),
                onTap: () {
                  print('Fav');
                },
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.comment,
                        size: 16,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
