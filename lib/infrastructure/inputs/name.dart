import 'package:formz/formz.dart';

// Define input validation errors
enum NameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == NameError.length) {
      return 'Mínimo 50 caracteres';
    }
    // if (displayError == NameError.format)
    //   return 'Debe de tener Mayúscula, letras y un número';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return NameError.empty;
    }

    if (value.length > 50) {
      return NameError.length;
    }
    // if (!passwordRegExp.hasMatch(value)) return PasswordError.format;

    return null;
  }
}
