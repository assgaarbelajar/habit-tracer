import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

// STEP 13-15: Detail Screen
// Shows detailed item information
// Has navigation icon (back button)
// Has save/favorite option visible
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final LocalStorageService storage = LocalStorageService();
  bool isFavorited = false;

  // STEP 15: Save/favorite function
  Future<void> toggleFavorite(String itemId) async {
    setState(() {
      isFavorited = !isFavorited;
    });
    
    // Save favorite status to local storage (STEP 16-18)
    await storage.saveData('favorite_$itemId', isFavorited.toString());
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorited ? 'Added to favorites!' : 'Removed from favorites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the passed data from Home screen
    final dynamic post = ModalRoute.of(context)?.settings.arguments;
    
    // Extract post details or use default values
    final String title = post != null ? post['title'] : 'Item Title';
    final String body = post != null ? post['body'] : 'Item Description';
    final String itemId = post != null ? post['id'].toString() : '0';

    return Scaffold(
      // STEP 14: Navigation icon visible (back arrow in AppBar)
      appBar: AppBar(
        title: const Text("Item Details"),
        backgroundColor: Colors.blue,
        // Navigation icon automatically provided by Flutter (back arrow)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP 13: Display item information
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.article,
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Post #$itemId',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // STEP 15: Save/Favorite option visible
                        IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border,
                            color: isFavorited ? Colors.red : Colors.grey,
                            size: 32,
                          ),
                          onPressed: () => toggleFavorite(itemId),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Title:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      body,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Additional save button (STEP 15)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => toggleFavorite(itemId),
                icon: Icon(
                  isFavorited ? Icons.bookmark : Icons.bookmark_border,
                ),
                label: Text(
                  isFavorited ? 'Saved' : 'Save Item',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: isFavorited ? Colors.green : Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Back button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
