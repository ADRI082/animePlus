
import 'Drawer/DrawerUserController.dart';
import 'Drawer/HomeDrawer.dart';
import 'Portada/ListaScreen.dart';
import 'Utils/AppTheme.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView =  ListaScreen(titulo : 'Portada', tipo : 'portada');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = ListaScreen(titulo : 'Portada', tipo : 'portada');
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = Container();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = Container();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = Container();
        });
      } else {
        //do in your way......
      }
    }
  }
}
