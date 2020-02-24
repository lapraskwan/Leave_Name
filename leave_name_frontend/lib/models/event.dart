class Event{
  String name;
  String type;
  String venue;
  String image;
  DateTime startTime;
  DateTime endTime;
  String dressCode;
  String description;
  int numberOfAttending;

  Event({
    this.name,
    this.type,
    this.venue,
    this.image,
    this.startTime,
    this.endTime,
    this.dressCode,
    this.description,
    this.numberOfAttending,
  });
}