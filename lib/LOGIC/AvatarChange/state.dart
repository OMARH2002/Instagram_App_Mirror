import 'dart:io';

class AvatarState {}

class AvatarInitial extends AvatarState {}

class AvatarPicked extends AvatarState {
  final File file;
  AvatarPicked(this.file);
}

class AvatarUploading extends AvatarState {}

class AvatarUploaded extends AvatarState {
  final String imageUrl;
  AvatarUploaded(this.imageUrl);
}

class AvatarError extends AvatarState {
  final String message;
  AvatarError(this.message);
}