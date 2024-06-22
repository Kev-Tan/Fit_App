import 'package:flutter/material.dart';

class ExerciseLibraryPage extends StatefulWidget {
  final List<dynamic> exercisesData;

  ExerciseLibraryPage({required this.exercisesData});

  @override
  _ExerciseLibraryPageState createState() => _ExerciseLibraryPageState();
}

class _ExerciseLibraryPageState extends State<ExerciseLibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 31, 92, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(255, 249, 240, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Back Exercises',
          style: TextStyle(
            color: Color.fromRGBO(255, 249, 240, 1),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color.fromRGBO(255, 249, 240, 1),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/filter');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.exercisesData.length,
                itemBuilder: (context, index) {
                  var exercise = widget.exercisesData[index];
                  return ExerciseCard(
                    imageUrl: exercise['imageUrl'],
                    title: exercise['title'],
                    description: exercise['description'],
                    initialStarred: false, // You can set this based on your logic
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 249, 240, 1),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool initialStarred;

  ExerciseCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.initialStarred,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late bool isStarred;

  @override
  void initState() {
    super.initState();
    isStarred = widget.initialStarred;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Color.fromRGBO(255, 249, 240, 1),
      child: ListTile(
        leading: Image.network(widget.imageUrl), // Placeholder for the exercise image
        title: Text(
          widget.title,
          style: TextStyle(
            color: Color.fromRGBO(8, 31, 92, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(widget.description),
        trailing: IconButton(
          icon: Icon(
            isStarred ? Icons.star : Icons.star_border,
            color: isStarred
                ? Color.fromRGBO(8, 31, 92, 1)
                : Color.fromRGBO(8, 31, 92, 1),
          ),
          onPressed: () {
            setState(() {
              isStarred = !isStarred;
            });
          },
        ),
      ),
    );
  }
}
