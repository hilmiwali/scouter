import '../models/ip_info.dart';

class RiskCalculator {
  static int calculateIPRisk(IPInfo ipInfo) {
    int risk = 0;
    
    if (ipInfo.isBlacklisted) risk += 50;
    if (ipInfo.openPorts != null && ipInfo.openPorts!.isNotEmpty) {
      risk += ipInfo.openPorts!.length * 5;
    }
    
    return risk.clamp(0, 100);
  }

  static int calculateEmailRisk(List<String> breaches) {
    return (breaches.length * 20).clamp(0, 100);
  }

  static int calculateDomainRisk(Map<String, dynamic> domainInfo) {
    // Implement domain risk calculation logic
    return 0;
  }
}
