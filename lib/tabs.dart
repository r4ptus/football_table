import 'package:flutter/material.dart';
import 'package:football_table/league_table.dart';
import 'package:football_table/schedule_view.dart';

import 'models/table.dart';

class Tabs extends StatelessWidget {
  const Tabs({Key? key, required this.title, required this.teams}) : super(key: key);

  final String title;
  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
       child:  Scaffold(
      appBar: AppBar(title: Text(title), bottom: const TabBar(tabs: [
        Tab(text: "Tabelle",),
        Tab(text: "Spielplan",)
      ]),),
      body: TabBarView(
        children: [
          LeagueTable(teams: teams,),
          ScheduleView(title: title, liga: teams.first.liga,)
        ],)
    ));
  }
}