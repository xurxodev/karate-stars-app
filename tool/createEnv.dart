import 'dart:io';

Future<void> main() async {
  const developmentFile = '.env.development';
  File(developmentFile).writeAsString('');

  const productionFile = '.env.production';
  File(productionFile).writeAsString('');
}
