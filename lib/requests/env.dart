import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '../lab6/keys.env')
abstract class Env {
  @EnviedField(varName: '_apiKey', obfuscate: true)
  static final String myApiKey = _Env.myApiKey;
}
