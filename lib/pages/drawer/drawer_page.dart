import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/main_bloc.dart';
// import 'package:brokali/pages/about/about_page.dart';
// import 'package:brokali/pages/contact/contact_page.dart';
// import 'package:brokali/pages/profile/_profile.dart';

import '_drawer.dart';

class BroDrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BroMainBloc mainBloc = BlocProvider.of<BroMainBloc>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          BroDrawerHeader(),
          BroDrawerItem(
            label: 'Profile',
            icon: Icons.list,
            // onTap: () =>
            // Navigator.popAndPushNamed(context, BroProfilePage.routeName),
          ),
          BroDrawerItem(
            label: 'Lists Archive',
            icon: Icons.list,
            // onTap: () =>
            //     Navigator.popAndPushNamed(context, BroProfilePage.routeName),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Divider(
              height: 0.0,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          BroDrawerItem(
            label: 'PRO',
            icon: Icons.list,
            // onTap: () =>
            //     Navigator.popAndPushNamed(context, BroProfilePage.routeName),
            pro: true,
          ),
          BroDrawerItem(
            label: 'Settings',
            icon: Icons.settings,
            // onTap: () =>
            //     Navigator.popAndPushNamed(context, BroProfilePage.routeName),
          ),
          BroDrawerItem(
            label: 'About Us',
            icon: Icons.email,
            // onTap: () =>
            //     Navigator.popAndPushNamed(context, BroAboutPage.routeName),
          ),
          BroDrawerItem(
            label: 'Contact Us',
            icon: Icons.email,
            // onTap: () =>
            //     Navigator.popAndPushNamed(context, BroContactPage.routeName),
          ),
          BroDrawerItem(
            label: 'FAQ',
            icon: Icons.help,
            // onTap: () =>
            //     Navigator.popAndPushNamed(context, BroProfilePage.routeName),
          ),
          BroDrawerItem(
            label: 'LogOut',
            icon: Icons.exit_to_app,
            onTap: () {
              Navigator.of(context).pop();
              mainBloc.dispatch(BroMainSignOutEvent());
            },
          ),
        ],
      ),
    );
  }
}
