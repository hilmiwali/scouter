import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lookup_provider.dart';
import '../utils/validators.dart';

class LookupForm extends StatefulWidget {
  const LookupForm({super.key});

  @override
  State<LookupForm> createState() => _LookupFormState();
}

class _LookupFormState extends State<LookupForm> {
  final _formKey = GlobalKey<FormState>();
  final _queryController = TextEditingController();
  String _selectedType = 'ip';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your query:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Lookup Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'ip', child: Text('IP Address')),
              DropdownMenuItem(value: 'domain', child: Text('Domain')),
              DropdownMenuItem(value: 'email', child: Text('Email')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
                _queryController.clear();
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _queryController,
            decoration: InputDecoration(
              labelText: _getLabelText(),
              hintText: _getHintText(),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a ${_selectedType}';
              }
              
              switch (_selectedType) {
                case 'ip':
                  if (!Validators.isValidIP(value)) {
                    return 'Please enter a valid IP address';
                  }
                  break;
                case 'email':
                  if (!Validators.isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  break;
                case 'domain':
                  if (!Validators.isValidDomain(value)) {
                    return 'Please enter a valid domain';
                  }
                  break;
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LookupProvider>().performLookup(
                        _queryController.text.trim(),
                        _selectedType,
                      );
                }
              },
              child: const Text('Start Lookup'),
            ),
          ),
        ],
      ),
    );
  }

  String _getLabelText() {
    switch (_selectedType) {
      case 'ip':
        return 'IP Address';
      case 'email':
        return 'Email Address';
      case 'domain':
        return 'Domain Name';
      default:
        return 'Query';
    }
  }

  String _getHintText() {
    switch (_selectedType) {
      case 'ip':
        return 'e.g., 8.8.8.8';
      case 'email':
        return 'e.g., user@example.com';
      case 'domain':
        return 'e.g., example.com';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}
