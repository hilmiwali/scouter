import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lookup_provider.dart';
import '../widgets/risk_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lookup History'),
        backgroundColor: Colors.blue[800],
      ),
      body: Consumer<LookupProvider>(
        builder: (context, provider, child) {
          if (provider.history.isEmpty) {
            return const Center(
              child: Text('No lookup history available'),
            );
          }

          return ListView.builder(
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              final result = provider.history[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(result.query),
                  subtitle: Text('${result.type.toUpperCase()} - ${result.timestamp}'),
                  trailing: RiskBadge(result: result),
                  onTap: () {
                    // Navigate to detailed view
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
