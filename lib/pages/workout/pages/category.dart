import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fit_app/models/user_provider.dart';

class CategoryPage extends StatefulWidget {
  final UserProvider userProvider;
  final String category;

  const CategoryPage({
    Key? key,
    required this.userProvider,
    required this.category,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isLoading = false;
  List<dynamic> exercisesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'X-RapidAPI-Key': 'bd42feb2c0msh9d6def32c640a64p129898jsn5e10e71f428b',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };

    var uri = Uri.https(
      'exercisedb.p.rapidapi.com',
      '/exercises/bodyPart/${widget.category.toLowerCase()}',
      {'limit': '50'},
    );

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        exercisesData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addToFavorites(String exerciseName) async {
    final favorites = widget.userProvider.user!.favorites ?? [];

    if (favorites.contains(exerciseName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This exercise is already in your favorites!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      setState(() {
        widget.userProvider.user!.favorites!.add(exerciseName);
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
        //time: widget.userProvider.user!.time,
        favorites: widget.userProvider.user!.favorites,
        completedDays: widget.userProvider.user!.completedDays,
      );

      await widget.userProvider.updateUser(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exercise added to favorites!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            fontSize: 24.0,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.all(16.0), // Add padding around the column
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: exercisesData.length,
                      itemBuilder: (context, index) {
                        var exercise = exercisesData[index];
                        return ExerciseDetailCard(
                          number: index + 1,
                          exerciseName: _capitalizeWords(exercise['name']),
                          bodyPart: _capitalizeWords(exercise['bodyPart']),
                          target: _capitalizeWords(exercise['target']),
                          equipment: _capitalizeWords(exercise['equipment']),
                          gifUrl: exercise['gifUrl'],
                          instructions:
                              (exercise['instructions'] as List).cast<String>(),
                          color: index.isEven ? Colors.blue : Colors.pink,
                          onPressedFavorite: () {
                            addToFavorites(exercise['name']);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String _capitalizeWords(String input) {
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class ExerciseDetailCard extends StatelessWidget {
  final int number;
  final String exerciseName;
  final String bodyPart;
  final String target;
  final String equipment;
  final String gifUrl;
  final List<String> instructions;
  final Color color;
  final VoidCallback? onPressedFavorite;

  const ExerciseDetailCard({
    Key? key,
    required this.number,
    required this.exerciseName,
    required this.bodyPart,
    required this.target,
    required this.equipment,
    required this.gifUrl,
    required this.instructions,
    required this.color,
    this.onPressedFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjusted margin
      elevation: 10,
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(16), // Adjusted padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '$number. $exerciseName',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.star,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: onPressedFavorite,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Body Part: $bodyPart',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            Text(
              'Target: $target',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            Text(
              'Equipment: $equipment',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(gifUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Instructions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: instructions
                  .map((instruction) => Text(
                        ' - $instruction',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
