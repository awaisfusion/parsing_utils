# parsing_util
A simple and safe parsing utility for Flutter & Dart.
Easily convert `dynamic` values into safe types (`String`, `int`, `double`, `bool`, `DateTime`, `List`, etc.) without throwing errors.  
Includes handy **String extensions** (`orEmpty`, `orNullString`).

---

## Features

- ✅ Safe parsing for all common types
- ✅ Converts `String`, `int`, `double`, `bool`, `DateTime`, and `List`
- ✅ Avoids runtime crashes by falling back to default values
- ✅ Built-in validation for IDs (`toValidId`)
- ✅ Lightweight and easy to use
- ✅ Useful String extensions (`orEmpty`, `orNullString`)

---

## Getting started

Add this to your `pubspec.yaml`:

```dart
dependencies:
parsing_util: ^0.0.1

