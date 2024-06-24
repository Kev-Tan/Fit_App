import 'package:fit_app/models/user_provider.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final UserProvider userProvider;
  const FavoritesPage({super.key, required this.userProvider});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _removeFromFavorites(String exerciseName) async {
    setState(() {
      widget.userProvider.user!.favorites!.remove(exerciseName);
    });

    UserModel updatedUser = UserModel(
      uid: widget.userProvider.user!.uid,
      username: widget.userProvider.user!.username,
      profileImageUrl: widget.userProvider.user!.profileImageUrl,
      email: widget.userProvider.user!.email,
      gender: widget.userProvider.user!.gender,
      age: widget.userProvider.user!.age,
      height: widget.userProvider.user!.height,
      weight: widget.userProvider.user!.weight,
      neck: widget.userProvider.user!.neck,
      waist: widget.userProvider.user!.waist,
      hips: widget.userProvider.user!.hips,
      goal: widget.userProvider.user!.goal,
      level: widget.userProvider.user!.level,
      frequency: widget.userProvider.user!.frequency,
      duration: widget.userProvider.user!.duration,
      time: widget.userProvider.user!.time,
      favorites: widget.userProvider.user!.favorites,
    );

    await widget.userProvider.updateUser(updatedUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exercise removed from favorites!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

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
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _removeFromFavorites(favorites[index]);
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text('You currently do not have any favorite workout'),
            ),
    );
  }
}
