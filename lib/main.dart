import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/settings_menu.dart';
import 'screens/settings_screen.dart';
import 'screens/notification_screen.dart';

// Entry point of the Habit Tracker application
void main() {
  // Set preferred orientations and system UI
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF5F7FA),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        // Modern pastel color scheme for habit tracking
        primaryColor: const Color(0xFF9B8FFF), // Soft purple
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Light gray-blue
        
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF9B8FFF), // Purple - Focus/Achievement
          secondary: const Color(0xFFFFB4D6), // Pink - Love/Passion
          tertiary: const Color(0xFF94E8D0), // Mint - Growth/Success
          error: const Color(0xFFFF6B6B), // Coral red - Alerts
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF2D3142),
        ),
        
        // Card theme with 3D effect
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: const Color(0x1A000000),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        
        // AppBar theme - transparent with custom styling
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF2D3142),
          titleTextStyle: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF9B8FFF),
            size: 24,
          ),
        ),
        
        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF9B8FFF),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        // Input decoration theme for text fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF9B8FFF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          labelStyle: const TextStyle(
            color: Color(0xFF9599A8),
            fontSize: 14,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 14,
          ),
        ),
        
        // Icon theme
        iconTheme: const IconThemeData(
          color: Color(0xFF9B8FFF),
          size: 24,
        ),
        
        // Floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF9B8FFF),
          foregroundColor: Colors.white,
          elevation: 8,
        ),
        
        // Bottom navigation bar theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF9B8FFF),
          unselectedItemColor: Color(0xFF9599A8),
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
        ),
        
        // Divider theme
        dividerTheme: const DividerThemeData(
          color: Color(0xFFE8E8E8),
          thickness: 1,
          space: 1,
        ),
        
        // Snackbar theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF2D3142),
          contentTextStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 6,
        ),
        
        // Font family
        fontFamily: 'System',
        
        // Text theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
            letterSpacing: -0.5,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF2D3142),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF9599A8),
          ),
        ),
        
        useMaterial3: true,
      ),
      
      // Start with Signup screen as the initial route
      home: const SignupScreen(),
      
      // Define named routes for easy navigation
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(),
        '/settings-menu': (context) => const SettingsMenu(),
        '/settings': (context) => const SettingsScreen(),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }
}
