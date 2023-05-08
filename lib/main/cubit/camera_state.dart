part of 'camera_cubit.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoaded extends CameraState {
  final XFile image;

  const CameraLoaded(this.image);

  @override
  List<Object> get props => [image];
}
