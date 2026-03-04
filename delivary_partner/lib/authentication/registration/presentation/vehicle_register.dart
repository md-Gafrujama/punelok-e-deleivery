import 'package:delivary_partner/authentication/shared/authprovider.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

// ignore: camel_case_types
class vehicleRegisterPage extends HookConsumerWidget {
  const vehicleRegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int>(-1);

    final vehicles = [
      {"title": "Motorcycle", "image": "assets/images/X01.png"},
      {"title": "Bicycle", "image": "assets/images/X03.png"},
      {"title": "Electric scooter", "image": "assets/images/X02.png"},
      {
        "title": "I dont't have a vehicle\nNo Vehicle? We'll help!",
        "image": "assets/images/X02.png",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            /// Top Bar
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select vehicle",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showLogoutBottomSheet(context);
                      // Your action here
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// Vehicle List
            Expanded(
              child: ListView.separated(
                itemCount: vehicles.length,
                separatorBuilder: (_, _) => SizedBox(height: 20.h),
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      selectedIndex.value = index;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2B2B),
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.green
                                : Colors.grey.shade800,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.r),
                              ),
                              child: Container(
                                height: 155.h,
                                width: double.infinity,
                                color: Colors.white,
                                child: Image.asset(
                                  vehicles[index]["image"]!,
                                  fit: BoxFit.fitWidth,
                                  height: 120.h, // 🔥 important
                                ),
                              ),
                            ),

                            /// Bottom Section
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vehicles[index]["title"]!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  /// Radio Circle
                                  Container(
                                    height: 22.h,
                                    width: 22.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.green
                                            : Colors.white54,
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Center(
                                            child: Container(
                                              height: 10.h,
                                              width: 10.w,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),

            /// Next Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return const Color.fromARGB(255, 71, 70, 70);
                      }
                      return const Color(0xFF29ED0A);
                    }),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                  onPressed: selectedIndex.value == -1
                      ? null
                      : () {
                          debugPrint(
                            "Selected: ${vehicles[selectedIndex.value]["title"]}",
                          );

                          context.goNamed(AppRoutesName.selectCityPageName);
                        },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // better for green bg
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

//logout functionality
void showLogoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return const LogoutBottomSheet();
    },
  );
}

//bottmsheet
class LogoutBottomSheet extends HookConsumerWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "More options",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(color: Colors.white24),

            const SizedBox(height: 20),

            /// Logout Tile
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await ref.read(authControllerProvider.notifier).logout();
                // ignore: use_build_context_synchronously
                context.goNamed(
                  AppRoutesName.LoginPageName,
                ); // ✅ go to onboarding
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF111111),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.power_settings_new,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Your progress will be saved",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
