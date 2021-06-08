import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazad_app/Screens/AdView/AdView.dart';
import 'package:mazad_app/Screens/HomeView/widgets/AdItem.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

class HomeView extends GetView<HomeViewController> {
  var catID = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        _buildTabBar(controller),
        _bulidBody(controller),
        Container(
          height: 10,
        ),
        Container(
          height: 10,
          color: Colors.blue.shade300,
        ),
      ],
    ));
  }

  Widget _buildTabBar(HomeViewController c) {
    return DefaultTabController(
      length: controller.categories.length,
      initialIndex: 0,
      child: Container(
        color: Colors.white,
        // height: 100,
        // width: 300,
        child: TabBar(
          onTap: (index) async {
            // await c.getCategoryList();
            catID = c.categories[index].id!;
            // print(c.categories[index].id);
            c.catId = catID;
            print(c.catId);
            await c.getAdsListWithFilter(catID);
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
      ),
    );
  }

  Widget _bulidBody(HomeViewController c) {
    return GetBuilder<HomeViewController>(
        init: Get.find<HomeViewController>(),
        builder: (controller) {
          print("_bulidBody called");

          return c.adsListFilter.length == 0
              ? _EmptyView()
              : Container(
                  height: 300,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: c.adsListFilter.length,
                    itemBuilder: (ctx, i) {
                      Ad adModel = c.adsListFilter[i];
                      // return Text("${adModel.content}");

                      return AdCard(
                          model: adModel, press: () => Get.to(() =>AdView(adModel)));
                    },
                  ),
                );
        });
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

  Widget _bulidFilter() {
    return Container(
      color: Colors.white,
      // height: 100,
      // width: 300,
      child: Center(
        child: Text("لا يوجد إعلانات"),
      ),
    );
  }

  Widget _searchBar() {
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
