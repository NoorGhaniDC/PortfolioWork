import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D47A1); 
  static const Color accent = Color(0xFF00E5FF); 
  static const Color background = Color(0xFFF4F6F8); 
  
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF102027);
  static const Color textSecondary = Color(0xFF78909C);
  
  // A gradient we can reuse
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}