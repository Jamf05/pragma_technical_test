import 'package:formz/formz.dart';

enum QueryInputError { empty }

class QueryInput extends FormzInput<String, QueryInputError> {
  const QueryInput.pure() : super.pure('');

  const QueryInput.dirty({String value = ''}) : super.dirty(value);

  @override
  QueryInputError? validator(String value) {
    return value.isEmpty ? QueryInputError.empty : null;
  }
}
