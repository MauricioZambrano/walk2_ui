import 'package:flutter/material.dart';
import 'package:walk2_ui/services/walk_2_service_facade.dart';
import 'dart:convert';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Walk2', home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _walk2ServiceFacade = Walk2ServiceFacade();
  dynamic _recommendations;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getRecommendations();
  }

  Future<void> _getRecommendations() async {
    try {
      final response = await _walk2ServiceFacade.getRecommendations(
        queryParams: {'userId': '123456', 'timeToDestinationSec': 20},
      );
      setState(() {
        _recommendations = response;
        _loading = false;
      });
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Raw JSON')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText(
            const JsonEncoder.withIndent('  ').convert(_recommendations),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
        ),
      ),
    );
  }
}
