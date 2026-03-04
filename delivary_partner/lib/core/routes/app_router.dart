
// import 'package:delivary_partner/authentication/presentation/login_page.dart';

// import 'package:delivary_partner/authentication/presentation/otp_page.dart';
// import 'package:delivary_partner/core/infra/secured_storage.dart';
// import 'package:delivary_partner/dashobord/registration/presentation/adhar_verification_page.dart';
// import 'package:delivary_partner/dashobord/registration/presentation/select_city_page.dart';
// import 'package:delivary_partner/dashobord/registration/presentation/select_store_page.dart';
// import 'package:delivary_partner/dashobord/registration/presentation/vehicle_register.dart';
// import 'package:delivary_partner/core/infra/local_storage_services.dart';
// import 'package:delivary_partner/core/routes/app_routes_name.dart';
// import 'package:delivary_partner/core/routes/app_routes_path.dart';
// import 'package:delivary_partner/core/routes/page_transition.dart';
// import 'package:delivary_partner/dashobord/home/presentation/home_page.dart';
// import 'package:delivary_partner/onboard/onboarding_page.dart';

// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final authTokenProvider = FutureProvider<String?>((ref) async {
//   return await SecureStorageService.getToken();
// });
// final myAppRouterProvider = Provider<GoRouter>((ref) {
//   // final isLoggedIn = LocalStorageService.userId.isNotEmpty;
//    final token = await SecureStorageService.getToken();
//   final isLoggedIn = token != null && token.isNotEmpty;

//   return GoRouter(
//     initialLocation: isLoggedIn
//         ? AppRoutesPath.homePage
//         : AppRoutesPath.onboardingPage,
//     redirect: (context, state) {
//       return null;
//     },
//     routes: [
//       GoRoute(
//         name: AppRoutesName.onboardingPageName,
//         path: AppRoutesPath.onboardingPage,
//         pageBuilder: (context, state) {
//           return PageTransition(child:OnboardingPage());
//         },
//       ),
//       GoRoute(
//         name: AppRoutesName.homePageName,
//         path: AppRoutesPath.homePage,
//         pageBuilder: (context, state) {
//           return PageTransition(child: homePage());
//         },
//       ),
//       //login 
//        GoRoute(
//         name: AppRoutesName.LoginPageName,
//         path: AppRoutesPath.loginPage,
//         pageBuilder: (context, state) =>
//             PageTransition(child: const LoginPage()),
//       ),
//       //otp
//         GoRoute(
//         name: AppRoutesName.otpPageName,
//         path: AppRoutesPath.otpPage,
//         pageBuilder: (context, state) =>
//             PageTransition(child: const OtpPage()),
//       ),
//       //user registration
//        GoRoute(
//         name: AppRoutesName.vehicleRegisterPageName,
//         path: AppRoutesPath.registerVehiclePage,
//         pageBuilder: (context, state) =>
//             PageTransition(child:  vehicleRegisterPage()),
//       ),
//        GoRoute(
//         name: AppRoutesName.selectCityPageName,
//         path: AppRoutesPath.selectCityPage,
//         pageBuilder: (context, state) =>
//             PageTransition(child:  SelectCityPage()),
//       ),
//          GoRoute(
//         name: AppRoutesName.selectStorePageName,
//         path: AppRoutesPath.selectStorePage,
//         pageBuilder: (context, state) =>
//             PageTransition(child:  SelectStorePage()),
//       ),
//          GoRoute(
//         name: AppRoutesName.aadhaarVerificationPageName,
//         path: AppRoutesPath.aadhaarVerificationPage,
//         pageBuilder: (context, state) =>
//             PageTransition(child:  AadhaarVerificationPage()),
//       ),
//       // StatefulShellRoute.indexedStack(
//       //   branches: [
//       //     StatefulShellBranch(
//       //       routes: [
//       //         GoRoute(
//       //           name: AppRoutesName.panelName,
//       //           path: AppRoutesPath.panel,
//       //           pageBuilder: (context, state) =>
//       //               PageTransition(child: const PanelPage()),
//       //           routes: [
//       //             //games page route
//       //             GoRoute(
//       //               name: AppRoutesName.gamesPageName,
//       //               path: AppRoutesPath.gamesPage,
//       //               pageBuilder: (context, state) =>
//       //                   PageTransition(child: const GamesPage()),
//       //             ),
//       //           ],
//       //         ),
//       //       ],
//       //     ),

//       //     StatefulShellBranch(
//       //       routes: [
//       //         GoRoute(
//       //           name: AppRoutesName.chartName,
//       //           path: AppRoutesPath.chart,
//       //           pageBuilder: (context, state) =>
//       //               PageTransition(child: const ChartPage()),
//       //           routes: [],
//       //         ),
//       //       ],
//       //     ),
//       //     StatefulShellBranch(
//       //       routes: [
//       //         GoRoute(
//       //           name: AppRoutesName.referralName,
//       //           path: AppRoutesPath.referral,
//       //           pageBuilder: (context, state) =>
//       //               PageTransition(child: const RefferalPage()),
//       //         ),
//       //         GoRoute(
//       //           name: AppRoutesName.referralHistoryName,
//       //           path: AppRoutesPath.referralHistory,
//       //           pageBuilder: (context, state) =>
//       //               PageTransition(child: const ReferralHistoryScreen()),
//       //         ),
//       //       ],
//       //     ),
//       //     StatefulShellBranch(
//       //       routes: [
//       //         GoRoute(
//       //           name: AppRoutesName.profileName,
//       //           path: AppRoutesPath.profile,
//       //           pageBuilder: (context, state) =>
//       //               PageTransition(child: const ProfilePage()),
//       //         ),
//       //       ],
//       //     ),
//       //   ],
//       //   pageBuilder: (context, state, navigationShell) {
//       //     return PageTransition(
//       //       child: DashoboardBase(navigationShell: navigationShell),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.walletName,
//       //   path: AppRoutesPath.wallet,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const WalletPage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.redeemMethodName,
//       //   path: AppRoutesPath.redeemMethod,
//       //   pageBuilder: (context, state) => PageTransition(
//       //     child: RedeemMethodPage(
//       //       methodRaw: state.pathParameters['method'] ?? 'upi',
//       //     ),
//       //   ),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.redeemHistoryName,
//       //   path: AppRoutesPath.redeemHistory,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const RedeemHistoryPage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.adminControlName,
//       //   path: AppRoutesPath.adminControl,
//       //   pageBuilder: (context, state) =>
//       //   PageTransition(child: const AdminControlPage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.flappyBirdGameName,
//       //   path: AppRoutesPath.flappyBirdGame,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const FlappyBirdGamePage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.hitTheRoadMiniGameName,
//       //   path: AppRoutesPath.hitTheRoadMiniGame,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const HitTheRoadMiniGamePage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.memoryMatchGameName,
//       //   path: AppRoutesPath.memoryMatchGame,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const MemoryMatchGamePage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.cricketGameName,
//       //   path: AppRoutesPath.cricketGame,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const CricketGamePage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.dinoGameName,
//       //   path: AppRoutesPath.dinoGame,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const DinoGamePage()),
//       // ),
//       // GoRoute(
//       //   name: AppRoutesName.bossFlightGameName,
//       //   path: AppRoutesPath.bossFlightGame,
//       //   pageBuilder: (context, state) =>
//       //       PageTransition(child: const BossFlightGamePage()),
//       // ),

//     ],
//   );
// });
import 'package:delivary_partner/authentication/presentation/login_page.dart';
import 'package:delivary_partner/authentication/presentation/otp_page.dart';
import 'package:delivary_partner/core/infra/secured_storage.dart';
import 'package:delivary_partner/authentication/registration/presentation/adhar_verification_page.dart';
import 'package:delivary_partner/authentication/registration/presentation/select_city_page.dart';
import 'package:delivary_partner/authentication/registration/presentation/select_store_page.dart';
import 'package:delivary_partner/authentication/registration/presentation/vehicle_register.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:delivary_partner/core/routes/app_routes_path.dart';
import 'package:delivary_partner/core/routes/page_transition.dart';
import 'package:delivary_partner/dashobord/home/presentation/home_page.dart';
import 'package:delivary_partner/onboard/onboarding_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myAppRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutesPath.onboardingPage, // ✅ always start here, redirect handles the rest

    // ✅ async redirect — runs on every navigation, checks token
    redirect: (context, state) async {
      final token = await SecureStorageService.getToken();
      final isLoggedIn = token != null && token.isNotEmpty;

      final currentPath = state.matchedLocation;

      final isAuthPath = currentPath == AppRoutesPath.onboardingPage ||
          currentPath == AppRoutesPath.loginPage ||
          currentPath == AppRoutesPath.otpPage;

      // Not logged in + trying to access protected route → onboarding
      if (!isLoggedIn && !isAuthPath) {
        return AppRoutesPath.onboardingPage;
      }

      // Already logged in + on auth pages → skip to home
      if (isLoggedIn && isAuthPath) {
        return AppRoutesPath.homePage;
      }

      return null; // no redirect needed
    },

    routes: [
      GoRoute(
        name: AppRoutesName.onboardingPageName,
        path: AppRoutesPath.onboardingPage,
        pageBuilder: (context, state) =>
            PageTransition(child: OnboardingPage()),
      ),
      GoRoute(
        name: AppRoutesName.homePageName,
        path: AppRoutesPath.homePage,
        pageBuilder: (context, state) =>
            PageTransition(child: homePage()),
      ),
      GoRoute(
        name: AppRoutesName.LoginPageName,
        path: AppRoutesPath.loginPage,
        pageBuilder: (context, state) =>
            PageTransition(child: const LoginPage()),
      ),
      GoRoute(
        name: AppRoutesName.otpPageName,
        path: AppRoutesPath.otpPage,
        pageBuilder: (context, state) =>
            PageTransition(child: const OtpPage()),
      ),
      GoRoute(
        name: AppRoutesName.vehicleRegisterPageName,
        path: AppRoutesPath.registerVehiclePage,
        pageBuilder: (context, state) =>
            PageTransition(child: vehicleRegisterPage()),
      ),
      GoRoute(
        name: AppRoutesName.selectCityPageName,
        path: AppRoutesPath.selectCityPage,
        pageBuilder: (context, state) =>
            PageTransition(child: SelectCityPage()),
      ),
      GoRoute(
        name: AppRoutesName.selectStorePageName,
        path: AppRoutesPath.selectStorePage,
        pageBuilder: (context, state) =>
            PageTransition(child: SelectStorePage()),
      ),
      GoRoute(
        name: AppRoutesName.aadhaarVerificationPageName,
        path: AppRoutesPath.aadhaarVerificationPage,
        pageBuilder: (context, state) =>
            PageTransition(child: AadhaarVerificationPage()),
      ),
    ],
  );
});