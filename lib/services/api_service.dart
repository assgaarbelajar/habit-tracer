import 'dart:convert';
import 'package:http/http.dart' as http;

// API Service for Habit Tracker App
// Uses GitHub API to fetch user activity data as habit tracking metrics
class ApiService {
  // GitHub Personal Access Token
  static const String _githubToken = '';
  static const String _baseUrl = 'https://api.github.com';
  
  // Headers for GitHub API authentication
  Map<String, String> get _headers => {
    'Authorization': 'Bearer $_githubToken',
    'Accept': 'application/vnd.github.v3+json',
  };

  // Fetch user's GitHub repositories (treated as habits/projects)
  Future<List<dynamic>> fetchData() async {
    try {
      // Fetch authenticated user's repositories
      final response = await http.get(
        Uri.parse('$_baseUrl/user/repos?sort=updated&per_page=10'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final repos = json.decode(response.body) as List;
        // Transform repo data into habit-friendly format
        return repos.map((repo) => {
          'id': repo['id'],
          'title': repo['name'] ?? 'Unnamed Habit',
          'body': repo['description'] ?? 'No description available',
          'language': repo['language'] ?? 'N/A',
          'stars': repo['stargazers_count'] ?? 0,
          'updated': repo['updated_at'] ?? '',
          'url': repo['html_url'] ?? '',
          'isPrivate': repo['private'] ?? false,
        }).toList();
      } else {
        // Fallback to demo data if GitHub API fails
        return _getDemoHabits();
      }
    } catch (e) {
      print('Error fetching GitHub data: $e');
      // Return demo habits if API call fails
      return _getDemoHabits();
    }
  }

  // Fetch user profile information
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final user = json.decode(response.body);
        return {
          'username': user['login'] ?? 'User',
          'name': user['name'] ?? 'GitHub User',
          'avatar': user['avatar_url'] ?? '',
          'bio': user['bio'] ?? 'Habit Tracker User',
          'public_repos': user['public_repos'] ?? 0,
          'followers': user['followers'] ?? 0,
        };
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }

  // Fetch recent commits (habit activity tracking)
  Future<List<dynamic>> fetchRecentActivity() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user/events?per_page=10'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body) as List;
      }
    } catch (e) {
      print('Error fetching activity: $e');
    }
    return [];
  }

  // Demo habits data as fallback
  List<Map<String, dynamic>> _getDemoHabits() {
    return [
      {
        'id': 1,
        'title': 'Morning Exercise',
        'body': 'Complete 30 minutes of exercise every morning',
        'language': 'Health',
        'stars': 15,
        'updated': DateTime.now().toIso8601String(),
        'url': '',
        'isPrivate': false,
      },
      {
        'id': 2,
        'title': 'Read for 20 Minutes',
        'body': 'Read books or articles to expand knowledge',
        'language': 'Learning',
        'stars': 22,
        'updated': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'url': '',
        'isPrivate': false,
      },
      {
        'id': 3,
        'title': 'Drink 8 Glasses of Water',
        'body': 'Stay hydrated throughout the day',
        'language': 'Health',
        'stars': 18,
        'updated': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'url': '',
        'isPrivate': false,
      },
      {
        'id': 4,
        'title': 'Meditation Practice',
        'body': '10 minutes of mindfulness meditation daily',
        'language': 'Wellness',
        'stars': 12,
        'updated': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
        'url': '',
        'isPrivate': false,
      },
      {
        'id': 5,
        'title': 'Code Daily',
        'body': 'Practice coding skills for at least 1 hour',
        'language': 'Programming',
        'stars': 30,
        'updated': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
        'url': '',
        'isPrivate': false,
      },
    ];
  }
}
