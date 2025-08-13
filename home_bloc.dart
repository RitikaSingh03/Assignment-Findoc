import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/photo_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PhotoRepository repository;

  HomeBloc(this.repository) : super(HomeState.initial()) {
    on<FetchPhotos>((event, emit) async {
      emit(state.copyWith(isLoading: true, isError: false));
      try {
        final photos = await repository.fetchPhotos();
        emit(state.copyWith(isLoading: false, photos: photos));
      } catch (_) {
        emit(state.copyWith(isLoading: false, isError: true));
      }
    });
  }
}
