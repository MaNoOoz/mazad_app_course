import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/NewAdController/NewAdController.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';
import 'package:mazad_app/helpers/Constants.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Drawer(
        // child: GetBuilder<ProfileController>(builder: (c) {
        //   return buildListView(context);
        // }),
        child: buildListView(context),
      )),
    );
  }

  Widget loggedUserList() {
    return Column(
      children: [
        ListTile(
          title: Text(
            'الحساب',
            style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18),
          ),
          onTap: () {
            // Update the state of the app.
            // ...
            Get.put<ProfileController>(ProfileController());
            Get.toNamed(Routers.profile);
          },
        ),
        ListTile(
          title: Text('إعلان جديد',
              style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
          onTap: () {
            // Update the state of the app.
            // ...
            Get.put<NewAdController>(NewAdController());
            Get.toNamed(Routers.newAd);
          },
        ),
        ListTile(
          title: Text('تسجيل الخروج',
              style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
          onTap: () async {
            // Get.offAllNamed(Routers.login);
            // Update the state of the app.
            var c = Get.put<LoginController>(LoginController());
            await c.signOutUser();
            // c.update();

            // ...
            // await LocalStorage().deleteToken();
            // user=null;
            // Get.back();
            // Get.toNamed(Routers.home);

            // Get.toNamed(Routers.login);
            // Get.offAndToNamed(Routers.login);
          },
        ),
      ],
    );
  }

  Widget buildListView(BuildContext context) {
    return GetBuilder<LoginController>(builder: (c) {
      if (c.user.isNull) {
        c.update();
      }

      return ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(c.user?.email.toString() ?? "Yaman"),
            accountName: Text(c.user?.username.toString() ?? "Yaman@gmail.com"),
            // otherAccountsPictures: [Icon(Icons.home), Icon(Icons.ac_unit)],
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
            ),
          ),
          // todo fix null error after signout

          // Container(
          //   child: ListTile(
          //     title: Text('تسجيل الدخول',
          //         style:
          //             fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
          //     onTap: () {
          //       // Get.offAllNamed(Routers.login);
          //       // Update the state of the app.
          //       // ...
          //       Get.put<LoginController>(LoginController());
          //       // Get.toNamed(Routers.login);
          //       Get.offAndToNamed(Routers.login);
          //     },
          //   ),
          // ),


          c.user.isNull
              ? Container(
                  child: ListTile(
                    title: Text('تسجيل الدخول',
                        style: fontStyle.copyWith(
                            color: kPrimaryColor, fontSize: 18)),
                    onTap: () {
                      // Get.offAllNamed(Routers.login);
                      // Update the state of the app.
                      // ...
                      Get.put<LoginController>(LoginController());
                      // Get.toNamed(Routers.login);
                      Get.offAndToNamed(Routers.login);
                    },
                  ),
                )
              : Container(),
          c.user.isNull ? Container() : loggedUserList(),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          ListTile(
            title: Text('تسوق حسب القسم',
                style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('إعلانات اليوم',
                style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
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
                style: fontStyle.copyWith(color: Colors.black, fontSize: 24)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('العربية',
                style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text(' المملكة العربية السعودية',
                style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('خدمة العملاء',
                style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 18)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      );
    });
  }

//  // or //
//  Widget loggedUserList(BuildContext context) {
//    return ListView(
//      children: [
//        UserAccountsDrawerHeader(
//          accountEmail: Text(user!.email.toString()),
//          accountName: Text(user!.username.toString()),
//          // otherAccountsPictures: [Icon(Icons.home), Icon(Icons.ac_unit)],
//          currentAccountPicture: CircleAvatar(
//            backgroundImage: NetworkImage(
//                'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
//          ),
//        ),
//        ListTile(
//          title: Text('إعلان جديد'),
//          leading: Icon(Icons.add),
//          onTap: () {
//            GetBuilder<NewAdController>(
//                init: NewAdController(),
//                builder: (c) {
//                  return IconButton(
//                    onPressed: () async {
//                      await Get.toNamed(Routers.newAd);
//
//                      // return await Get.to(() => NewAdView());
//                      // await c.getCategoryList();
//                    },
//                    icon: Icon(Icons.add),
//                    tooltip: "Add Ad",
//                  );
//                });
//          },
//        ),
//        ListTile(
//          title: Text('Login'),
//          leading: Icon(Icons.login),
//          onTap: () {},
//        ),
//        ListTile(
//          title: Text('Logout'),
//          leading: Icon(Icons.logout),
//          onTap: () async {
//            // await storage
//            //     .deleteToken()
//            // // .then((value) => Get.to(() => LoginView()));
//            //     .then((value) => Get.offAllNamed(Routers.login));
//            // await Get.offAllNamed(Routers.login);
//          },
//        ),
//        ListTile(
//          title: Text('Settings'),
//          leading: Icon(Icons.settings),
//          onTap: () => Navigator.pushNamed(
//            context,
//            'settings',
//          ),
//        )
//      ],
//    );
//  }
// // or //
//  Widget normalistList(BuildContext context) {
//    return ListView(
//      children: [
//        UserAccountsDrawerHeader(
//          accountEmail: Text(
//            "user!.email.toString()",
//            style: fontStyle.copyWith(color: Colors.white, fontSize: 16),
//          ),
//          accountName: Text(
//            "user!.username.toString()",
//            style: fontStyle.copyWith(color: Colors.white, fontSize: 16),
//          ),
//          // otherAccountsPictures: [Icon(Icons.home), Icon(Icons.ac_unit)],
//          currentAccountPicture: CircleAvatar(
//            backgroundImage: NetworkImage(
//                'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
//          ),
//        ),
//        ListTile(
//          title:  Text(
//            'إعلان جديد',
//            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
//          ),
//          leading: Icon(Icons.add),
//          onTap: () {
//            Get.put<NewAdController>(NewAdController());
//             Get.toNamed(Routers.newAd);
//
//            // GetBuilder<NewAdController>(
//            //     init: NewAdController(),
//            //     builder: (c) {
//            //       return IconButton(
//            //         onPressed: () async {
//            //
//            //           // return await Get.to(() => NewAdView());
//            //           // await c.getCategoryList();
//            //         },
//            //         icon: Icon(Icons.add),
//            //         tooltip: "Add Ad",
//            //       );
//            //     });
//          },
//        ),
//        ListTile(
//          title: Text(
//            'Login',
//            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
//          ),
//          leading: Icon(Icons.login),
//          onTap: () {
//            Get.put<LoginController>(LoginController());
//            Get.toNamed(Routers.login);
//          },
//        ),
//        ListTile(
//          title: Text(
//            'Logout',
//            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
//          ),
//          leading: Icon(Icons.logout),
//          onTap: () async {
//            await LocalStorage().deleteToken();
//            var storedToken= await LocalStorage().readToken();
//            print("token : $storedToken ");
//
//            // .then((value) => Get.to(() => LoginView()));
//            //     .then((value) => Get.offAllNamed(Routers.login));
//            // await Get.offAllNamed(Routers.login);
//          },
//        ),
//        ListTile(
//          title: Text(
//            'الحساب',
//            style: fontStyle.copyWith(color: Colors.blue, fontSize: 16),
//          ),
//          leading: Icon(Icons.settings),
//          onTap: () {
//            Get.put<ProfileController>(ProfileController());
//            Get.toNamed(Routers.profile);
//          },
//        )
//      ],
//    );
//  }
}
