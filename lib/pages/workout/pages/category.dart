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
      'X-RapidAPI-Key': '7ab947740cmshd323f3c44a46163p15f232jsnaa7e65139c2a',
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
        time: widget.userProvider.user!.time,
        favorites: widget.userProvider.user!.favorites,
      );

      await widget.userProvider.updateUser(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exercise added to favorites!'),
          duration: Duration(seconds: 3),
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
            color: Color(0xFF00008B),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: exercisesData.length,
                    itemBuilder: (context, index) {
                      var exercise = exercisesData[index];
                      return ExerciseDetailCard(
                        number: index + 1,
                        exerciseName: exercise['name'],
                        bodyPart: exercise['bodyPart'],
                        target: exercise['target'],
                        equipment: exercise['equipment'],
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
    );
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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '$number. Exercise Name: $exerciseName',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: Colors.yellow),
                  onPressed: onPressedFavorite,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Body Part: $bodyPart'),
            Text('Target: $target'),
            Text('Equipment: $equipment'),
            SizedBox(height: 8),
            Image.network(
              gifUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: instructions
                  .map((instruction) => Text(' - $instruction'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
