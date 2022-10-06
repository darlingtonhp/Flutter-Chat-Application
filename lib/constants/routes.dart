import 'package:talkapp/views/home_view.dart';
import 'package:talkapp/views/login_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:talkapp/views/verify_number_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginView, initial: true),
    AutoRoute(page: HomeView),
    AutoRoute(page: VerifyNumberView),
  ],
)
class $AppRouter {}
