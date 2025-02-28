import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/Search_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/SEARCH/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/SEARCH/state.dart';
import 'package:instagram_duplicate_app/UI/Search/User_Searched.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Users'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(),
            ),
            const Expanded(
              child: SearchResultsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
   SearchBar({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search by username...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onChanged: (query) {
        context.read<SearchCubit>().searchUsers(query);
      },
    );
  }
}

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(child: Text(state.message));
        }
        if (state is SearchResults) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return UserTile(user: user);
            },
          );
        }
        return const Center(child: Text('Search for users...'));
      },
    );
  }
}

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.avatar.isNotEmpty
            ? NetworkImage(user.avatar)
            : const AssetImage('assets/default_profile.png') as ImageProvider,
        radius: 20,
      ),
      title: Text(user.username),
      subtitle: Text(user.bio),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(user: user),
          ),
        );
      },
    );
  }
}