import 'package:blinkit/searchfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  int activeIndex = 0;

  final List<String> banners = [
    "assets/banner_img.png",
    "assets/promo1.png",
    "assets/promo2.png",
  ];

  final List<Map<String, String>> categories = [
    {"image": "assets/products/pan_corner.png", "title": "Paan\nCorner"},
    {"image": "assets/products/dairy_products.png", "title": "Dairy, Bread\n& Eggs"},
    {"image": "assets/products/fruit_veggies.png", "title": "Fruits &\nVegetables"},
    {"image": "assets/products/drinks_juice.png", "title": "Cold Drinks\n& Juices"},
    {"image": "assets/products/snacks.png", "title": "Snacks &\nMunchies"},
    {"image": "assets/products/breakfast_food.png", "title": "Breakfast &\nInstant Food"},
    {"image": "assets/products/sweet_tooth.png", "title": "Sweet\nTooth"},
    {"image": "assets/products/bakery_biscuit.png", "title": "Bakery &\nBiscuits"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= TOP SECTION =================
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo + Cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          "blinkit",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff6c800),
                          ),
                        ),
                        Icon(Icons.shopping_cart_outlined),
                      ],
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Delivery in 12 minutes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const Text(
                      "Pune Railway Station, Pune",
                      style: TextStyle(fontSize: 13),
                    ),

                    const SizedBox(height: 12),

                    /// 🔥 Animated Search Bar
                    BlinkitMobileSearchField(),
                    // Container(
                    //   height: 45,
                    //   padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xfff1f1f1),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.search, size: 20),
                    //       const SizedBox(width: 10),
                    //       Expanded(
                    //         child: DefaultTextStyle(
                    //           style: const TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //           child: AnimatedTextKit(
                    //             repeatForever: true,
                    //             animatedTexts: [
                    //               FadeAnimatedText(
                    //                 'Search "milk"',
                    //                 textStyle:
                    //                     const TextStyle(color: Colors.green),
                    //               ),
                    //               FadeAnimatedText(
                    //                 'Search "chocolate"',
                    //                 textStyle:
                    //                     const TextStyle(color: Colors.orange),
                    //               ),
                    //               FadeAnimatedText(
                    //                 'Search "fruits"',
                    //                 textStyle:
                    //                     const TextStyle(color: Colors.blue),
                    //               ),
                    //               FadeAnimatedText(
                    //                 'Search "snacks"',
                    //                 textStyle:
                    //                     const TextStyle(color: Colors.red),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// ================= HERO SLIDER =================
              CarouselSlider.builder(
                itemCount: banners.length,
                options: CarouselOptions(
                  height: 170,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() => activeIndex = index);
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      banners[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),

              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: banners.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ================= PROMO ROW =================
              SizedBox(
                height: 130,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        banners[index],
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              /// ================= CATEGORIES HEADER =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Dairy, Bread & Eggs",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E1E),
                        letterSpacing: -0.4,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF0C831F),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text("see all"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// ================= CATEGORIES WRAP (GRID) =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 24,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      categories.length,
                      (index) => SizedBox(
                        width: (MediaQuery.of(context).size.width - 32 - (3 * 12)) / 4, // 4 items per row accounting for spacing and padding
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 0.9,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4F6FB),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Hero(
                                  tag: 'mobile_category_$index',
                                  child: Image.asset(
                                    categories[index]["image"]!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categories[index]["title"]!.replaceAll("\n", " "),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                                height: 1.2,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
