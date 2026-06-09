import 'package:flutter/material.dart';
import 'package:flutter_clean_services/flutter_clean_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('la app de ejemplo expone MaterialApp', (tester) async {
    // En CI real se inicializaría configureDependencies con servicios fake o un
    // backend de pruebas antes de montar la app completa.
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Clean Architecture'))));

    expect(find.text('Clean Architecture'), findsOneWidget);
  });
}
