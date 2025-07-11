import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:scouter/models/ip_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lookup_result.dart';
import '../services/shodan_service.dart';
import '../services/hibp_service.dart';
import '../services/whois_service.dart';
import '../utils/risk_calculator.dart';

class LookupProvider extends ChangeNotifier {
  List<LookupResult> _history = [];
  LookupResult? _currentResult;
  bool _isLoading = false;
  String? _error;

  List<LookupResult> get history => _history;
  LookupResult? get currentResult => _currentResult;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> performLookup(String query, String type) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      Map<String, dynamic> data = {};
      List<String> findings = [];
      int riskScore = 0;

      switch (type) {
        case 'ip':
          final ipInfo = await ShodanService.getIPInfo(query);
          if (ipInfo != null) {
            data = ipInfo.toJson();
            findings = _generateIPFindings(ipInfo);
            riskScore = RiskCalculator.calculateIPRisk(ipInfo);
          }
          break;
        case 'email':
          final breaches = await HIBPService.checkEmailBreaches(query);
          data = {'breaches': breaches};
          findings = _generateEmailFindings(breaches);
          riskScore = RiskCalculator.calculateEmailRisk(breaches);
          break;
        case 'domain':
          final domainInfo = await WhoisService.getDomainInfo(query);
          data = domainInfo;
          findings = _generateDomainFindings(domainInfo);
          riskScore = RiskCalculator.calculateDomainRisk(domainInfo);
          break;
      }

      _currentResult = LookupResult(
        query: query,
        type: type,
        timestamp: DateTime.now(),
        data: data,
        riskScore: riskScore,
        findings: findings,
      );

      _history.insert(0, _currentResult!);
      await _saveHistory();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<String> _generateIPFindings(IPInfo ipInfo) {
    List<String> findings = [];
    if (ipInfo.isBlacklisted) findings.add('IP is blacklisted');
    if (ipInfo.openPorts != null && ipInfo.openPorts!.isNotEmpty) {
      findings.add('${ipInfo.openPorts!.length} open ports detected');
    }
    return findings;
  }

  List<String> _generateEmailFindings(List<String> breaches) {
    List<String> findings = [];
    if (breaches.isNotEmpty) {
      findings.add('Found in ${breaches.length} data breach(es)');
    }
    return findings;
  }

  List<String> _generateDomainFindings(Map<String, dynamic> domainInfo) {
    List<String> findings = [];
    // Add domain-specific findings based on the data
    return findings;
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = _history.map((result) => result.toJson()).toList();
    await prefs.setString('lookup_history', jsonEncode(historyJson));
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString('lookup_history');
    if (historyString != null) {
      final List<dynamic> historyJson = jsonDecode(historyString);
      _history = historyJson
          .map((json) => LookupResult.fromJson(json))
          .toList();
      notifyListeners();
    }
  }
}
