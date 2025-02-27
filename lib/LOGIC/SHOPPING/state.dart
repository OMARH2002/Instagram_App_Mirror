import 'package:instagram_duplicate_app/DATA/shopping_Model.dart';

abstract class ShoppingState {}

class ShoppingInitial extends ShoppingState {}

class ShoppingLoading extends ShoppingState {}

class ShoppingLoaded extends ShoppingState {
  final List<ShoppingItem> items;
  ShoppingLoaded(this.items);
}

class ShoppingError extends ShoppingState {
  final String message;
  ShoppingError(this.message);
}

class UploadingItem extends ShoppingState {}

class ItemUploaded extends ShoppingState {}