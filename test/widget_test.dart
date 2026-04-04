import 'package:flutter_test/flutter_test.dart';

import 'package:fs_generador/main.dart';

void main() {
  testWidgets('Splash Screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that Splashcreen loads the subtitle text
    expect(find.text('Generador de plantillas fs'), findsOneWidget);
  });
}
