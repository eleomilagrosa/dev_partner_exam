import 'package:dev_partner_exam2/constants/apptheme.dart';
import 'package:dev_partner_exam2/constants/routes.dart';
import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:dev_partner_exam2/controllers/dashboard_controller.dart';
import 'package:dev_partner_exam2/views/bookmark/bookmark_screen.dart';
import 'package:dev_partner_exam2/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppController>(create: (_) => AppController()),
        ],
        builder: (context, _) =>  MaterialApp(
        title: 'Flutter Demo',
        theme: themeDataLight,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.DASHBOARD_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          final arg = settings.arguments;
          switch (settings.name) {
            case Routes.BOOKMARKED_PAGE:
              return MaterialPageRoute(builder: (_) => BookmarkScreen(arg as DashboardController));
            case Routes.DASHBOARD_PAGE:
            default:
              return MaterialPageRoute(builder: (_) => DashboardScreen());
          }
        }
      ),
    );
  }
}