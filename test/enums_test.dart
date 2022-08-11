import 'package:due_date/due_date.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Weekday:', () {
    group('Throw on factory outside of range:', () {
      test('Value below 1', () {
        expect(() => Weekday.fromDateTime(0), throwsRangeError);
      });
      test('Value above 7', () {
        expect(() => Weekday.fromDateTime(8), throwsRangeError);
      });
    });
    group('Previous:', () {
      for (final weekday in Weekday.values) {
        test(weekday.name, () {
          if (weekday != Weekday.monday) {
            expect(
              weekday.previous,
              equals(Weekday.fromDateTime(weekday.dateTimeValue - 1)),
            );
          } else {
            expect(weekday.previous, equals(Weekday.sunday));
          }
        });
      }
    });
    group('Next:', () {
      for (final weekday in Weekday.values) {
        test(weekday.name, () {
          if (weekday != Weekday.sunday) {
            expect(
              weekday.next,
              equals(Weekday.fromDateTime(weekday.dateTimeValue + 1)),
            );
          } else {
            expect(weekday.next, equals(Weekday.monday));
          }
        });
      }
    });
    group('WeekendDays:', () {
      final set = {Weekday.saturday, Weekday.sunday};
      test('Contains $set', () {
        expect(
          Weekday.weekendDays,
          containsAllInOrder(set),
        );
      });
      test('Is ${set.runtimeType}', () {
        expect(
          Weekday.weekendDays,
          isA<Set<Weekday>>(),
        );
      });
    });
  });
  group('Month:', () {
    group('Throw on factory outside of range:', () {
      test('Value below 1', () {
        expect(() => Month.fromDateTime(0), throwsRangeError);
      });
      test('Value above 12', () {
        expect(() => Month.fromDateTime(13), throwsRangeError);
      });
    });
    group('Previous:', () {
      for (final month in Month.values) {
        test(month.name, () {
          if (month != Month.january) {
            expect(
              month.previous,
              equals(Month.fromDateTime(month.dateTimeValue - 1)),
            );
          } else {
            expect(month.previous, equals(Month.december));
          }
        });
      }
    });
    group('Next:', () {
      for (final month in Month.values) {
        test(month.name, () {
          if (month != Month.december) {
            expect(
              month.next,
              equals(Month.fromDateTime(month.dateTimeValue + 1)),
            );
          } else {
            expect(month.next, equals(Month.january));
          }
        });
      }
    });
    test('July of 2022', () {
      const year = 2022;
      const month = Month.july;

      final matcher = DateTime.utc(year, DateTime.july);
      expect(month.of(year), equals(matcher));
    });
    test('Last day at July of 2022', () {
      const year = 2022;
      const month = Month.july;

      final matcher = DateTime.utc(year, DateTime.july, 31);
      expect(month.lastDayOfAt(year), equals(matcher));
    });
  });
  group('Week', () {
    group('First', () {
      const first = Week.first;
      test('Starts six days before the first day of the month', () {
        expect(
          first.weekOf(2023, Month.january.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.december, 26)),
        );
        expect(
          first.weekOf(2023, Month.january.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.january, -5)),
        );
      });
      test('Starts five days before the first day of the month', () {
        expect(
          first.weekOf(2023, Month.april.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.march, 27)),
        );
        expect(
          first.weekOf(2023, Month.april.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.april, -4)),
        );
      });
      test('Starts four days before the first day of the month', () {
        expect(
          first.weekOf(2022, Month.july.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.june, 27)),
        );
        expect(
          first.weekOf(2022, Month.july.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.july, -3)),
        );
      });
      test('Starts three days before the first day of the month', () {
        expect(
          first.weekOf(2022, Month.september.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.august, 29)),
        );
        expect(
          first.weekOf(2022, Month.september.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.september, -2)),
        );
      });
      test('Starts at the previous month\'s second to last day', () {
        expect(
          first.weekOf(2022, Month.june.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.may, 30)),
        );
        expect(
          first.weekOf(2022, Month.june.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.june, -1)),
        );
      });
      test('Starts at the previous month\'s last day', () {
        expect(
          first.weekOf(2022, Month.march.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.february, 28)),
        );
        expect(
          first.weekOf(2022, Month.march.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.march, 0)),
        );
      });
      test('Starts at the actual first day of the month', () {
        expect(
          first.weekOf(2022, Month.august.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.august)),
        );
      });
    });
    group('Second', () {
      const second = Week.second;
      test('Starts at the 2nd day of the month', () {
        expect(
          second.weekOf(2023, Month.january.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.january, 2)),
        );
      });
      test('Starts at the 3rd day of the month', () {
        expect(
          second.weekOf(2023, Month.april.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.april, 3)),
        );
      });
      test('Starts at the 4th day of the month', () {
        expect(
          second.weekOf(2022, Month.july.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.july, 4)),
        );
      });
      test('Starts at the 5th day of the month', () {
        expect(
          second.weekOf(2022, Month.september.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.september, 5)),
        );
      });
      test('Starts at the 6th day of the month', () {
        expect(
          second.weekOf(2022, Month.june.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.june, 6)),
        );
      });
      test('Starts at the 7th day of the month', () {
        expect(
          second.weekOf(2022, Month.march.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.march, 7)),
        );
      });
      test('Starts at the 8th day of the month', () {
        expect(
          second.weekOf(2022, Month.august.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.august, 8)),
        );
      });
    });
    group('Third', () {
      const third = Week.third;
      test('Starts at the 9th day of the month', () {
        expect(
          third.weekOf(2023, Month.january.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.january, 9)),
        );
      });
      test('Starts at the 10th day of the month', () {
        expect(
          third.weekOf(2023, Month.april.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.april, 10)),
        );
      });
      test('Starts at the 11th day of the month', () {
        expect(
          third.weekOf(2022, Month.july.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.july, 11)),
        );
      });
      test('Starts at the 12th day of the month', () {
        expect(
          third.weekOf(2022, Month.september.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.september, 12)),
        );
      });
      test('Starts at the 13th day of the month', () {
        expect(
          third.weekOf(2022, Month.june.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.june, 13)),
        );
      });
      test('Starts at the 14th day of the month', () {
        expect(
          third.weekOf(2022, Month.march.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.march, 14)),
        );
      });
      test('Starts at the 15th day of the month', () {
        expect(
          third.weekOf(2022, Month.august.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.august, 15)),
        );
      });
    });
    group('Third', () {
      const fourth = Week.fourth;
      test('Starts at the 16th day of the month', () {
        expect(
          fourth.weekOf(2023, Month.january.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.january, 16)),
        );
      });
      test('Starts at the 17th day of the month', () {
        expect(
          fourth.weekOf(2023, Month.april.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.april, 17)),
        );
      });
      test('Starts at the 18th day of the month', () {
        expect(
          fourth.weekOf(2022, Month.july.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.july, 18)),
        );
      });
      test('Starts at the 19th day of the month', () {
        expect(
          fourth.weekOf(2022, Month.september.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.september, 19)),
        );
      });
      test('Starts at the 20th day of the month', () {
        expect(
          fourth.weekOf(2022, Month.june.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.june, 20)),
        );
      });
      test('Starts at the 21st day of the month', () {
        expect(
          fourth.weekOf(2022, Month.march.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.march, 21)),
        );
      });
      test('Starts at the 22nd day of the month', () {
        expect(
          fourth.weekOf(2022, Month.august.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.august, 22)),
        );
      });
    });
    group('Last', () {
      const last = Week.last;
      test('Starts at the 23th day of the month', () {
        expect(
          last.weekOf(2025, Month.february.dateTimeValue),
          equals(DateTime.utc(2025, DateTime.february, 23)),
        );
      });
      test('Starts at the 24th day of the month', () {
        expect(
          last.weekOf(2025, Month.february.dateTimeValue),
          equals(DateTime.utc(2025, DateTime.february, 24)),
        );
      });
      test('Starts at the 25th day of the month', () {
        expect(
          last.weekOf(2019, Month.february.dateTimeValue),
          equals(DateTime.utc(2019, DateTime.february, 25)),
        );
      });
      test('Starts at the 26th day of the month', () {
        expect(
          last.weekOf(2024, Month.february.dateTimeValue),
          equals(DateTime.utc(2024, DateTime.february, 26)),
        );
      });
      test('Starts at the 27th day of the month', () {
        expect(
          last.weekOf(2023, Month.february.dateTimeValue),
          equals(DateTime.utc(2023, DateTime.february, 27)),
        );
      });
      test('Starts at the 28th day of the month', () {
        expect(
          last.weekOf(2022, Month.february.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.february, 28)),
        );
      });
      test('Starts at the 29th day of the month', () {
        expect(
          last.weekOf(2022, Month.august.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.august, 29)),
        );
      });
      test('Starts at the 30th day of the month', () {
        expect(
          last.weekOf(2022, Month.may.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.may, 30)),
        );
      });
      test('Starts at the 31st day of the month', () {
        expect(
          last.weekOf(2022, Month.october.dateTimeValue),
          equals(DateTime.utc(2022, DateTime.october, 31)),
        );
      });
    });
  });
}
