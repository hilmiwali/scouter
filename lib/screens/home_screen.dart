import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OSINT Toolkit'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to OSINT Toolkit',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Gather open-source intelligence on IP addresses, domains, and email addresses.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildFeatureCard(
              context,
              'IP Address Lookup',
              'Get geolocation, open ports, and security information',
              Icons.location_on,
              () => Navigator.pushNamed(context, '/lookup'),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              context,
              'Domain Analysis',
              'WHOIS information and DNS records',
              Icons.language,
              () => Navigator.pushNamed(context, '/lookup'),
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              context,
              'Email Breach Check',
              'Check if email appears in known data breaches',
              Icons.email,
              () => Navigator.pushNamed(context, '/lookup'),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/lookup'),
                    child: const Text('Start Lookup'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: const Text('View History'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[800]),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
