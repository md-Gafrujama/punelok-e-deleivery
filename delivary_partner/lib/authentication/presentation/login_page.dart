import 'package:delivary_partner/authentication/infra/authcontroller.dart';
import 'package:delivary_partner/authentication/shared/authprovider.dart';
import 'package:delivary_partner/core/extentions/toast_extention.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final authState = ref.watch(authControllerProvider);
    final isValid = useState(false);
    final hasText = useState(false);

    // useEffect(() {
    //   void listener() {
    //     isValid.value = phoneController.text.trim().length == 10;
    //     hasText.value = phoneController.text.isNotEmpty;
    //   }

    //   phoneController.addListener(listener);
    //   return () => phoneController.removeListener(listener);
    // }, [phoneController]);

    useEffect(() {
      void listener() {
        final text = phoneController.text.trim();
        isValid.value = RegExp(r'^[6-9]\d{9}$').hasMatch(text);
        hasText.value = phoneController.text.isNotEmpty;
      }

      phoneController.addListener(listener);
      return () => phoneController.removeListener(listener);
    }, [phoneController]);

    ref.listen<AsyncValue<AuthStatus>>(authControllerProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: (status) {
          if (status == AuthStatus.otpSent) {
            context.goNamed(
              AppRoutesName.otpPageName,
              extra: phoneController.text,
            );
            context.successToast('otp send successfully', Colors.green);
          }
        },
        error: (e, _) {
          final message = _getErrorMessage(e);
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Row(
                children: [
                  const Icon(Icons.wifi_off, color: Colors.redAccent),
                  SizedBox(width: 10.w),
                  Text(
                    "Connection Error",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ],
              ),
              content: Text(
                message,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: const Color(0xFF0DC365),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .read(authControllerProvider.notifier)
                        .requestOtp(phoneController.text);
                  },
                  child: Text(
                    "Retry",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true, // ✅ keyboard pushes content up
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.goNamed(AppRoutesName.onboardingPageName),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // ✅ fixes overflow when keyboard appears
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight, // ✅ fills screen so button stays at bottom
              ),
              child: IntrinsicHeight(
                // ✅ allows Spacer to work inside scroll
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo
                    Center(
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'das',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 45.sp,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'h',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "PARTNER",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 50.h),

                    Center(
                      child: Text(
                        "Sign in to your account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Center(
                      child: Text(
                        "Login or create an account",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    /// Phone Input
                    Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade800),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "🇮🇳  +91  |",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Enter mobile number",
                                hintStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 13.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                ),
                                suffixIcon: hasText.value
                                    ? GestureDetector(
                                        onTap: () => phoneController.clear(),
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.white38,
                                          size: 20.sp,
                                        ),
                                      )
                                    : null,
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 30.w,
                                  minHeight: 20.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.h),

                    /// Validation Error
                    // if (phoneController.text.isNotEmpty && !isValid.value)
                    //   Text(
                    //     "Enter a valid 10 digit mobile number",
                    //     style: TextStyle(
                    //       color: const Color.fromARGB(255, 118, 118, 118),
                    //       fontSize: 13.sp,
                    //     ),
                    //   ),
                    if (phoneController.text.isNotEmpty && !isValid.value)
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          phoneController.text.trim().length == 10
                              ? " Number must start with 6, 7, 8, or 9"
                              : " Enter a valid 10-digit mobile number",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),

                    const Spacer(), // ✅ works because of IntrinsicHeight
                    /// Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0DC365),
                          disabledBackgroundColor: const Color.fromARGB(
                            255,
                            100,
                            100,
                            100,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: isValid.value
                            ? () => ref
                                  .read(authControllerProvider.notifier)
                                  .requestOtp(phoneController.text)
                            : null,
                        child: authState.isLoading
                            ? SizedBox.square(
                                dimension: 25.sp,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.r,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isValid.value
                                      ? Colors.black
                                      : const Color.fromARGB(
                                          255,
                                          180,
                                          178,
                                          178,
                                        ),
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Center(
                      child: Text(
                        "By continuing, you agree to our Terms and Conditions",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _getErrorMessage(Object e) {
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return "Server is not responding.\nPlease check your connection and try again.";
      case DioExceptionType.connectionError:
        return "Cannot reach the server.\nMake sure you're on the right network.";
      case DioExceptionType.badResponse:
        return "Server error (${e.response?.statusCode}).\nPlease try again later.";
      default:
        return "Something went wrong.\nPlease try again.";
    }
  }
  return "Unexpected error. Please try again.";
}
