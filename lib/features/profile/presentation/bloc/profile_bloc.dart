import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_event.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileUpdateRequested>(_onUpdateRequested);
  }

  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await getProfileUseCase(event.userId);
    result.when(
      success: (profile) => emit(ProfileLoaded(profile: profile)),
      failure: (failure) => emit(ProfileError(failure: failure)),
    );
  }

  Future<void> _onUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final current = state.currentProfile;
    if (current == null) return;

    emit(ProfileUpdating(profile: current));
    final result = await updateProfileUseCase(
      UpdateProfileParams(
        userId: event.userId,
        name: event.name,
        phone: event.phone,
      ),
    );
    result.when(
      success: (profile) => emit(ProfileUpdateSuccess(profile: profile)),
      failure: (failure) => emit(
        ProfileUpdateError(failure: failure, profile: current),
      ),
    );
  }
}
