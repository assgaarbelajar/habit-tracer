import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Local Storage Service for Habit Tracker App
// Manages persistent storage for user data, habits, and preferences
class LocalStorageService {
  // Save string data
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Get string data
  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save boolean data (for toggles, checkboxes)
  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get boolean data
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  // Save integer data (for counts, streaks)
  Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  // Get integer data
  Future<int> getInt(String key, {int defaultValue = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? defaultValue;
  }

  // Save list of strings (for habit lists, tags)
  Future<void> saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  // Get list of strings
  Future<List<String>> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  // Save habit data as JSON
  Future<void> saveHabit(String habitId, Map<String, dynamic> habitData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(habitData);
    await prefs.setString('habit_$habitId', jsonString);
  }

  // Get habit data from JSON
  Future<Map<String, dynamic>?> getHabit(String habitId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('habit_$habitId');
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  // Save list of favorite habit IDs
  Future<void> saveFavoriteHabits(List<String> habitIds) async {
    await saveStringList('favorite_habits', habitIds);
  }

  // Get list of favorite habit IDs
  Future<List<String>> getFavoriteHabits() async {
    return await getStringList('favorite_habits');
  }

  // Add habit to favorites
  Future<void> addToFavorites(String habitId) async {
    final favorites = await getFavoriteHabits();
    if (!favorites.contains(habitId)) {
      favorites.add(habitId);
      await saveFavoriteHabits(favorites);
    }
  }

  // Remove habit from favorites
  Future<void> removeFromFavorites(String habitId) async {
    final favorites = await getFavoriteHabits();
    favorites.remove(habitId);
    await saveFavoriteHabits(favorites);
  }

  // Check if habit is favorited
  Future<bool> isFavorite(String habitId) async {
    final favorites = await getFavoriteHabits();
    return favorites.contains(habitId);
  }

  // Save habit completion date
  Future<void> markHabitComplete(String habitId, DateTime date) async {
    final key = 'habit_${habitId}_completions';
    final completions = await getStringList(key);
    final dateString = date.toIso8601String().split('T')[0]; // Date only
    if (!completions.contains(dateString)) {
      completions.add(dateString);
      await saveStringList(key, completions);
    }
  }

  // Get habit completion history
  Future<List<String>> getHabitCompletions(String habitId) async {
    final key = 'habit_${habitId}_completions';
    return await getStringList(key);
  }

  // Get habit streak (consecutive days)
  Future<int> getHabitStreak(String habitId) async {
    final completions = await getHabitCompletions(habitId);
    if (completions.isEmpty) return 0;
    
    completions.sort((a, b) => b.compareTo(a)); // Sort descending
    int streak = 0;
    DateTime checkDate = DateTime.now();
    
    for (var completion in completions) {
      final completionDate = DateTime.parse(completion);
      final difference = checkDate.difference(completionDate).inDays;
      
      if (difference == 0 || difference == 1) {
        streak++;
        checkDate = completionDate;
      } else {
        break;
      }
    }
    
    return streak;
  }

  // Save app theme preference
  Future<void> saveThemeMode(String mode) async {
    await saveData('theme_mode', mode);
  }

  // Get app theme preference
  Future<String> getThemeMode() async {
    return await getData('theme_mode') ?? 'light';
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Clear specific data
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Check if key exists
  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
