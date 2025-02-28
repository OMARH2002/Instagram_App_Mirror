import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/Search_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/SEARCH/state.dart';


class SearchCubit extends Cubit<SearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchCubit() : super(SearchInitial());

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final snapshot = await _firestore
          .collection('UserData')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThan: query + 'z')
          .get();

      final users = snapshot.docs
          .map((doc) => User.fromFirestore(doc.data(), doc.id))
          .toList();

      emit(SearchResults(users));
    } catch (e) {
      emit(SearchError('Failed to search users: $e'));
    }
  }
}