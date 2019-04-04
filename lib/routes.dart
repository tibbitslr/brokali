import 'package:flutter/material.dart';

import 'package:brokali/pages/list/_list.dart';
// import 'package:brokali/pages/about/about.dart';
// import 'package:brokali/pages/contact/contact.dart';
// import 'package:brokali/pages/profile/profile.dart';
// import 'package:brokali/pages/settings/settings.dart';

RouteFactory broRoutes = (RouteSettings settings) {
  switch (settings.name) {
    case '/list':
      return _route(BroListPage(settings.arguments));
    case '/list_invitation':
      return _route(BroListInvitationPage(settings.arguments));
  }
};

MaterialPageRoute _route(Widget widget) =>
    MaterialPageRoute(builder: (_) => widget);
