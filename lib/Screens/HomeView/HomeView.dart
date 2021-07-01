import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/Screens/AdView/AdView.dart';
import 'package:mazad_app/Screens/HomeView/widgets/AdItem.dart';
import 'package:mazad_app/controllers/AdViewContoller/AdViewContoller.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/widgets/buildSearch.dart';
import 'package:mazad_app/widgets/side_drawer.dart';

class HomeView extends GetWidget<HomeViewController> {
  var catID = 4;

  HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                title: Text(
                  "مزاد ",
                  // "${controller.user!.email} ",
                  style: fontStyle.copyWith(color: Colors.white, fontSize: 22),
                ),
              ),
              buildSearch(),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          SizedBox(
            height: 30,
          ),
          _buildBody(),
          Container(
            height: 10,
          ),
          // Container(
          //   height: 10,
          //   color: Colors.blue.shade300,
          // ),
        ],
      ),
      // },
      // ),
    );
  }

  Widget _buildTabBar() {
    // final _tabs = controller.categories.map<Tab>((e) => Tab(text: e.title)).toList();
    return GetBuilder<HomeViewController>(
      builder: (c) {
        return DefaultTabController(
          length: controller.categories.length,
          initialIndex: 0,
          child: Container(
            color: Colors.white,
            // height: 100,
            // width: 300,
            child: TabBar(
              onTap: (index) async {
                catID = c.categories[index].id!;
                c.catId = catID;
                // Logger().d("message");
                Logger().d(index);

                await c.getAdsListWithFilter(catID);
              },
              labelColor: Colors.blue,
              isScrollable: true,
              unselectedLabelStyle: fontStyle.copyWith(fontSize: 16),
              indicatorSize: TabBarIndicatorSize.label,
              enableFeedback: true,
              physics: BouncingScrollPhysics(),
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelStyle: fontStyle.copyWith(fontSize: 18),
              tabs: List.generate(
                c.categories.length,
                (index) => Tab(
                  text: c.categories[index].title,
                ),
                // )
              ),
              // tabs: _tabs
              // )
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return GetBuilder<HomeViewController>(builder: (controller) {
      // Logger().d("_bulidBody called");

      return controller.adsListFilter.length == 0
          ? _noneView()
          : Expanded(
              child: Container(
                // height: 500,
                color: Colors.blue.shade50,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.adsListFilter.length,
                  itemBuilder: (ctx, i) {
                    Ad adModel = controller.adsListFilter[i];
                    var images = controller.adsListFilter[i].adImages;
                    // var hasImages = images!.length == 0;
                    // Logger().d(images);
                    // if (hasImages) {
                    //   Logger().d(images.length);
                    // } else {
                    //   Logger().d(images.length);
                    // }
                    return AdCard(
                        model: adModel,
                        press: () async {
                          Get.put<AdViewContoller>(AdViewContoller());

                          return Get.to(() => AdView(adModel));
                        });
                  },
                ),
              ),
            );
    });
  }

  Widget _noneView() {
    return Container(
      color: Colors.white,
      // height: 100,
      // width: 300,
      child: Center(
        child: Text(
          "لا يوجد إعلانات",
          style: fontStyle.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
