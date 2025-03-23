import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn implements UseCase<User, UserLogInParams> {
  final AuthRepository authRepository;

  UserLogIn(this.authRepository);

  @override
  Future<Either<Failures, User>> call(UserLogInParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams({required this.email, required this.password});
}
