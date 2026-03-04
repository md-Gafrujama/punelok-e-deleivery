
import 'package:delivary_partner/core/extentions/text_style.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:delivary_partner/authentication/registration/shared/selected_store_provider.dart';
import 'package:delivary_partner/authentication/registration/domain/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectStorePage extends HookConsumerWidget {
  const SelectStorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(filteredStoreProvider);
    final selectedIndex = ref.watch(selectedStoreProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: _helpButton(context),
      bottomNavigationBar: _nextButton(selectedIndex,context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// AppBar
              Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: () => 
                    Navigator.pop(context),
                    
                   ),
                  SizedBox(width: 12.w),
                  Text(
                    "Select store",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert,
                      color: Colors.white, size: 24.sp),
                ],
              ),

              SizedBox(height: 20.h),

              /// Search Bar
              _searchBar(ref),

              SizedBox(height: 20.h),

              /// Video Banner
              _videoBanner(),

              SizedBox(height: 20.h),

              /// Section Title
              _sectionTitle(),

              SizedBox(height: 16.h),

              /// Store List
              Expanded(
                child: ListView.builder(
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    final store = stores[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(selectedStoreProvider.notifier)
                            .state = index;
                      },
                      child: StoreCard(
                        store: store,
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//_searchBar
Widget _searchBar(WidgetRef ref) {
  return Container(
    alignment: Alignment.center,
    height: 50.h,
    decoration: BoxDecoration(
      color: const Color(0xFF2A2A2A),
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: TextField(
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).state = value;
      },
      decoration: InputDecoration(
        hintText: "Search stores in your city",
        hintStyle:
            TextStyle(color: Colors.white54, fontSize: 14.sp),
        prefixIcon:
            Icon(Icons.search, color: Colors.green, size: 22.sp),
        border: InputBorder.none,
      ),
    ),
  );
}
//video banner
Widget _videoBanner() {
  return Container(
    height: 150.h,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: const Color(0xFFF5D742),
      borderRadius: BorderRadius.circular(18.r),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "How to Select\nStore?",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.black.withOpacity(0.2),
            child: Icon(Icons.play_arrow,
                color: Colors.white, size: 30.sp),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              "1m 5s",
              style: TextStyle(
                  color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ),
      ],
    ),
  );
}
//
Widget _sectionTitle() {
  return Row(
    children: [
      Expanded(child: Divider(color: Colors.white24)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(
          "NEARBY STORES IN PUNE",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
      Expanded(child: Divider(color: Colors.white24)),
    ],
  );
}
Widget _helpButton(BuildContext context) {
  return FloatingActionButton.extended(
    backgroundColor: Colors.green,
    onPressed: () {},
    icon: const Icon(Icons.call, color: Colors.white),
    label:  Text("Help",style: context.headlineMedium.copyWith(color: Colors.white),),
  );
}Widget _nextButton(int selectedIndex, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16.w),
    child: SizedBox(
      height: 55.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedIndex == -1 ? Colors.grey : Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        onPressed: selectedIndex == -1
            ? null
            : () {
                context.goNamed(AppRoutesName.aadhaarVerificationPageName);
              },
        child: Text(
          "Next",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
    ),
  );
}



class StoreCard extends StatelessWidget {
  final StoreModel store;
  final bool isSelected;

  const StoreCard({
    super.key,
    required this.store,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [
                  Color(0xFF0F3D2E),
                  Color(0xFF14532D),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Recommended Tag
          if (store.recommended)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star,
                      size: 14.sp, color: Colors.white),
                  SizedBox(width: 4.w),
                  Text(
                    "Recommended",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 12.h),

          /// Store Name + Radio
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "${store.name} • ${store.distance}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: Colors.green,
                size: 22.sp,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// Address
          Text(
            store.address,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13.sp,
            ),
          ),

          SizedBox(height: 12.h),

          /// Bonus Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.currency_rupee,
                    color: Colors.green, size: 18.sp),
                SizedBox(width: 6.w),
                Text(
                  store.bonus,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}