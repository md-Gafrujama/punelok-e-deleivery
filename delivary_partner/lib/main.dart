import 'package:delivary_partner/core/constant/my_constant.dart';
import 'package:delivary_partner/core/extentions/tablet_extension.dart';
import 'package:delivary_partner/core/infra/break_point.dart';
import 'package:delivary_partner/core/routes/app_router.dart';
import 'package:delivary_partner/core/shared/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main()async{
//  WidgetsFlutterBinding.ensureInitialized();
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Add your initialization logic here
  await Future.delayed(const Duration(seconds: 3));

  FlutterNativeSplash.remove();
 
//  await LocalStorageService.init();
runApp(
  ProviderScope(
    child: myapp()));
}

// ignore: camel_case_types
class myapp extends HookConsumerWidget {
  const myapp({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final myRouter = ref.watch(myAppRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return BambooBreakPoint(
      child: Builder(
        builder: (context) {
          Size designSize;
          if (context.isMobile) {
            designSize = Size(402, 874);
          } else {
            designSize = Size(800, 1280);
          }
          return ScreenUtilPlusInit(
            designSize: designSize,
            child: Builder(
              builder: (context) {
                return MaterialApp.router(
                  title: AppConstant.appName,
                  debugShowCheckedModeBanner: false,
                  // theme: MyThemeApp.myLightTheme,
                  // darkTheme: MyThemeApp.myTradingDarkTheme,
                  themeMode: themeMode,
                  // themeMode: .dark,h
                  routerConfig: myRouter,
                  // locale: context.locale,
                  // supportedLocales: context.supportedLocales,
                  // localizationsDelegates: context.localizationDelegates,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaler: .linear(1.0)),
                      child: child!,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}