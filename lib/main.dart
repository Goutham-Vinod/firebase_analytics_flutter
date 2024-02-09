import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await analytics.logAddToCart(parameters: {
                      'item1': 2,
                      'item2': 3,
                    });
                  },
                  child: const Text('log add to cart')),
              ElevatedButton(
                  onPressed: () async {
                    await analytics.logEvent(name: 'custom_event', parameters: {
                      'parameterKey1': 'parameterVal1',
                      'parameterKey2': 'parameterVal2',
                    });
                  },
                  child: const Text('custom event')),
            ],
          ),
        ),
      ),
    );
  }
}
