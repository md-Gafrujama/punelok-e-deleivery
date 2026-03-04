import 'package:delivary_partner/authentication/shared/authprovider.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: camel_case_types
class homePage extends HookConsumerWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Home Page"),
          ),
ElevatedButton(
  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
  onPressed: () async {
    await ref.read(authControllerProvider.notifier).logout();
    // ✅ Router redirect will automatically send to onboarding
    // But also push explicitly to be safe:
    context.goNamed(AppRoutesName.onboardingPageName);
  },
  child: const Text(
    "Logout",
    style: TextStyle(color: Colors.white),
  ),
)

        ],
      ),
    );
  }
}