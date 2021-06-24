import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/controllers/NewAdController/NewAdController.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

class SideDrawer extends StatelessWidget {
  User? user;

  SideDrawer({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(child: Drawer(
        child: GetBuilder<ProfileController>(builder: (c) {
          return normalistList(context);
        }),
      )),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(user!.email.toString()),
              accountName: Text(user!.username.toString()),
              // otherAccountsPictures: [Icon(Icons.home), Icon(Icons.ac_unit)],
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
              ),
            ),

            ListTile(
              title: Text(
                'الحساب',
                style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('الإعدادات',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            Container(
              color: Colors.black12,
              height: 5,
            ),

            ListTile(
              title: Text('تسوق حسب القسم',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('إعلانات اليوم',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),

            ListTile(
              title: Text('المساعدة والإعدادات',
                  style:
                      fontStyle.copyWith(color: Colors.black, fontSize: 24)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            ListTile(
              leading: Icon(Icons.language),
              title: Text('العربية',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text(' المملكة العربية السعودية',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            ListTile(
              title: Text('خدمة العملاء',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            ListTile(
              title: Text('تسجيل الدخول',
                  style:
                      fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
              onTap: () {
                Get.offAllNamed(Routers.login);
                // Update the state of the app.
                // ...
              },
            ),
          ],
        );
  }


  // or //
  Widget loggedUserList(BuildContext context) {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(user!.email.toString()),
          accountName: Text(user!.username.toString()),
          // otherAccountsPictures: [Icon(Icons.home), Icon(Icons.ac_unit)],
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
          ),
        ),
        ListTile(
          title: Text('إعلان جديد'),
          leading: Icon(Icons.add),
          onTap: () {
            GetBuilder<NewAdController>(
                init: NewAdController(),
                builder: (c) {
                  return IconButton(
                    onPressed: () async {
                      await Get.toNamed(Routers.newAd);

                      // return await Get.to(() => NewAdView());
                      // await c.getCategoryList();
                    },
                    icon: Icon(Icons.add),
                    tooltip: "Add Ad",
                  );
                });
          },
        ),
        ListTile(
          title: Text('Login'),
          leading: Icon(Icons.login),
          onTap: () {},
        ),
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.logout),
          onTap: () async {
            // await storage
            //     .deleteToken()
            // // .then((value) => Get.to(() => LoginView()));
            //     .then((value) => Get.offAllNamed(Routers.login));
            // await Get.offAllNamed(Routers.login);
          },
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(Icons.settings),
          onTap: () => Navigator.pushNamed(
            context,
            'settings',
          ),
        )
      ],
    );
  }
 // or //
  Widget normalistList(BuildContext context) {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(
            "user!.email.toString()",
            style: fontStyle.copyWith(color: Colors.white, fontSize: 16),
          ),
          accountName: Text(
            "user!.username.toString()",
            style: fontStyle.copyWith(color: Colors.white, fontSize: 16),
          ),
          // otherAccountsPictures: [Icon(Icons.home), Icon(Icons.ac_unit)],
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
          ),
        ),
        ListTile(
          title: Text(
            'إعلان جديد',
            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
          ),
          leading: Icon(Icons.add),
          onTap: () {
            GetBuilder<NewAdController>(
                init: NewAdController(),
                builder: (c) {
                  return IconButton(
                    onPressed: () async {
                      await Get.toNamed(Routers.newAd);

                      // return await Get.to(() => NewAdView());
                      // await c.getCategoryList();
                    },
                    icon: Icon(Icons.add),
                    tooltip: "Add Ad",
                  );
                });
          },
        ),
        ListTile(
          title: Text(
            'Login',
            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
          ),
          leading: Icon(Icons.login),
          onTap: () {},
        ),
        // todo remove late
        ListTile(
          title: Text(
            'Logout',
            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
          ),
          leading: Icon(Icons.logout),
          onTap: () async {
            // await storage
            //     .deleteToken()
            // // .then((value) => Get.to(() => LoginView()));
            //     .then((value) => Get.offAllNamed(Routers.login));
            // await Get.offAllNamed(Routers.login);
          },
        ),
        ListTile(
          title: Text(
            'Settings',
            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
          ),
          leading: Icon(Icons.settings),
          onTap: () => Navigator.pushNamed(
            context,
            'settings',
          ),
        )
      ],
    );
  }
}
