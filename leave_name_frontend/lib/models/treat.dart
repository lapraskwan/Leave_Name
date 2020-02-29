class Treat {
  int treatId;
  DateTime datetime;
  String reason;
  String name;
  String quantity;
  int floor;
  int teamId;
  int treated;

  Treat({
    this.treatId,
    this.datetime,
    this.reason,
    this.name,
    this.quantity,
    this.floor,
    this.teamId,
    this.treated,
  });

  Treat.fromJson(Map<String, dynamic> json)
      : treatId = json['treat_id'],
        datetime = DateTime.parse(json['datetime']),
        reason = json['reason'],
        name = json['floor_name'],
        quantity = json['quantity'],
        floor = json['floor'],
        teamId = json['team_id'],
        treated = json['treated'];
}
