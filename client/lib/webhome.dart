import 'package:blinkit/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebHome extends StatefulWidget {
  const WebHome({super.key});

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final ScrollController _scrollController = ScrollController();
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

  void _openLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _WebLoginDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth > 1400 ? 1300 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      /// 🔥 Sticky Navbar using CustomScrollView
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// ================= STICKY NAVBAR =================
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            toolbarHeight: 86,
            elevation: 0,
            titleSpacing: 0,
            shadowColor: Colors.black12,
            forceElevated: true,
            title: _navbar(contentWidth),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey.withOpacity(0.15),
                height: 1.0,
              ),
            ),
          ),

          /// ================= BODY =================
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    /// HERO
                    _heroBanner(),

                    const SizedBox(height: 40),

                    /// PROMO ROW
                    Row(
                      children: [
                        Expanded(child: _hoverCard("assets/promo1.png")),
                        const SizedBox(width: 20),
                        Expanded(child: _hoverCard("assets/promo2.png")),
                        const SizedBox(width: 20),
                        Expanded(child: _hoverCard("assets/promo3.png")),
                      ],
                    ),

                    const SizedBox(height: 50),

                    /// CATEGORY SECTION HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Dairy, Bread & Eggs",
                          style: TextStyle(
                            fontSize: 26,
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
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text("see all"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    /// CATEGORIES WRAP (GRID)
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        spacing: 28,
                        runSpacing: 36,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          categories.length,
                          (index) => _hoverProductCard(index),
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= NAVBAR =================
  Widget _navbar(double contentWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Center(
      child: Container(
        width: contentWidth,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "blinkit",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Color(0xfff6c800),
                          letterSpacing: -0.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: _openLoginDialog,
                        child: const Text("Login", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const BlinkitWebSearchField(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "blinkit",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Color(0xfff6c800),
                      letterSpacing: -1.0,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 48),
                  
                  // Location Address Block
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Delivery in 12 minutes",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                "Pune Railway Station, Pune",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[600], size: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 40),
                  const Expanded(child: BlinkitWebSearchField()),
                  const SizedBox(width: 40),
                  
                  TextButton(
                    onPressed: _openLoginDialog,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(width: 24),
                  
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C831F), // blinkit green
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.shopping_cart_outlined, size: 20),
                    label: const Text(
                      "My Cart",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  // Widget _navbar(double contentWidth) {
  //   return Center(
  //     child: SizedBox(
  //       width: contentWidth,
  //       child: Row(
  //         children: [
  //           const Text(
  //             "blinkit",
  //             style: TextStyle(
  //               fontSize: 28,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xfff6c800),
  //             ),
  //           ),

  //           const SizedBox(width: 40),

  //           const Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text("Delivery in 12 minutes",
  //                   style: TextStyle(fontWeight: FontWeight.bold)),
  //               Text("Pune Railway Station, Pune",
  //                   style: TextStyle(fontSize: 13)),
  //             ],
  //           ),

  //           const Spacer(),

  //           /// 🔥 Animated Search
  //           const BlinkitWebSearchField(),

  //           const Spacer(),

  //           GestureDetector(
  //             onTap: _openLoginDialog,
  //             child: const Text("Login",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
  //           ),

  //           const SizedBox(width: 20),

  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             decoration: BoxDecoration(
  //               color: Colors.grey.shade400,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Row(
  //               children: [
  //                 Icon(Icons.shopping_cart_outlined),
  //                 const SizedBox(width: 5,),
  //                 const Text("My Cart"),

  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// ================= HERO =================
  Widget _heroBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        "assets/banner_img.png",
        height: 280,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  /// ================= HOVER PROMO CARD =================
  Widget _hoverCard(String image) {
    return _HoverScale(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            image,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// ================= PRODUCT CATEGORY CARD =================
  Widget _hoverProductCard(int index) {
    return _HoverScale(
      child: SizedBox(
        width: 110, // Fixed width for clear grid alignment
        child: Column(
          children: [
            Container(
              width: 110,
              height: 120,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FB), // Light blue modern background
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: 'category_$index',
                child: Image.asset(
                  categories[index]["image"]!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              categories[index]["title"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
                height: 1.25,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoverScale extends StatefulWidget {
  final Widget child;
  const _HoverScale({required this.child});

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform:
            isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }
}

class _WebLoginDialog extends StatefulWidget {
  const _WebLoginDialog();

  @override
  State<_WebLoginDialog> createState() => _WebLoginDialogState();
}

class _WebLoginDialogState extends State<_WebLoginDialog>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  bool _isSendingOtp = false;
  bool _isVerifying = false;
  bool _showOtpStep = false;
  bool _showSuccess = false;
  String _errorText = '';
  String _phoneNumber = ''; // Store phone number to display in OTP step

  static const _yellow = Color(0xFFFFC107);

  late AnimationController _entryController;
  late AnimationController _successController;
  late Animation<double> _entryScale;
  late Animation<double> _entryFade;
  late Animation<double> _successScale;
  late Animation<double> _successFade;
  late Animation<double> _successRotation;

  @override
  void initState() {
    super.initState();

    // Entry animation controller
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _entryScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Curves.easeOutCubic,
      ),
    );
    _entryFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Curves.easeOut,
      ),
    );

    // Success animation controller
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _successScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: Curves.elasticOut,
      ),
    );
    _successFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: Curves.easeIn,
      ),
    );
    _successRotation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start entry animation
    _entryController.forward();

    // Auto-focus first OTP field when OTP step is shown
    if (_showOtpStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _otpFocusNodes[0].requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _successController.dispose();
    _phoneController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  bool _isValidPhoneNumber(String phone) {
    // Remove any spaces or special characters
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    // Check if it's exactly 10 digits (Indian mobile number format)
    if (cleaned.length != 10) {
      return false;
    }
    // Check if it starts with 6, 7, 8, or 9 (valid Indian mobile number prefixes)
    final firstDigit = cleaned[0];
    return firstDigit == '6' ||
        firstDigit == '7' ||
        firstDigit == '8' ||
        firstDigit == '9';
  }

  Future<void> _sendOtp() async {
    setState(() {
      _errorText = '';
    });
    final phone = _phoneController.text.trim();

    // Validate phone number
    if (phone.isEmpty) {
      setState(() {
        _errorText = 'Please enter your phone number';
      });
      return;
    }

    if (!_isValidPhoneNumber(phone)) {
      setState(() {
        _errorText = 'Please enter a valid 10-digit mobile number';
      });
      return;
    }

    // Store formatted phone number for display
    final cleanedPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    _phoneNumber = '+91 $cleanedPhone';

    setState(() => _isSendingOtp = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _isSendingOtp = false;
      _showOtpStep = true;
      _errorText = '';
    });
    // Focus first OTP field after switching to OTP step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNodes[0].requestFocus();
    });
  }

  Future<void> _verifyOtp() async {
    setState(() {
      _errorText = '';
    });
    final code = _otpControllers.map((c) => c.text).join();
    if (code.length < 4) {
      setState(() {
        _errorText = 'Enter the 4-digit OTP';
      });
      return;
    }
    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    // Show success state and trigger animation
    setState(() {
      _isVerifying = false;
      _showSuccess = true;
    });
    // Reset and start success animation
    _successController.reset();
    _successController.forward();
    // Close dialog after 2.5 seconds (after animation completes)
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Widget _buildSuccessView() {
    return AnimatedBuilder(
      animation: _successController,
      builder: (context, child) {
        return Column(
          key: const ValueKey('success'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Success icon with scale and rotation animation
            Transform.scale(
              scale: _successScale.value,
              child: Transform.rotate(
                angle: _successRotation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _yellow.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: _yellow,
                    size: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Success message with fade animation
            Opacity(
              opacity: _successFade.value,
              child: Column(
                children: [
                  const Text(
                    'Login Successful! 🎉',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome to blinkit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  Widget _buildLoginView() {
    return Column(
      key: const ValueKey('login'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Header with back button and close button
        Row(
          children: [
            if (_showOtpStep)
              IconButton(
                onPressed: () {
                  setState(() {
                    _showOtpStep = false;
                    _errorText = '';
                    _phoneNumber = '';
                    for (final c in _otpControllers) {
                      c.clear();
                    }
                  });
                },
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            else
              const SizedBox(width: 40),
            Expanded(
              child: Center(
                child: Text(
                  _showOtpStep ? 'Verify OTP' : 'Login',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Centered subtitle
        Center(
          child: Column(
            children: [
              Text(
                _showOtpStep
                    ? 'Enter the 4-digit OTP sent to your phone.'
                    : 'Enter your phone number to login.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              if (_showOtpStep && _phoneNumber.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  _phoneNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Content fields
        if (!_showOtpStep) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                const Text("+91", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Container(width: 1, height: 24, color: Colors.grey[300]),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter mobile number',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      errorText: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (i) => Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _otpControllers[i],
                  focusNode: _otpFocusNodes[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  maxLength: 1,
                  onChanged: (value) => _onOtpChanged(value, i),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
        if (_errorText.isNotEmpty) ...[
          const SizedBox(height: 8),
          Center(
            child: Text(
              _errorText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        // Button with consistent styling
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _yellow,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: _yellow.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: _showOtpStep
                ? (_isVerifying ? null : _verifyOtp)
                : (_isSendingOtp ? null : _sendOtp),
            child: (_showOtpStep ? _isVerifying : _isSendingOtp)
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    _showOtpStep ? 'Verify OTP' : 'Send OTP',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Center(
        child: AnimatedBuilder(
          animation: _entryController,
          builder: (context, child) {
            return Opacity(
              opacity: _entryFade.value,
              child: Transform.scale(
                scale: _entryScale.value,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Material(
                    color: Colors.white,
                    elevation: 12,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        transitionBuilder: (child, animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(animation);
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: _showSuccess
                            ? _buildSuccessView()
                            : _buildLoginView(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
