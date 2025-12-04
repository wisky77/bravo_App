import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Decorative header with coins
            _buildHeader(),

            // Main content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 120,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 48),
                          decoration: BoxDecoration(
                            color: AppColors.inputBorder,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Title
                      const Text(
                        'Enter your email',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Enter your email and we will send you a code',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email field
                      CustomTextField(
                        hintText: 'Enter your email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 24),

                      // Send code button
                      PrimaryButton(
                        text: 'Send code',
                        onPressed: _handleSendCode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // FlowCoins badges
          Positioned(
            left: -20,
            top: 30,
            child: _buildFlowCoinBadge(),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 60,
            top: 20,
            child: _buildFlowCoinBadge(),
          ),
          Positioned(
            right: -20,
            top: 30,
            child: _buildFlowCoinBadge(),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowCoinBadge() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.pink.shade100,
            Colors.purple.shade100,
          ],
          stops: const [0.3, 1.0],
        ),
        border: Border.all(
          color: Colors.purple.shade300,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Inner white highlight circle
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '50',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.pink.shade300,
                  ),
                ),
                Text(
                  'FlowCoins',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple.shade300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSendCode() {
    // TODO: Implement send code logic
    print('Sending code to: ${_emailController.text}');
    // Navigate to verification screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const VerificationScreen()),
    // );
  }
}
