import 'package:blinkit/searchfield.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget Categorycontent() {
  List<Map<String, String>> grocery = [
    {
      "name": "Vegetable & Fruits",
      "image": "assets/products/Grocery/grocery1.png"
    },
    {
      "name": "Atta,Rice & Dal",
      "image": "assets/products/Grocery/grocery2.png"
    },
    {
      "name": "Oil,Ghee & Masala",
      "image": "assets/products/Grocery/grocery3.png"
    },
    {
      "name": "Bakery & Biscuits",
      "image": "assets/products/Grocery/grocery4.png"
    },
    {
      "name": "Dry,Fruits & Cereals",
      "image": "assets/products/Grocery/grocery5.png"
    },
    {
      "name": "Chicken,Meat & Fish",
      "image": "assets/products/Grocery/grocery6.png"
    },
  ];

  List<Map<String, String>> snacks = [
    {"name": "Chips & Namkeen", "image": "assets/products/snacks/snacks1.png"},
    {
      "name": "Sweets & Chocolates",
      "image": "assets/products/snacks/snacks2.png"
    },
    {"name": "Drinks & Juices", "image": "assets/products/snacks/snacks3.png"},
    {"name": "Instant Food", "image": "assets/products/snacks/snacks4.png"},
    {"name": "Sauces & Spreads", "image": "assets/products/snacks/snacks5.png"},
    {
      "name": "Ice Creams & More",
      "image": "assets/products/snacks/snacks6.png"
    },
  ];

  List<Map<String, String>> personalcare = [
    {"name": "Bath & Body", "image": "assets/products/care/care1.png"},
    {
      "name": "Hair",
      "image": "assets/products/care/care2.png"
    },
    {"name": "Skin & Face", "image": "assets/products/care/care3.png"},
    {"name": "Beauty & Cosmetics", "image": "assets/products/care/care4.png"},
    {"name": "Feminine Hygiene", "image": "assets/products/care/care5.png"},
    {
      "name": "Baby Care",
      "image": "assets/products/care/care6.png"
    },
  ];

  List<Map<String, String>> household = [
    {"name": "Bath & Body", "image": "assets/products/homecare/homecare1.png"},
    {
      "name": "Hair",
      "image": "assets/products/homecare/homecare2.png"
    },
    {"name": "Skin & Face", "image": "assets/products/homecare/homecare3.png"},
    {"name": "Beauty & Cosmetics", "image": "assets/products/homecare/homecare4.png"},
   
  ];
  

  return SafeArea(
      child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo + Cart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "blinkit",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff6c800),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigation to profile page
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                    },
                    child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   color: Colors.grey.shade300
                          // )
                        ),
                        child: const Icon(Icons.person)),
                  ),
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
            ],
          ),
        ),
        Section("Grocery & Kitchen", grocery),
        Section("Snacks & Drinks", snacks),
        Section("Beauty & Personal Care", personalcare),
        Section("Household Essentials", household),
      ],
    ),
  ));
}

Widget Section(String title, List<Map<String, String>> list) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        /// Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return categoryContainer(list[index]);
          },
        ),
      ],
    ),
  );
}

Widget categoryContainer(Map<String, String> item) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          item["image"]!,
          height: 60,
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        item["name"]!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
