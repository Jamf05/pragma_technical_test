import 'package:dartz/dartz.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';

typedef UseCase<Type, Params> = Future<Either<Failure, Type>> Function(Params params);

// abstract class UseCase<Type, Params> {
//   Future<Either<Failure, Type>> call(Params params);
// }