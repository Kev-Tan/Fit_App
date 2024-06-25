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
      // time: widget.userProvider.user!.time,
      favorites: widget.userProvider.user!.favorites,
      completedDays: widget.userProvider.user!.completedDays,
    );

    await widget.userProvider.updateUser(updatedUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exercise removed from favorites!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  String _capitalizeWords(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userProvider.user!;
    var favorites = user.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: favorites != null && favorites.isNotEmpty
          ? ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final exerciseName = _capitalizeWords(favorites[index]);

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4, // Add drop shadow
                  color: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Optional: Add rounded corners
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exerciseName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4), // Reduced spacing
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete,
                                color: Color.fromRGBO(200, 200, 200, 1)),
                            onPressed: () {
                              _removeFromFavorites(favorites[index]);
                            },
                          ),
                        ),
                      ],
                    ),
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
