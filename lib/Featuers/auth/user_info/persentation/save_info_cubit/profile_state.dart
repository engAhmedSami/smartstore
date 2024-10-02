abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileError && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
