import 'package:delivary_partner/core/extentions/text_style.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      
      body:
     Stack(
  children: [
    /// 🔹 Background Image (Full Screen)
    Positioned.fill(
      child: Image.asset(
        "assets/images/POST.png",
        fit: BoxFit.cover, // IMPORTANT
      ),
    ),
    Positioned(
      top: 44.h,
      right: 10.w,
      child: Container(
        height: 25.h,
        width: 25.w,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.green,
        ),
        child: Center(
          child: Text(
                "अ /A",
                style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.2.sp,
                ),
              ),
        ),
      ),
    ),
    /// 🔹 Bottom Black Section
    Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 300.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 22.h,
        ),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Start delivering orders\nwith Dash",
              textAlign: TextAlign.center,
              style: context.headlineExtraLarge.copyWith(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 45.h),

            /// Continue Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1CC65B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  context.goNamed(AppRoutesName.LoginPageName);
                },
                child: Text(
                  "Continue",
                  style: context.headlineLarge.copyWith(
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
    );
  }
}