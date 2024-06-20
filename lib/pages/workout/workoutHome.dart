import 'package:fit_app/pages/workout/pages/filter.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Set<String> selectedMuscleGroups = {'Back'};
  Set<String> selectedEquipment = {'Cable'};
  Set<String> selectedTargetMuscles = {'Lats'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterPage(),
              ),
            );

            if (result != null) {
              setState(() {
                selectedMuscleGroups = result['selectedMuscleGroups'];
                selectedEquipment = result['selectedEquipment'];
                selectedTargetMuscles = result['selectedTargetMuscles'];
              });
            }
          },
          child: Text('Open Filter Page'),
        ),
      ),
    );
  }
}
