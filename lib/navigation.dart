import 'package:flutter/material.dart';
import 'package:mytt_front/screens/assistance.dart';
import 'package:mytt_front/screens/home.dart';
import 'package:mytt_front/screens/login.dart';
import 'package:mytt_front/screens/send_code.dart';
import 'package:mytt_front/widgets/bottom_navBar.dart';

import 'screens/baseWidget.dart';

// class Navigation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: (context, child) => BaseWidget(child: child),
//       initialRoute: '/home',
//       routes: {
//         '/home': (context) => Home(),
//         '/assistance': (context) => Assistance(),
//         '/third': (context) => Login(),
//         '/fourth': (context) => SendCode(),
//       },
//     );
//   }
// }

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildNavigator(context),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, Map args) {
    return {
      "/home": (context) {
        return Home();
      },
      '/account': (context) {
        return Account();
      },
      '/menu': (context) {
        return Menu();
      }
    };
  }

  Widget _buildNavigator(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        final args = settings.arguments ?? {};
        var routeBuilders = _routeBuilders(context, args as Map);
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (context) {
            return routeBuilders[settings.name]!(context);
          },
        );
      },
    );
  }
}