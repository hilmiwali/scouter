import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lookup_provider.dart';
import '../widgets/lookup_form.dart';

class LookupScreen extends StatelessWidget {
  const LookupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OSINT Lookup'),
        backgroundColor: Colors.blue[800],
      ),
      body: Consumer<LookupProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Gathering intelligence...'),
                ],
              ),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${provider.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Reset error state
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (provider.currentResult != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, '/results');
            });
          }

          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: LookupForm(),
          );
        },
      ),
    );
  }
}
