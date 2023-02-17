

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/auth/sing_in_page.dart';

import 'package:food_delivery/pages/cart/cart_history.drt.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_pages.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
getuser() async{
  var firebase=myUser.currentUser;
  await firebase?.reload();
  firebase=myUser.currentUser;
  setState(() {
    newuser=firebase;
    print("value displ ${newuser}");
  });
}

  @override
   initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }
  FirebaseAuth myUser=FirebaseAuth.instance;
  var newuser;
  int _selectedIndex=0;
  //late PersistentTabController _controller;

  List pages=[
    MainFoodPage(),
    SignInPage(),
    // SignUpPage(),
    CartHistory(),
    Container(child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          child: Text("SignOut"),
          onPressed:() async {
            var sharedPreferences =await SharedPreferences.getInstance();
            sharedPreferences.remove(SplashScreenState.KEYLOGIN);
            FirebaseAuth.instance.signOut().then((value) => Get.offNamed(RouteHelper.singInPage));
          },

        ),
        SizedBox(
          height: Dimension.height20,
        ),
      ],
    )),


  ];
  void onTapNav(int index)
  {
    setState(() {
      _selectedIndex=index;
    });

  }

  // @override
  // void initState()
  // {
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  //
  // }
  // List<Widget> _buildScreens() {
  //   return [
  //     MainFoodPage(),
  //     Container(child:Center(child: Text("Next Page")),),
  //     Container(child:Center(child: Text("Next next Page")),),
  //     Container(child:Center(child: Text("Next next next Page")),),
  //   ];
  // }
  //
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.home),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.archivebox_fill),
  //       title: ("Archive"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.cart_fill),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.person),
  //       title: ("Me"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
            label: "home"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.archive),
              label: "history"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
              label: "Cart"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
              label: "me"
          ),
        ],
      ),

    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     confineInSafeArea: true,
  //     backgroundColor: Colors.white, // Default is Colors.white.
  //     handleAndroidBackButtonPress: true, // Default is true.
  //     resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //     stateManagement: true, // Default is true.
  //     hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       colorBehindNavBar: Colors.white,
  //     ),
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
  //       duration: Duration(milliseconds: 200),
  //       curve: Curves.ease,
  //     ),
  //     screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
  //       animateTabTransition: true,
  //       curve: Curves.ease,
  //       duration: Duration(milliseconds: 200),
  //     ),
  //     navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
  //   );
  // }
}
