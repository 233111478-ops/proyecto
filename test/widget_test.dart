import 'package:flutter_test/flutter_test.dart';

import 'package:biophysique/main.dart';

void main() {
  testWidgets('La app arranca correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const BiophysiqueApp());
    expect(find.byType(BiophysiqueApp), findsOneWidget);

    // Deja pasar el tiempo del splash para que no queden timers pendientes
    await tester.pump(const Duration(seconds: 5));
  });
}
