import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cv_flutter_mathegloria/main.dart';

void main() {
  testWidgets('login opens the CV and navigation changes pages', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Bienvenue'), findsOneWidget);

    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();
    expect(find.text('Entrez un identifiant'), findsOneWidget);
    expect(find.text('Entrez un mot de passe'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'mathe');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();
    expect(find.text('ALIKA MUBARHUZI'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.people_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Ma Famille'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.contact_page_rounded));
    await tester.pumpAndSettle();
    expect(find.text('marthegloria545@gmail.com'), findsOneWidget);
  });
}
