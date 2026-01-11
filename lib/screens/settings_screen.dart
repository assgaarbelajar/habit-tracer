import 'package:flutter/material.dart';

// STEP 24-26: Settings Screen
// Has dark mode toggle (dummy logic acceptable)
// Settings screen UI visible
// Settings menu links correctly
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // STEP 24: Dark mode toggle state (dummy implementation)
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  double fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STEP 25: Settings screen UI visible
      appBar: AppBar(
        title: const Text("Appearance Settings"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // STEP 24: Dark mode toggle clearly visible
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text("Toggle dark theme"),
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: isDarkMode ? Colors.purple : Colors.orange,
                  ),
                  value: isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      isDarkMode = val;
                    });
                    // Show feedback to user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isDarkMode
                              ? 'Dark mode enabled (Demo)'
                              : 'Dark mode disabled (Demo)',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Additional settings for better UI
          Card(
            child: SwitchListTile(
              title: const Text(
                "Push Notifications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("Enable push notifications"),
              secondary: const Icon(Icons.notifications, color: Colors.blue),
              value: notificationsEnabled,
              onChanged: (val) {
                setState(() {
                  notificationsEnabled = val;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      notificationsEnabled
                          ? 'Notifications enabled'
                          : 'Notifications disabled',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Font size slider
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.text_fields, color: Colors.green),
                      const SizedBox(width: 12),
                      const Text(
                        'Font Size',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${fontSize.round()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: fontSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    label: fontSize.round().toString(),
                    onChanged: (val) {
                      setState(() {
                        fontSize = val;
                      });
                    },
                  ),
                  Text(
                    'Preview text at selected size',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Information card
          Card(
            color: Colors.blue.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 12),
                      Text(
                        'About Settings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'These settings control the appearance and behavior of the app. Changes are applied immediately for demonstration purposes.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Back button
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Menu'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
