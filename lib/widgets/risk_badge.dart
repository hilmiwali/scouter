import 'package:flutter/material.dart';
import '../models/lookup_result.dart';

class RiskBadge extends StatelessWidget {
  final LookupResult result;

  const RiskBadge({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: result.riskColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${result.riskLevel} (${result.riskScore})',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
