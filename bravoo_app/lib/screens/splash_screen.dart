import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;
  Color _bgColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _enterImmersive();

    // Extract a dominant color from the splash.jpg to use as background.
    _extractDominantColor().then((_) {
      // Start the timer after the first frame so the delay is fully visible.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 10), _goNext);
      });
    });
  }

  Future<void> _enterImmersive() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  Future<void> _extractDominantColor() async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        const AssetImage('assets/design/splash.jpg'),
        size: const Size(200, 200),
        maximumColorCount: 12,
      );
      final c = palette.dominantColor?.color ?? palette.vibrantColor?.color;
      if (c != null && mounted) {
        setState(() => _bgColor = c);
      }
    } catch (_) {
      // Ignore errors; keep default white background
    }
  }

  void _goNext() {
    if (_navigated || !mounted) return;
    _navigated = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: const Center(
        child: _CenteredLogo(),
      ),
    );
  }
}

class _CenteredLogo extends StatelessWidget {
  const _CenteredLogo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/design/logo.jpg',
      width: 160,
      height: 160,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
