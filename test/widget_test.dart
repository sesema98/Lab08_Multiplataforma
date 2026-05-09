import 'package:flutter_test/flutter_test.dart';

import 'package:movilesmulti/main.dart';

void main() {
  testWidgets('muestra el login inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const InventoryApp());

    expect(find.text('Iniciar sesion'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });
}
