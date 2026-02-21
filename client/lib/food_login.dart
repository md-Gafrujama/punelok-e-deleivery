import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'otp.dart';

// ─── Typewriter ───────────────────────────────────────────────────────────────
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Duration speed;
  final Duration startDelay;
  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.center,
    this.speed = const Duration(milliseconds: 80),
    this.startDelay = Duration.zero,
  });
  @override
  State<TypewriterText> createState() => _TWState();
}

class _TWState extends State<TypewriterText> {
  String _shown = '';
  int _i = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.startDelay, _tick);
  }

  void _tick() {
    if (!mounted) return;
    if (_i < widget.text.length) {
      setState(() => _shown += widget.text[_i++]);
      Future.delayed(widget.speed, _tick);
    }
  }

  @override
  Widget build(BuildContext context) =>
      Text(_shown, style: widget.style, textAlign: widget.textAlign);
}

// ─── Login Page ───────────────────────────────────────────────────────────────
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();

  bool _isLoading = false;
  String _selectedCode = '+91';

  static const _yellow = Color(0xFFFFC107);
  static const _deepYellow = Color(0xFFE6A800);
  static const _textDark = Color(0xFF1A1A1A);

  late AnimationController _floatCtrl;
  late AnimationController _bgPulseCtrl;
  late AnimationController _cardCtrl;
  late AnimationController _staggerCtrl;

  late Animation<double> _float;
  late Animation<double> _bgPulse;
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardFade;

  // Stagger
  late Animation<double> _subFade;
  late Animation<double> _phoneFade;
  late Animation<Offset> _phoneSlide;
  late Animation<double> _btnFade;
  late Animation<Offset> _btnSlide;
  late Animation<double> _divFade;
  late Animation<double> _socialFade;

  final List<String> _codes = ['+91', '+1', '+44', '+61', '+971', '+65', '+81'];

  @override
  void initState() {
    super.initState();

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _float = CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut);

    _bgPulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _bgPulse = CurvedAnimation(parent: _bgPulseCtrl, curve: Curves.easeInOut);

    _cardCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic));
    _cardFade = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeIn);

    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _subFade = _iv(0.00, 0.35);
    _phoneFade = _iv(0.20, 0.55);
    _phoneSlide = _sl(0.20, 0.55);
    _btnFade = _iv(0.40, 0.72);
    _btnSlide = _sl(0.40, 0.72);
    _divFade = _iv(0.60, 0.82);
    _socialFade = _iv(0.72, 1.00);

    _cardCtrl.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _staggerCtrl.forward();
    });
  }

  Animation<double> _iv(double a, double b) =>
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _staggerCtrl,
          curve: Interval(a, b, curve: Curves.easeOut),
        ),
      );
  Animation<Offset> _sl(double a, double b) =>
      Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _staggerCtrl,
          curve: Interval(a, b, curve: Curves.easeOutCubic),
        ),
      );

  @override
  void dispose() {
    _floatCtrl.dispose();
    _bgPulseCtrl.dispose();
    _cardCtrl.dispose();
    _staggerCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => FadeTransition(
          opacity: anim,
          child: OtpPage(phoneNumber: '$_selectedCode ${_phoneCtrl.text}'),
        ),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bgH = size.height * 0.52;

    return Scaffold(
      backgroundColor: _yellow,
      body: Stack(
        children: [
          // ── Animated yellow background ────────────────────────────────────
          AnimatedBuilder(
            animation: _bgPulse,
            builder: (_, __) => Container(
              width: size.width,
              height: bgH + 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(
                      const Color(0xFFFFD740),
                      const Color(0xFFFFB300),
                      _bgPulse.value,
                    )!,
                    Color.lerp(
                      const Color(0xFFFFB300),
                      const Color(0xFFFF8F00),
                      _bgPulse.value,
                    )!,
                  ],
                ),
              ),
            ),
          ),

          // ── Animated burger background image ──────────────────────────────────
          AnimatedBuilder(
            animation: _float,
            builder: (_, __) {
              final f = _float.value;
              final bounce = sin(f * pi) * 10;
              final tilt = sin(_floatCtrl.value * pi * 2) * 0.02;

              return SizedBox(
                width: size.width,
                height: bgH,
                child: ClipRect(
                  child: Transform.translate(
                    offset: Offset(0, -bounce * 0.5),
                    child: Transform.rotate(
                      angle: tilt,
                      child: Transform.scale(
                        scale: 1.25, // 🔥 important
                        child: Image.asset(
                          'assets/burger.jpeg',
                          fit: BoxFit.cover,
                          width: size.width * 1.2, // 🔥 wider
                          height: bgH * 1.3, // 🔥 taller
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // ── Typewriter welcome on top of bg ───────────────────────────────
          Positioned(
            top: 52,
            left: 0,
            right: 0,
            child: Column(
              children: [
                TypewriterText(
                  text: "Order Food 🍔",
                  startDelay: const Duration(milliseconds: 300),
                  speed: const Duration(milliseconds: 90),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.4,
                    shadows: [
                      Shadow(
                        color: Color(0x55000000),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                TypewriterText(
                  text: "Delivered fast to your door",
                  startDelay: const Duration(milliseconds: 1400),
                  speed: const Duration(milliseconds: 55),
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.88),
                    letterSpacing: 0.2,
                    shadows: const [
                      Shadow(color: Color(0x44000000), blurRadius: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Sliding white card from bottom ────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
              opacity: _cardFade,
              child: SlideTransition(
                position: _cardSlide,
                child: _buildCard(size),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Size size) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height * 0.58),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x35000000),
            blurRadius: 36,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 48),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Drag handle
              Container(
                width: 42,
                height: 4,
                margin: const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              // Subtitle
              FadeTransition(
                opacity: _subFade,
                child: Text(
                  "Let's start with your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Phone row ───────────────────────────────────────────
              FadeTransition(
                opacity: _phoneFade,
                child: SlideTransition(
                  position: _phoneSlide,
                  child: Row(
                    children: [
                      // Country code
                      Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFFFAFAFA),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCode,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _textDark,
                            ),
                            items: _codes
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(c),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedCode = v!),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(
                            fontSize: 15,
                            color: _textDark,
                          ),
                          decoration: _dec(
                            "Enter phone number",
                            Icons.phone_outlined,
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "Enter phone number";
                            if (v.length < 7) return "Invalid number";
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Send OTP button ─────────────────────────────────────
              FadeTransition(
                opacity: _btnFade,
                child: SlideTransition(
                  position: _btnSlide,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _yellow,
                        elevation: 4,
                        shadowColor: _deepYellow.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isLoading ? null : _sendOtp,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Send OTP",
                                key: ValueKey("otp"),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // ── or with ────────────────────────────────────────────
              FadeTransition(
                opacity: _divFade,
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "or with",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ── Google ──────────────────────────────────────────────
              FadeTransition(
                opacity: _socialFade,
                child: _socialBtn(
                  "Continue with Google",
                  FontAwesomeIcons.google,
                  const Color(0xFF4285F4),
                ),
              ),

              const SizedBox(height: 12),

              // ── Apple ───────────────────────────────────────────────
              FadeTransition(
                opacity: _socialFade,
                child: _socialBtn("Apple", Icons.apple_rounded, _textDark),
              ),

              const SizedBox(height: 24),

              // ── Terms ───────────────────────────────────────────────
              FadeTransition(
                opacity: _socialFade,
                child: Text.rich(
                  TextSpan(
                    text: "By continuing, you automatically agree to our ",
                    style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                    children: [
                      TextSpan(
                        text: "Terms & Privacy Policy",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _yellow, width: 2.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      );

  Widget _socialBtn(String label, IconData icon, Color iconColor) {
    final isGoogle = label.contains('Google');
    final baseColor = isGoogle ? const Color(0xFF4285F4) : iconColor;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          side: BorderSide(
            color: isGoogle ? baseColor.withOpacity(0.7) : Colors.grey[300]!,
            width: isGoogle ? 1.6 : 1.2,
          ),
          backgroundColor: isGoogle ? Colors.white : const Color(0xFFFDFDFD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          shadowColor: baseColor.withOpacity(isGoogle ? 0.35 : 0.2),
          elevation: isGoogle ? 3 : 1,
        ),
        icon: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: isGoogle
                ? [
                    BoxShadow(
                      color: baseColor.withOpacity(0.25),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 18,
            color: baseColor,
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: _textDark,
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
