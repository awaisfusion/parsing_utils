import 'package:parsing_util/parsing_util.dart';

void main() {
  print(ParsingUtil.toSafeString(null, defaultValue: 'N/A')); // N/A
  print(ParsingUtil.toSafeInt("42")); // 42
  print(ParsingUtil.toSafeDouble("3.14")); // 3.14
  print(ParsingUtil.toSafeBoolean("true")); // true
  print("hello".orEmpty()); // hello
  print((null as String?).orEmpty()); // ""
}
