import 'package:flutter/material.dart';
import 'package:football_table/league_table.dart';
import 'package:football_table/tabs.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:xml2json/xml2json.dart';

import 'models/table.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Tabelle> futureString;

  Future<Tabelle> fetchString() async {
    final response = await http
        .get(Uri.parse('https://vereine.football-verband.de/xmltabelle.php5'));
    final converter = Xml2Json();

    if (response.statusCode == 200) {
      converter.parse(response.body);
      var json = converter.toParker();
      return tableFromJson(json);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureString = fetchString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ligen")),
      body: Center(
        child: FutureBuilder<Tabelle>(
          future: futureString,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final teams = snapshot.data!.tabelle.teams;
              final leagues = getLeagues(teams);
              return ListView.builder(
                  itemCount: getLeagues(teams).keys.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(leagues.keys.toList().elementAt(index)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tabs(
                                      teams: leagues[leagues.keys
                                          .toList()
                                          .elementAt(index)]!,
                                      title: leagues.keys
                                          .toList()
                                          .elementAt(index),
                                    ))),
                      ));
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Map<String, List<Team>> getLeagues(List<Team> teams) {
    final Map<String, List<Team>> dict =
        groupBy(teams, (Team team) => team.bezeichnung);
    dict.removeWhere((key, value) => key.contains("Jugend") || key.contains("Flag"));
    return dict;
  }
}
