import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_button.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Decorative header with blurred circles
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
                          margin: const EdgeInsets.only(bottom: 32),
                          decoration: BoxDecoration(
                            color: AppColors.inputBorder,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Title
                      const Text(
                        'Continue to log in',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        "Let's get you started.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email field
                      CustomTextField(
                        hintText: 'Email address',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      CustomTextField(
                        hintText: 'Password',
                        isPassword: !_isPasswordVisible,
                        controller: _passwordController,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Continue button
                      PrimaryButton(
                        text: 'Continue',
                        onPressed: _handleLogin,
                      ),
                      const SizedBox(height: 16),

                      // Forgot password link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // OR divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.inputBorder,
                              thickness: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.inputBorder,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Google sign in
                      SocialButton(
                        text: 'Continue with Google',
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          height: 24,
                          width: 24,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.g_mobiledata,
                              size: 32,
                              color: Colors.red,
                            );
                          },
                        ),
                        onPressed: () {
                          // TODO: Handle Google sign in
                        },
                      ),
                      const SizedBox(height: 16),

                      // Apple sign in
                      SocialButton(
                        text: 'Continue with Apple',
                        icon: const Icon(
                          Icons.apple,
                          size: 24,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // TODO: Handle Apple sign in
                        },
                      ),
                      const SizedBox(height: 32),

                      // Sign up link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to sign up
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: AppColors.primaryPurple,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Terms and policy
                      const Center(
                        child: Text(
                          'By continuing you agree to the Rules and Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
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
          // Blurred gradient circles
          Positioned(
            left: -50,
            top: -20,
            child: _buildBlurredCircle(150),
          ),
          Positioned(
            left: 100,
            top: -40,
            child: _buildBlurredCircle(180),
          ),
          Positioned(
            right: -30,
            top: -30,
            child: _buildBlurredCircle(160),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primaryPurple.withOpacity(0.6),
            Colors.pink.withOpacity(0.4),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  void _handleLogin() {
    // TODO: Implement login logic
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
  }
}
