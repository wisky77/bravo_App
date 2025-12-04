import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up Mock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // fake blurred background using an image-ish gradient for demo
      body: Stack(
        children: [
          // background circles / blurred wallpaper imitation
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF3D9F8), Color(0xFFE3F0FF)],
              ),
            ),
          ),
          // translucent repeated circles to mimic the mock image
          Positioned.fill(
            child: Opacity(
              opacity: 0.35,
              child: CustomPaint(
                painter: _CirclesPainter(),
              ),
            ),
          ),

          // main bottom sheet
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
                    // drag handle
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

                    // email field
                    _buildInputField(
                      controller: _emailController,
                      hint: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 12),

                    // password field
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

                    // Continue button - glossy rounded pill style
                    Center(
                      child: GestureDetector(
                        onTap: () => _onContinue(),
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                              // subtle inner shine using a white translucent gradient overlay
                            ],
                          ),
                          child: Stack(
                            children: [
                              // top-left soft highlight
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.08,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      gradient: LinearGradient(
                                        colors: [Colors.white, Colors.transparent],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

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

                    // Social buttons
                    _socialButton(
                      label: 'Continue with Google',
                      leading: _googleIcon(),
                      highlight: true,
                    ),

                    const SizedBox(height: 12),

                    _socialButton(
                      label: 'Continue with Apple',
                      leading: const Icon(Icons.apple, size: 20),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? '),
                        GestureDetector(
                          onTap: () {},
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
                        children: [
                          const Text('By continuing you agree to the '),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Rules and Policy',
                              style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                            ),
                          )
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

  Widget _socialButton({required String label, Widget? leading, bool highlight = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: highlight ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            if (leading != null) ...[
              leading,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleIcon() {
    // simplified google logo (rounded G)
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: 6,
              top: 4,
              child: Container(width: 6, height: 6, color: Colors.blue),
            ),
            Positioned(
              left: 12,
              top: 4,
              child: Container(width: 6, height: 6, color: Colors.red),
            ),
            Positioned(
              left: 9,
              top: 12,
              child: Container(width: 6, height: 6, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinue() {
    // placeholder - in a real app you'd validate and submit
    final email = _emailController.text;
    final pass = _passwordController.text;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tried to continue with $email — password length ${pass.length}'),
    ));
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
