import 'package:flutter/material.dart';

// STEP 21-23: Settings Menu
// Accessible via settings icon
// Shows multiple menu items (Profile, Notifications, Appearance)
// Links correctly to other screens
class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STEP 21: Menu accessible via icon (already shown in Home screen AppBar)
      appBar: AppBar(
        title: const Text("Settings Menu"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // STEP 22: Menu shows multiple items
          
          // Profile option
          Card(
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("View and edit your profile"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Show a simple profile dialog (dummy implementation)
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Profile'),
                    content: const Text('Profile screen coming soon!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          
          // Notifications option
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.orange),
              title: const Text(
                "Notifications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("Configure notification settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // STEP 23: Navigate to Notification screen
                Navigator.pushNamed(context, '/notifications');
              },
            ),
          ),
          const SizedBox(height: 8),
          
          // Appearance/Settings option
          Card(
            child: ListTile(
              leading: const Icon(Icons.palette, color: Colors.purple),
              title: const Text(
                "Appearance",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("Theme and display settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // STEP 26: Navigate to Settings screen
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ),
          const SizedBox(height: 8),
          
          // Additional menu items for completeness
          Card(
            child: ListTile(
              leading: const Icon(Icons.security, color: Colors.red),
              title: const Text(
                "Privacy & Security",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("Manage your privacy settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Privacy & Security'),
                    content: const Text('Privacy settings coming soon!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          
          Card(
            child: ListTile(
              leading: const Icon(Icons.help, color: Colors.green),
              title: const Text(
                "Help & Support",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("Get help and support"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Help & Support'),
                    content: const Text('Help center coming soon!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          
          // Back to Home button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
