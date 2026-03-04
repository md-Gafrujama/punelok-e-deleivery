// import 'dart:io';


// import 'package:delivary_partner/core/constant/my_colors.dart';
// import 'package:delivary_partner/core/extentions/screen_extentation.dart';
// import 'package:delivary_partner/core/extentions/svg_icon_extention.dart';
// import 'package:delivary_partner/core/extentions/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
// import 'package:flutter_svg/svg.dart' as Assets;
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class BottomNavWidget extends HookConsumerWidget {
//   final StatefulNavigationShell navigationShell;

//   const BottomNavWidget({super.key, required this.navigationShell});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SafeArea(
//       bottom: Platform.isAndroid,
//       child: AndroidBottomNavWidget(navigationShell: navigationShell),
//     );
//   }
// }

// class AndroidBottomNavWidget extends HookConsumerWidget {
//   final StatefulNavigationShell navigationShell;

//   const AndroidBottomNavWidget({super.key, required this.navigationShell});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 14.h),
//       child: Container(
//         height: 60.h,
//         decoration: BoxDecoration(
//           color: context.isLight ? Colors.black : AppColors.cardDarkColor,
//           borderRadius: BorderRadius.circular(500.r),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: _ItemBottom(
//                 index: 0,
//                 labelKey: 'dashboard',
//                 iconPath: Assets.svg.arrowDownUp.path,
//                 navigationShell: navigationShell,
//               ),
//             ),
//             Expanded(
//               child: _ItemBottom(
//                 index: 1,
//                 labelKey: 'chart',
//                 iconPath: Assets.svg.candel.path,
//                 navigationShell: navigationShell,
//               ),
//             ),
//             Expanded(
//               child: _ItemBottom(
//                 index: 2,
//                 labelKey: 'referral',
//                 iconPath: Assets.svg.upTrend.path,
//                 navigationShell: navigationShell,
//               ),
//             ),
//             Expanded(
//               child: _ItemBottom(
//                 index: 3,
//                 labelKey: 'profile',
//                 iconPath: Assets.svg.setting.path,
//                 navigationShell: navigationShell,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ItemBottom extends StatelessWidget {
//   final int index;
//   final String labelKey;
//   final String iconPath;
//   final StatefulNavigationShell navigationShell;
//   const _ItemBottom({
//     required this.index,
//     required this.labelKey,
//     required this.iconPath,
//     required this.navigationShell,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isSelected = navigationShell.currentIndex == index;
//     final Color activeIconColor = Colors.yellow;
//     final Color inactiveIconColor = context.isLight
//         ? Colors.white
//         : Colors.white70;
//     final Color activeBackgroundColor = context.isLight
//         ? Color.fromARGB(255, 1, 16, 16)
//         // ignore: use_full_hex_values_for_flutter_colors
//         : const Color.fromARGB(255, 31, 30, 30);
//     final color = isSelected ? activeIconColor : inactiveIconColor;

//     Widget content = Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(height: 4.h),
//         context.svgIcon(iconPath, color: color),
//         SizedBox(height: 4.h),
//         FittedBox(
//           child: Text(
//             labelKey.trim(),
//             style: context.headlineSmall.copyWith(
//               color: color,
//               fontSize: 11.sp,
//               letterSpacing: -0.5,
//             ),
//           ),
//         ),
//       ],
//     );
//     if (isSelected) {
//       content = Padding(
//         padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 500),
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//           decoration: ShapeDecoration(
//             color: activeBackgroundColor,
//             shape: const StadiumBorder(),
//           ),
//           child: content,
//         ),
//       );
//     } else {
//       content = content;
//     }

//     return GestureDetector(
//       onTap: () => navigationShell.goBranch(index),
//       behavior: HitTestBehavior.opaque,
//       child: content,
//     );
//   }
// }
