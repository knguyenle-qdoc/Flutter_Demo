import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/views/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App bootstrap.
///
/// React analogy:
/// - `main()` is like your startup file where you prepare config/env.
/// - `runApp(...)` is similar to `createRoot(...).render(<App />)`.
Future<void> main() async {
  // Loads API values before widgets/providers try to read them.
  await dotenv.load(fileName: 'lib/core/env/.env');

  // Riverpod dependency container for the entire widget tree.
  runApp(ProviderScope(child: const MyApp()));
}

/// Root widget for the app.
///
/// React analogy:
/// - Similar to the top-level `App` component that returns your router/screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // For now the app shows one screen directly.
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
