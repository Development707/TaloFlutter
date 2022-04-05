class DateOfBirth {
  final int day;
  final int month;
  final int year;

  DateOfBirth({
    this.day = 0,
    this.month = 0,
    this.year = 0,
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
