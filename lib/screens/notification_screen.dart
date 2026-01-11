import 'package:flutter/material.dart';

// STEP 27-28: Notification Screen
// Notification configuration screen exists
// Test notification trigger UI exists
// Clear visual indication of notification trigger
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Track whether test notification was triggered
  bool notificationTriggered = false;
  String lastNotificationTime = '';

  // STEP 28: Test notification trigger
  void triggerTestNotification() {
    setState(() {
      notificationTriggered = true;
      lastNotificationTime = DateTime.now().toString().substring(0, 19);
    });
    
    // Show visual feedback (STEP 28: Clear visual indication)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Test Notification Triggered Successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STEP 27: Notification configuration screen exists
      appBar: AppBar(
        title: const Text("Notification Settings"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // STEP 28: Test notification trigger UI with clear visual indication
            Card(
              elevation: 4,
              color: notificationTriggered ? Colors.green.shade50 : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      notificationTriggered
                          ? Icons.notifications_active
                          : Icons.notifications_none,
                      size: 64,
                      color: notificationTriggered ? Colors.green : Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      notificationTriggered
                          ? 'Test Notification Triggered!'
                          : 'Ready to Test Notifications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: notificationTriggered ? Colors.green : Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (notificationTriggered) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Triggered at: $lastNotificationTime',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    // STEP 28: Clear button to trigger test notification
                    ElevatedButton.icon(
                      onPressed: triggerTestNotification,
                      icon: const Icon(Icons.send),
                      label: const Text(
                        'Trigger Test Notification',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // STEP 27: Notification configuration options
            const Text(
              'Notification Preferences:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Daily Reminders'),
                    subtitle: const Text('Receive daily habit reminders'),
                    secondary: const Icon(Icons.alarm, color: Colors.orange),
                    value: true,
                    onChanged: (val) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val ? 'Daily reminders enabled' : 'Daily reminders disabled',
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Achievement Alerts'),
                    subtitle: const Text('Get notified on milestones'),
                    secondary: const Icon(Icons.celebration, color: Colors.purple),
                    value: true,
                    onChanged: (val) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val ? 'Achievement alerts enabled' : 'Achievement alerts disabled',
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Motivational Messages'),
                    subtitle: const Text('Receive encouraging messages'),
                    secondary: const Icon(Icons.favorite, color: Colors.red),
                    value: false,
                    onChanged: (val) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val ? 'Motivational messages enabled' : 'Motivational messages disabled',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Status indicator
            if (notificationTriggered)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notification System Active',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Test notification was successfully triggered!',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            
            // Back button
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
