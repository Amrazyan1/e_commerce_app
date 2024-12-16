import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationRequiredPopup extends StatelessWidget {
  const AuthorizationRequiredPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Authorization Required',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        'You need to authorize to access this feature.',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // User canceled
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // User authorized
          },
          child: const Text('Authorize'),
        ),
      ],
    );
  }
}

// Function to show the popup
Future<bool> showAuthorizationPopup(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('auth_token');

  if (authToken != null && authToken.isNotEmpty) {
    return true; // User is already authorized
  }
  showDialog<bool>(
    context: context,
    builder: (_) => const AuthorizationRequiredPopup(),
  );
  return false;
  // Show the popup if not authorized
  return await showDialog<bool>(
    context: context,
    builder: (_) => const AuthorizationRequiredPopup(),
  ).then((value) => value ?? false); // Return false if dialog is dismissed
}
