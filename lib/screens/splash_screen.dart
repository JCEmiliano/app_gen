import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generator_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const SplashScreen({super.key, required this.onToggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GeneratorScreen(onToggleTheme: widget.onToggleTheme),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceContainerHighest = isDark ? const Color(0xFF1d2539) : const Color(0xFFe2e8f0);

    return Scaffold(
      body: Stack(
        children: [
          // Background ambient lights
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: primary.withOpacity(0.1), blurRadius: 100, spreadRadius: 50)
                ]
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: secondary.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: secondary.withOpacity(0.1), blurRadius: 100, spreadRadius: 50)
                ]
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Outer Ring
                      Transform.rotate(
                        angle: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: surfaceContainerHighest.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 20))
                            ]
                          ),
                        ),
                      ),
                      // Inner Brand Mark
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primary, primary.withOpacity(0.7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: primary.withOpacity(0.3), blurRadius: 40)
                          ]
                        ),
                        child: SvgPicture.asset(
                          'assets/JC.svg',
                          width: 45,
                          height: 45,
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                          fit: BoxFit.contain,
                        ),
                      ),
                      // Secondary Accent
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: secondary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 4),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)]
                          ),
                          child: Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.onSecondary, size: 20),
                        )
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                // Tags
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.epilogue(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: -1.0,
                    ),
                    children: [
                      const TextSpan(text: 'Fs'),
                      TextSpan(text: 'Gen', style: TextStyle(color: primary)),
                    ]
                  )
                ),
                const SizedBox(height: 8),
                Text(
                  'Generador de plantillas fs',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                  ),
                ),
                const SizedBox(height: 64),
                // Progress indicator (Simulated continuous)
                Container(
                  width: 180,
                  height: 4,
                  decoration: BoxDecoration(
                    color: surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      color: primary,
                      backgroundColor: Colors.transparent,
                    ),
                  )
                ),
                const SizedBox(height: 48),
                Text(
                  'BY JC EMILIANO V.1.0',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
