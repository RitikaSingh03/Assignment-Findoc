import 'package:equatable/equatable.dart';
import '../data/photo_model.dart';

class HomeState extends Equatable {
  final List<Photo> photos;
  final bool isLoading;
  final bool isError;

  const HomeState({
    required this.photos,
    required this.isLoading,
    required this.isError,
  });

  factory HomeState.initial() {
    return const HomeState(
      photos: [],
      isLoading: false,
      isError: false,
    );
  }

  HomeState copyWith({
    List<Photo>? photos,
    bool? isLoading,
    bool? isError,
  }) {
    return HomeState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [photos, isLoading, isError];
}
