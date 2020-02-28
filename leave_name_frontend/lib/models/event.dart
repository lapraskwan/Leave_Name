class Event {
  int eventId;
  String title;
  String type;
  String venue;
  String poster;
  DateTime startTime;
  DateTime endTime;
  String dressCode;
  String description;

  Event({
    this.eventId,
    this.title,
    this.type,
    this.venue,
    this.poster,
    this.startTime,
    this.endTime,
    this.dressCode,
    this.description,
  });

  Event.fromJson(Map<String, dynamic> json)
      : eventId = json['event_id'],
        title = json['title'],
        type = json['type'],
        venue = json['venue'],
        poster = json['poster'],
        startTime = DateTime.parse(json['start_time']),
        endTime = DateTime.parse(json['end_time']),
        dressCode = json['dressCode'],
        description = json['description'];
}

class FloorEvent extends Event {
  int floor;

  FloorEvent(
    int floor, {
    eventId,
    title,
    type,
    venue,
    poster,
    startTime,
    endTime,
    dressCode,
    description,
  }) : super(
          eventId: eventId,
          title: title,
          type: type,
          venue: venue,
          poster: poster,
          startTime: startTime,
          endTime: endTime,
          dressCode: dressCode,
          description: description,
        );

  FloorEvent.fromJson(Map<String, dynamic> json)
      : floor = json['floor'],
        super.fromJson(json);
}

class TeamEvent extends Event {
  int teamId;

  TeamEvent(
    int teamId, {
    eventId,
    title,
    type,
    venue,
    poster,
    startTime,
    endTime,
    dressCode,
    description,
  }) : super(
          eventId: eventId,
          title: title,
          type: type,
          venue: venue,
          poster: poster,
          startTime: startTime,
          endTime: endTime,
          dressCode: dressCode,
          description: description,
        );

  TeamEvent.fromJson(Map<String, dynamic> json)
      : teamId = json['team_id'],
        super.fromJson(json);
}

class InterhallEvent extends Event {
  String opponent;
  String stage;

  InterhallEvent(
    String opponent,
    String stage, {
    eventId,
    title,
    type,
    venue,
    poster,
    startTime,
    endTime,
    dressCode,
    description,
  }) : super(
          eventId: eventId,
          title: title,
          type: type,
          venue: venue,
          poster: poster,
          startTime: startTime,
          endTime: endTime,
          dressCode: dressCode,
          description: description,
        );

  InterhallEvent.fromJson(Map<String, dynamic> json)
      : stage = json['stage'],
        opponent = json['opponent'],
        super.fromJson(json);
}
