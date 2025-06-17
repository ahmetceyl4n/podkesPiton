import 'package:flutter/material.dart';
import 'core/di/service_locator.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(); // Dependency Injection burada başlatılır
  runApp(const MyApp());
}
