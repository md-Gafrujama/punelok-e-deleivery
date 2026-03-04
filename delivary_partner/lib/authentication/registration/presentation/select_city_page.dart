import 'package:delivary_partner/authentication/registration/shared/selected_city_provider.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SelectCityPage extends HookConsumerWidget {
  const SelectCityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    const nearbyCities = ["Pune"];

const allCities = [
  "Agra",
  "Ahmedabad",
  "Ahmednagar",
  "Ajmer",
  "Akola",
  "Aligarh",
  "Allahabad",
  "Alwar",
  "pune",
  "mumbai",
  "chennai",

];

    final searchController = useTextEditingController();
    final searchQuery = useState("");
    final selectedCity = ref.watch(selectedCityProvider);

    /// Filtered list
    final filteredCities = allCities
        .where((city) =>
            city.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [

            /// 🔙 App Bar
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Row(
                children: [
                  IconButton(
                    icon:  Icon(Icons.arrow_back,
                        color: Colors.white),
                    onPressed: () =>context.goNamed(AppRoutesName.vehicleRegisterPageName),
                  ),
                  Text(
                    "Select city",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            /// 🔍 Search Box
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2B2B),
                  borderRadius: BorderRadius.circular(14.r),
                  
                  
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        color: Colors.green),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) =>
                            searchQuery.value = val,
                        style:
                            const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search your work city",
                          hintStyle:
                              TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// List
            Expanded(
              child: ListView(
                children: [

                  /// Nearby Section
                  sectionTitle("NEARBY CITIES"),

                  ...nearbyCities.map(
                    (city) => cityTile(
                      city,
                      selectedCity,
                      ref,
                    ),
                  ),
                    sectionTitleAll("ALL CITIES"),

                  // sectionTitle("ALL CITIES"),

                  ...filteredCities.map(
                    (city) => cityTile(
                      city,
                      selectedCity,
                      ref,
                    ),
                  ),
                ],
              ),
            ),

            /// Bottom Button
            Padding(
  padding: EdgeInsets.all(12.w),
  child: SizedBox(
    width: double.infinity,
    height: 55.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0DC365), // enabled
        disabledBackgroundColor:
            const Color(0xFF4A4A4A), // 👈 important
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      onPressed: selectedCity != null
          ? () {
         context.goNamed(AppRoutesName.selectStorePageName);
              // print("Selected: $selectedCity");
            }
          : null,
      child: Text(
        "Next",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: selectedCity != null
              ? Colors.black
              : Colors.white54,
        ),
      ),
    ),
  ),
)
          ],
        ),
      ),
    );
  }

  /// Section Title
  Widget sectionTitle(String title) {
    return Container(
      padding:  EdgeInsets.symmetric(
          horizontal: 16.w, vertical: 10.h),
      margin: const EdgeInsets.only(top: 10),
      color: const Color(0xFF2B2B2B),
      child: Row(
  children: [
    const Expanded(
      child: Divider(color: Colors.white),
    ),
     Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Text(
        "NEARBY CITIES",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Expanded(
      child: Divider(color: Colors.white),
    ),
  ],
),
    );
  }
   Widget sectionTitleAll(String title) {
    return Container(
      padding:  EdgeInsets.symmetric(
          horizontal: 16.w, vertical: 10.h),
      margin: const EdgeInsets.only(top: 10),
      color: const Color(0xFF2B2B2B),
      child: Row(
  children: [
    const Expanded(
      child: Divider(color: Colors.white),
    ),
     Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Text(
        "ALL CITIES",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Expanded(
      child: Divider(color: Colors.white),
    ),
  ],
),
    );
  }

  /// City Tile
  // Widget cityTile(
  //     String city,
  //     String? selectedCity,
  //     WidgetRef ref) {
  //   final isSelected = selectedCity == city;

  //   return ListTile(
  //     title: Text(
  //       city,
  //       style: const TextStyle(
  //           color: Colors.white, fontSize: 16),
  //     ),
  //     tileColor:
  //         isSelected ? const Color(0xFF1E1E1E) : Colors.black,
  //     onTap: () {
  //       ref.read(selectedCityProvider.notifier).state =
  //           city;
  //     },
  Widget cityTile(
  String city,
  String? selectedCity,
  WidgetRef ref,
) {
  final isSelected = selectedCity == city;

  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    title: Text(
      city,
      style: TextStyle(
        color: isSelected ? Colors.green : Colors.white,
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    ),
    trailing: isSelected
        ? const Icon(Icons.check, color: Colors.green)
        : null,
    tileColor:
        isSelected ? const Color(0xFF1E1E1E) : Colors.black,
    onTap: () {
      ref.read(selectedCityProvider.notifier).state = city;
    },
  );
}
    
  }

