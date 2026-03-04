import 'dart:async';
import 'package:delivary_partner/authentication/infra/authcontroller.dart';
import 'package:delivary_partner/authentication/shared/authprovider.dart';
import 'package:delivary_partner/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class OtpPage extends HookConsumerWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = GoRouterState.of(context).extra as String;
    final authState = ref.watch(authControllerProvider);

    final controllers = List.generate(6, (index) => useTextEditingController());
    final focusNodes = List.generate(6, (index) => useFocusNode());
    final isChecked = useState(true);
    final isOtpComplete = useState(false);
    final seconds = useState(30);
    final timerRef = useRef<Timer?>(null);

    // ✅ ref.listen MUST be here — at the top level of build(), called ONCE
    ref.listen<AsyncValue<AuthStatus>>(authControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (status) {
          if (status == AuthStatus.verified) {
            context.goNamed(AppRoutesName.vehicleRegisterPageName);
          }
        },
        error: (error, stack) {
          // Clear boxes on wrong OTP
          for (final c in controllers) {
            c.clear();
          }
          isOtpComplete.value = false;
          focusNodes[0].requestFocus();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid OTP. Try again."),
              backgroundColor: Colors.redAccent,
            ),
          );
        },
      );
    });

    void startTimer() {
      timerRef.value?.cancel();
      seconds.value = 30;
      timerRef.value = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value <= 1) {
          timer.cancel();
          seconds.value = 0;
        } else {
          seconds.value--;
        }
      });
    }

    useEffect(() {
      startTimer();
      return () => timerRef.value?.cancel();
    }, const []);

    void checkOtpComplete() {
      isOtpComplete.value = controllers.every((c) => c.text.isNotEmpty);
    }

    String getOtp() => controllers.map((c) => c.text).join();

    // ✅ otpBox is a plain function returning a Widget — NO hooks inside
    Widget otpBox(int index) {
      return Expanded(
        child: Container(
          height: 60.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF3A3A3A),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: focusNodes[index].hasFocus
                      ? Colors.white
                      : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                focusNodes[index + 1].requestFocus();
              }
              if (value.isEmpty && index > 0) {
                focusNodes[index - 1].requestFocus();
              }
              checkOtpComplete();
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.goNamed(AppRoutesName.LoginPageName),
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "das",
                              style: TextStyle(color: Colors.white, fontSize: 38.sp, fontWeight: FontWeight.bold),
                              children: const [
                                TextSpan(text: "h", style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                          Text("PARTNER", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                        ],
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Center(
                      child: Column(
                        children: [
                          Text("Enter OTP", style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.h),
                          Text("OTP sent to $phone", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(children: List.generate(6, (index) => otpBox(index))),
                    if (authState.hasError)
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Text("Invalid or expired OTP", style: TextStyle(color: Colors.red, fontSize: 14.sp)),
                      ),
                    SizedBox(height: 20.h),
                    Center(
                      child: GestureDetector(
                        onTap: seconds.value == 0
                            ? () async {
                                await ref.read(authControllerProvider.notifier).requestOtp(phone);
                                startTimer();
                              }
                            : null,
                        child: Text(
                          seconds.value == 0
                              ? "Resend SMS"
                              : "Didn't get the OTP? Resend SMS in ${seconds.value}s",
                          style: TextStyle(
                            color: seconds.value == 0 ? Colors.green : Colors.white38,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                     Spacer(flex: 2,),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked.value,
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          onChanged: (val) => isChecked.value = val ?? false,
                        ),
                        Text("Get updates on Whatsapp", style: TextStyle(color: Colors.white70, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0DC365),
                          disabledBackgroundColor: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                        ),
                        onPressed: isOtpComplete.value
                            ? () => ref.read(authControllerProvider.notifier).verifyOtp(phone, getOtp())
                            : null,
                        child: authState.isLoading
                            ? const CircularProgressIndicator(color: Colors.black)
                            : Text("Submit", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                      ),
                    ),
                    SizedBox(height: 60.h),
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