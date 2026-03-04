import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AadhaarVerificationPage extends StatelessWidget {
  const AadhaarVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: _buildHelpButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 20.h),

            /// Scroll Area
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    _buildVideoCard(),
                    SizedBox(height: 32.h),
                    _buildBenefitsTitle(),
                    SizedBox(height: 16.h),
                    _buildBenefitCard(),
                  ],
                ),
              ),
            ),

            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Text(
            "Submit Aadhaar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          CircleAvatar(radius: 18.r, backgroundColor: Colors.purple),
          SizedBox(width: 8.w),
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  // ---------------- VIDEO CARD ----------------

  Widget _buildVideoCard() {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6D94F),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white,
          width: 2.w, // adjust thickness if needed
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How to Verify\nAadhaar Card?",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "1m 5s",
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
              ],
            ),
          ),

          /// Play Button
          Center(
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: const Color.fromARGB(255, 42, 41, 41),
                  width: 1.6.w,
                ),
              ),
              child: Icon(Icons.play_arrow, size: 32.sp, color: Colors.black),
            ),
          ),

          /// Fake Aadhaar Image
          Positioned(
            right: 10.w,
            top: 20.h,
            child: Icon(
              Icons.credit_card,
              size: 90.sp,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BENEFITS TITLE ----------------

  Widget _buildBenefitsTitle() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[700])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            "BENEFITS OF AADHAAR",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.sp,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[700])),
      ],
    );
  }

  // ---------------- BENEFIT CARD ----------------

  Widget _buildBenefitCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: Colors.green,
            child: Icon(Icons.check, size: 16.sp, color: Colors.white),
          ),
          SizedBox(width: 12.w),

          /// Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID verification time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Without Aadhaar",
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ),

          /// Right Values
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "5 Minutes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "2-3 days",
                style: TextStyle(color: Colors.grey, fontSize: 13.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- BOTTOM ----------------

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF19B369),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Verify your Aadhaar",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Skip Aadhaar verification",
            style: TextStyle(
              color: const Color(0xFF19B369),
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HELP BUTTON ----------------

  Widget _buildHelpButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFF19B369),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.phone, color: Colors.white, size: 20.sp),
          SizedBox(width: 6.w),
          Text(
            "Help",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
