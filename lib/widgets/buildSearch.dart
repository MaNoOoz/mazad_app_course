import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Screens/AdView/AdView.dart';
import 'package:mazad_app/Screens/HomeView/widgets/AdItem.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

class buildSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: TextField(
            onTap: () async {
              await Get.find<HomeViewController>().getAllAds();
              return showSearch(context: context, delegate: searchProducts());
            },
            decoration: InputDecoration(
              hintText: "بحث",
              hintStyle:
                  fontStyle.copyWith(color: Colors.black54, fontSize: 16),
              border: InputBorder.none,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class searchProducts extends SearchDelegate {
  searchProducts()
      : super(
            searchFieldLabel: "بحث",
            searchFieldStyle: fontStyle,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.search);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black45,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return Container(
        child: GetBuilder<HomeViewController>(builder: (c) {
          List<Ad> filterdList = c.allAds.where((element) {
            var _searchResult = element.content!.toLowerCase().contains(query) ||
                element.title!.toLowerCase().contains(query);

            return _searchResult;
          }).toList();

          return Container(
            // height: 234,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: filterdList.length,
              itemBuilder: (BuildContext context, int index) {
                Ad adModel = filterdList[index];
                print(filterdList.length.toString());

                return AdCard(
                    model: adModel, press: () => Get.to(() => AdView(adModel)));
              },
            ),
          );
        }),
      );
    } else {
      return Center(
        child: TextButton(
            onPressed: () {
              print("TextButton.icon");
            },
            child: Text(
              "أدخل كلمة للبحث",
              style: fontStyle,
            )),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    return Container(
      // height: 232,
      //   color: Colors.red,
      child: GetBuilder<HomeViewController>(builder: (c) {
        return SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    print("TextButton.icon");
                  },
                  child: Text(
                    "جميع الإعلانات",
                    style: fontStyle,
                  )),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: c.allAds.length,
                  itemBuilder: (BuildContext context, int index) {
                    Ad adModel = c.allAds[index];

                    return AdCard(
                        model: adModel,
                        press: () => Get.to(() => AdView(adModel)));
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
