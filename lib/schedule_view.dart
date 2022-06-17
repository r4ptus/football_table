import 'package:flutter/material.dart';
import 'package:football_table/models/schedule.dart';
import 'package:football_table/schedule_list_tile.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key, required this.title, required this.liga})
      : super(key: key);

  final String title;
  final String liga;

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  List<Schedule> schedule = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://vereine.football-verband.de/xmlspielplan.php5?Liga=${widget.liga}'));
    final converter = Xml2Json();

    if (response.statusCode == 200) {
      converter.parse(response.body);
      var json = converter.toParker();
      setState(() {
        schedule = scheduleFromJson(json).tabelle.team;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: schedule.length,
          itemBuilder: (context, index) =>
              ScheduleListTile(schedule: schedule[index]),
        ));
  }
}
