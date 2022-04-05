class DateOfBirth {
  final int day;
  final int month;
  final int year;

  DateOfBirth({
    required this.day,
    required this.month,
    required this.year,
  });

  factory DateOfBirth.fromJson(Map<String, dynamic> json) {
    return DateOfBirth(
      day: json["day"],
      month: json["month"],
      year: json["year"],
    );
  }

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
        "year": year,
      };
}
