import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lookup_provider.dart';
import '../widgets/risk_badge.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lookup Results'),
        backgroundColor: Colors.blue[800],
      ),
      body: Consumer<LookupProvider>(
        builder: (context, provider, child) {
          final result = provider.currentResult;
          if (result == null) {
            return const Center(child: Text('No results available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Query: ${result.query}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RiskBadge(result: result),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Type: ${result.type.toUpperCase()}'),
                        Text('Timestamp: ${result.timestamp}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (result.findings.isNotEmpty) ...[
                  const Text(
                    'Findings:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...result.findings.map((finding) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.warning, color: Colors.orange),
                          title: Text(finding),
                        ),
                      )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
