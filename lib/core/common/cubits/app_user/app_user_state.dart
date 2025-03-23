part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggeedIn extends AppUserState {
  final User user;

  AppUserLoggeedIn(this.user);
}
