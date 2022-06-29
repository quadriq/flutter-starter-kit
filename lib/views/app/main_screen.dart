import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/utils/v.dart';

import 'package:flutter_starter/views/home/home_tab.dart';
import 'package:flutter_starter/views/settings/settings_tab.dart';
import 'package:theme_provider/theme_provider.dart';

class MainScreen extends StatefulWidget {

  final String? themeId;

  const MainScreen({Key? key, this.themeId}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _tabSelectedIndex = 0;

  final _screens = [
    const HomeTab(),
    const SettingsTab()
  ];

  late var _themeIcon ;

  @override
  void initState() {
    super.initState();
    _themeIcon = widget.themeId == V.THEME_LIGHT ?
        Icons.light_mode : Icons.dark_mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('app_name')),
        actions: [
          IconButton(
            icon: Icon(_themeIcon),
            onPressed: () {
              _changeTheme();
            },
          )
        ],
      ),
      body: _screens[_tabSelectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.red),
        child: NavigationBar(
          onDestinationSelected: (index) =>
              setState(() => _tabSelectedIndex = index),
          selectedIndex: _tabSelectedIndex,
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.home), label: tr('tab_home')),
            NavigationDestination(
                icon: Icon(Icons.settings), label: tr('tab_settings')),
          ],
        ),
      ),
    );
  }

  _changeTheme(){
    var controller = ThemeProvider.controllerOf(context);
    if(ThemeProvider.themeOf(context).id == V.THEME_LIGHT){
      controller.setTheme(V.THEME_DARK);
      _themeIcon = Icons.dark_mode;
    } else {
      controller.setTheme(V.THEME_LIGHT);
      _themeIcon = Icons.light_mode;
    }
  }
}
