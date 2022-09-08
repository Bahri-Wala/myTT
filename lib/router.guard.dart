// import 'package:auto_route/auto_route.dart';
// import 'package:mytt_front/services/auth_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RouteGuard extends AutoRedirectGuard {
//   final AuthService authService;
//   RouteGuard(this.authService) {
//     authService.addListener(() {
//       if (!authService.authenticated) {
//         reevaluate();
//       }
//     });
//   }
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {

//     if (authService.authenticated) return resolver.next();
//     // TODO: Navigate to login screen
//   }
// }