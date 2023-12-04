import 'package:cholay_ice_sale/core/services/printer_service.dart';
import 'package:cholay_ice_sale/screens/fade_page_route_builder.dart';
import 'package:cholay_ice_sale/screens/language/app_localizations.dart';
import 'package:cholay_ice_sale/screens/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/language/AppLanguage.dart';
import 'di/get_it.dart' as getIt;
import 'common/constants/route_constants.dart';
import 'common/themes/app_color.dart';
import 'common/themes/theme_text.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getIt.init();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appLanguage});

  final AppLanguage appLanguage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PrinterService()),
          ChangeNotifierProvider(
            create: (context) => appLanguage,
          ),
        ],
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cholay Ice',
            theme: ThemeData(
              unselectedWidgetColor: AppColor.royalBlue,
              primaryColor: AppColor.primaryColor,
              scaffoldBackgroundColor: AppColor.primaryColor,
              brightness: Brightness.light,
              cardTheme: CardTheme(
                color: AppColor.primaryColor,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: ThemeText.getTextTheme(),
              appBarTheme: const AppBarTheme(
                  elevation: 0, backgroundColor: AppColor.primaryColor),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: Theme.of(context).textTheme.greySubtitle1,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            // home: HomeScreen(),
            // builder: (context, child) {
            //   return LoadingScreen(screen: child!);
            // },
            locale: model.appLocal,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('my', 'MY'),
              // Locale('ar', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            initialRoute: RouteList.initial,
            onGenerateRoute: (RouteSettings settings) {
              final routes = Routes.getRoutes(settings);
              final WidgetBuilder? builder = routes[settings.name];
              return FadePageRouteBuilder(
                builder: builder!,
                settings: settings,
              );
            },
          );
        }));
  }
}
