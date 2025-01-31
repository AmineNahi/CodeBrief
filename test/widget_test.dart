import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:code_brief/main.dart'; // Assurez-vous que le nom correspond au nouveau nom du projet

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Utilisez TaskManagerApp (ou le nom de votre classe principale)
    await tester.pumpWidget(TaskManagerApp());

    // Exemple de test (peut être modifié ou supprimé)
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
