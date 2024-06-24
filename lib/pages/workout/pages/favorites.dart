import 'package:fit_app/models/user_provider.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final UserProvider userProvider;
  const FavoritesPage({super.key, required this.userProvider});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.userProvider.user!;
    var favorites = user.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favorites != null && favorites.isNotEmpty
          ? ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favorites[index]),
                );
              },
            )
          : Center(
              child: Text('You currently do not have any favorite workout'),
            ),
    );
  }
}
