import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:fit_app/models/user_provider.dart'; // Import your UserProvider class

class MyHeatMap extends StatelessWidget {
  final UserProvider userProvider;

  const MyHeatMap({Key? key, required this.userProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> convertedDates = [];

    // Fetch completedDays from UserProvider and convert to DateTime
    if (userProvider.user != null && userProvider.user!.completedDays != null) {
      convertedDates = userProvider.user!.completedDays!
          .map((timestamp) => timestamp.toDate())
          .toList();
    }

    return HeatMap(
      datasets: _buildDatasets(convertedDates),
      startDate: DateTime.now().subtract(const Duration(days: 12)),
      endDate: DateTime.now().add(const Duration(days: 1)),
      // colorMode: ColorMode.color, // Assuming this is optional or not needed
      showText: true,
      scrollable: true,
      showColorTip: false,
      colorsets: {
        1: const Color(0xFF02B308), // "yes" color
      },
      textColor: Theme.of(context).colorScheme.primary,
      fontSize: 10,
    );
  }

  Map<DateTime, int> _buildDatasets(List<DateTime> dates) {
    Map<DateTime, int> datasets = {};

    for (var date in dates) {
      datasets[DateTime(date.year, date.month, date.day)] = 1;
    }

    return datasets;
  }
}
