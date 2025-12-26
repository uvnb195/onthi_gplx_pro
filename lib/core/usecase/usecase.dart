import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failure.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {
  const NoParams();
}
