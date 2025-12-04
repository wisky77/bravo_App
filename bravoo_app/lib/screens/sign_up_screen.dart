import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/social_button.dart';
import 'enter_email.dart';
import 'login_screen.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF3D9F8), Color(0xFFE3F0FF)],
              ),
            ),
          ),
          // Decorative circles
          Positioned.fill(
            child: Opacity(
              opacity: 0.35,
              child: CustomPaint(
                painter: _CirclesPainter(),
              ),
            ),
          ),

          // Bottom sheet content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: size.height * 0.65,
                maxHeight: size.height * 0.95,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -6),
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 60,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const Text(
                      'Continue to sign up',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Let's get you started.",
                      style: TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(height: 18),

                    // Email field
                    _buildInputField(
                      controller: _emailController,
                      hint: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 12),

                    // Password field
                    _buildInputField(
                      controller: _passwordController,
                      hint: 'Password',
                      obscure: _obscure,
                      suffix: IconButton(
                        splashRadius: 20,
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Continue button
                    Center(
                      child: GestureDetector(
                        onTap: _isLoading ? null : _onContinue,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              colors: [Colors.black87, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _isLoading ? 'Please wait...' : 'Continue',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // OR divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('or', style: TextStyle(color: Colors.black54)),
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Social buttons (restored)
                    SocialButton(
                      text: 'Continue with Google',
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.redAccent, size: 22),
                      onPressed: () {
                        // TODO: Hook up Google auth if needed
                      },
                    ),
                    const SizedBox(height: 12),
                    SocialButton(
                      text: 'Continue with Apple',
                      icon: const FaIcon(FontAwesomeIcons.apple, color: Colors.black, size: 22),
                      onPressed: () {
                        // TODO: Hook up Apple auth if needed
                      },
                    ),

                    const SizedBox(height: 18),

                    // Already have account (restored)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 8),

                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: const [
                          Text('By continuing you agree to the '),
                          Text(
                            'Rules and Policy',
                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Future<void> _onContinue() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await AuthService().signUpWithPassword(email, password);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EnterEmailScreen()),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up failed. Please try again.')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

class _CirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final r = 36.0;
    for (double y = r; y < size.height; y += r * 3) {
      for (double x = r; x < size.width; x += r * 3) {
        paint.color = Colors.pink.withOpacity(0.12);
        canvas.drawCircle(Offset(x, y), r * 0.9, paint);
        paint.color = Colors.purple.withOpacity(0.06);
        canvas.drawCircle(Offset(x + r * 0.3, y + r * 0.3), r * 0.7, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
