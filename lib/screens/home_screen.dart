import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

// STEP 11-12: Home Screen
// Contains app header with logo/icon
// Shows navigation options
// STEP 19-20: Displays API data
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final LocalStorageService storage = LocalStorageService();
  List<dynamic> apiData = [];
  bool isLoading = true;
  String? savedUsername;
  String? savedEmail;

  @override
  void initState() {
    super.initState();
    // Load saved data from local storage (STEP 16-18)
    loadSavedData();
    // Fetch data from API (STEP 19-20)
    fetchApiData();
  }

  // STEP 16-18: Retrieve data from SharedPreferences
  Future<void> loadSavedData() async {
    savedUsername = await storage.getData('username');
    savedEmail = await storage.getData('email');
    setState(() {});
  }

  // STEP 19-20: Fetch data from public API
  Future<void> fetchApiData() async {
    try {
      final data = await apiService.fetchData();
      setState(() {
        // Display first 5 posts for clarity
        apiData = data.take(5).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching API data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STEP 11-12: App header with logo/icon
      appBar: AppBar(
        title: const Text("Habit Tracker Home"),
        // App logo/icon (STEP 12)
        leading: const Icon(
          Icons.favorite,
          size: 28,
        ),
        backgroundColor: Colors.blue,
        actions: [
          // Navigation option: Settings menu (STEP 12 & 21-23)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to Settings Menu
              Navigator.pushNamed(context, '/settings-menu');
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // STEP 16-18: Display saved user data from local storage
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Saved User Data (Local Storage):',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Username: ${savedUsername ?? "Not saved"}'),
                          Text('Email: ${savedEmail ?? "Not saved"}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // STEP 19-20: API Data Section
                  const Text(
                    'API Data (From JSONPlaceholder):',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Display fetched API data clearly
                  ...apiData.map((post) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: ListTile(
                        // STEP 13-15: Navigation icon to Detail screen
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${post['id']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          post['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          post['body'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Navigation option visible (STEP 14)
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          // Navigate to Detail screen with post data
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: post,
                          );
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
      // Bottom navigation bar for additional navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/notifications');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings-menu');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
