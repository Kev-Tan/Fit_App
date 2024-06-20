import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPage createState() => _FilterPage();
}

class _FilterPage extends State<FilterPage> {
  List<String> muscleGroups = [
    'Back',
    'Cardio',
    'Chest',
    'Lower Arms',
    'Lower Legs',
    'Neck',
    'Shoulders',
    'Waist',
    'Upper Arms',
    'Upper Legs'
  ];
  List<String> equipment = [
    'Assisted',
    'Band',
    'Barbell',
    'Body Weight',
    'Skierg Machine',
    'Cable',
    'Roller',
    'Stability Ball',
    'Elliptical Machine',
    'Ez Barbell',
    'Hammer',
    'Kettlebell',
    'Rope',
    'Leverage Machine',
    'Bosu Ball',
    'Medicine Ball',
    'Sled Machine',
    'Olympic Barbell',
    'Dumbbell',
    'Resistance Band',
    'Trap Bar',
    'Smith Machine',
    'Wheel Roller',
    'Stationary Bike',
    'Weighted',
    'Stepmill Machine',
    'Tire',
    'Upper Body Ergometer'
  ];
  List<String> targetMuscles = [
    'Abductors',
    'Abs',
    'Adductors',
    'Biceps',
    'Calves',
    'Forearms',
    'Cardiovascular System',
    'Delts',
    'Glutes',
    'Triceps',
    'Hamstrings',
    'Lats',
    'Traps',
    'Levator Scapulae',
    'Spine',
    'Serratus Anterior',
    'Quads',
    'Pectorals',
    'Upper Back'
  ];

  Set<String> selectedMuscleGroups = {'Back'};
  Set<String> selectedEquipment = {'Cable'};
  Set<String> selectedTargetMuscles = {'Lats'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Muscle Group',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: muscleGroups.map((muscle) {
                return FilterChip(
                  label: Text(muscle),
                  selected: selectedMuscleGroups.contains(muscle),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedMuscleGroups.add(muscle);
                      } else {
                        selectedMuscleGroups.remove(muscle);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text('Equipment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: equipment.map((item) {
                return FilterChip(
                  label: Text(item),
                  selected: selectedEquipment.contains(item),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedEquipment.add(item);
                      } else {
                        selectedEquipment.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text('Target Muscles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: targetMuscles.map((muscle) {
                return FilterChip(
                  label: Text(muscle),
                  selected: selectedTargetMuscles.contains(muscle),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedTargetMuscles.add(muscle);
                      } else {
                        selectedTargetMuscles.remove(muscle);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Apply filter logic
                  print('Selected Muscle Groups: $selectedMuscleGroups');
                  print('Selected Equipment: $selectedEquipment');
                  print('Selected Target Muscles: $selectedTargetMuscles');
                },
                child: Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
