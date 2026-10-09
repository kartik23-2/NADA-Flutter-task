import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nada_app/app.dart';
import 'package:nada_app/features/profiles/presentation/screens/profile_list_screen.dart';

void main() {
  testWidgets('NadaApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: NadaApp(),
      ),
    );
    expect(find.byType(ProfileListScreen), findsOneWidget);
  });
}
