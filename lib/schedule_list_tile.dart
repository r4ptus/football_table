import 'package:flutter/material.dart';
import 'package:football_table/models/schedule.dart';
import 'package:intl/intl.dart';

class ScheduleListTile extends StatelessWidget {
  ScheduleListTile({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;
  final f = DateFormat("dd.MM.yy");

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("${schedule.heimname} : ${schedule.gastname}"),
      leading: Text(f.format(schedule.datum1)),
      trailing: Text("${schedule.tdHeim}:${schedule.tdGast}"),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 20),
            child: Row(
              children: [
                const Text("Ort:"),
                const Spacer(),
                Text(schedule.stadion)
              ],
            )),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 20),
            child: Row(
              children: [
                const Text("Kickoff:"),
                const Spacer(),
                Text(schedule.kickoff)
              ],
            )),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 20),
            child: Row(
              children: [
                const Text("Ergebnis:"),
                const Spacer(),
                Text(
                    "(${schedule.q1Heim}:${schedule.q1Gast}|${schedule.q2Heim}:${schedule.q2Gast}|${schedule.q3Heim}:${schedule.q3Gast}|${schedule.q4Heim}:${schedule.q4Gast})")
              ],
            )),
      ],
    );
  }
}
