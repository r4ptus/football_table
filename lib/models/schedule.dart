import 'dart:convert';

TableSchedule scheduleFromJson(String str) => TableSchedule.fromJson(json.decode(str));

String scheduleToJson(TableSchedule data) => json.encode(data.toJson());

class TableSchedule {
    TableSchedule({
        required this.tabelle,
    });

    TabelleSchedule tabelle;

    factory TableSchedule.fromJson(Map<String, dynamic> json) => TableSchedule(
        tabelle: TabelleSchedule.fromJson(json["tabelle"]),
    );

    Map<String, dynamic> toJson() => {
        "tabelle": tabelle.toJson(),
    };
}

class TabelleSchedule {
    TabelleSchedule({
        required this.team,
    });

    List<Schedule> team;

    factory TabelleSchedule.fromJson(Map<String, dynamic> json) => TabelleSchedule(
        team: List<Schedule>.from(json["Team"].map((x) => Schedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Team": List<dynamic>.from(team.map((x) => x.toJson())),
    };
}

class Schedule {
    Schedule({
        required this.id,
        required this.liga,
        required this.bezeichnung,
        required this.gruppe,
        required this.datum1,
        required this.datum2,
        required this.kickoff,
        required this.heim,
        required this.heimname,
        required this.heimkuerzel,
        required this.gast,
        required this.gastname,
        required this.gastkuerzel,
        required this.tdHeim,
        required this.tdGast,
        required this.q1Heim,
        required this.q1Gast,
        required this.q2Heim,
        required this.q2Gast,
        required this.q3Heim,
        required this.q3Gast,
        required this.q4Heim,
        required this.q4Gast,
        required this.stadion,
        this.kommentar,
    });

    String id;
    String liga;
    String bezeichnung;
    String gruppe;
    DateTime datum1;
    String datum2;
    String kickoff;
    String heim;
    String heimname;
    String heimkuerzel;
    String gast;
    String gastname;
    String gastkuerzel;
    String tdHeim;
    String tdGast;
    String q1Heim;
    String q1Gast;
    String q2Heim;
    String q2Gast;
    String q3Heim;
    String q3Gast;
    String q4Heim;
    String q4Gast;
    String stadion;
    String? kommentar;

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["ID"],
        liga: json["Liga"],
        bezeichnung: json["Bezeichnung"],
        gruppe: json["Gruppe"] ?? "A",
        datum1: DateTime.parse(json["Datum1"]),
        datum2: json["Datum2"],
        kickoff: json["Kickoff"],
        heim: json["Heim"],
        heimname: json["Heimname"],
        heimkuerzel: json["Heimkuerzel"],
        gast: json["Gast"],
        gastname: json["Gastname"],
        gastkuerzel: json["Gastkuerzel"],
        tdHeim: json["TDHeim"],
        tdGast: json["TDGast"],
        q1Heim: json["Q1Heim"],
        q1Gast: json["Q1Gast"],
        q2Heim: json["Q2Heim"],
        q2Gast: json["Q2Gast"],
        q3Heim: json["Q3Heim"],
        q3Gast: json["Q3Gast"],
        q4Heim: json["Q4Heim"],
        q4Gast: json["Q4Gast"],
        stadion: json["Stadion"],
        kommentar: json["Kommentar"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Liga": liga,
        "Bezeichnung": bezeichnung,
        "Gruppe": gruppe,
        "Datum1": "${datum1.year.toString().padLeft(4, '0')}-${datum1.month.toString().padLeft(2, '0')}-${datum1.day.toString().padLeft(2, '0')}",
        "Datum2": datum2,
        "Kickoff": kickoff,
        "Heim": heim,
        "Heimname": heimname,
        "Heimkuerzel": heimkuerzel,
        "Gast": gast,
        "Gastname": gastname,
        "Gastkuerzel": gastkuerzel,
        "TDHeim": tdHeim,
        "TDGast": tdGast,
        "Q1Heim": q1Heim,
        "Q1Gast": q1Gast,
        "Q2Heim": q2Heim,
        "Q2Gast": q2Gast,
        "Q3Heim": q3Heim,
        "Q3Gast": q3Gast,
        "Q4Heim": q4Heim,
        "Q4Gast": q4Gast,
        "Stadion": stadion,
        "Kommentar": kommentar,
    };
}