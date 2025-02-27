
import 'package:instagram_duplicate_app/DATA/REELS_MODEL.dart';

class ReelState {}

class ReelInitial extends ReelState {}

class ReelUploading extends ReelState {}

class ReelUploadSuccess extends ReelState {}

class ReelUploadFailure extends ReelState {
  final String error;
  ReelUploadFailure(this.error);
}

class ReelsLoading extends ReelState {}

class ReelsLoaded extends ReelState {
  final List<ReelModel> reels;
  ReelsLoaded(this.reels);
}

class ReelsEmpty extends ReelState {}