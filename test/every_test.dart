import 'package:due_date/due_date.dart';
import 'package:test/test.dart';

void main() {
  group('EveryWeekday:', () {
    final august12th2022 = DateTime(2022, DateTime.august, 12);
    final august12th2022Utc = DateTime.utc(2022, DateTime.august, 12);

    group('Test base methods logic', () {
      group('startDate', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        test('If the given date would be generated, return it', () {
          expect(
            Weekday.saturday.every.startDate(august13th),
            equals(august13th),
          );
        });
        test('If the given date would not be generated, use next', () {
          expect(
            Weekday.saturday.every.startDate(august12th2022),
            equals(Weekday.saturday.every.next(august12th2022)),
          );
        });
      });
      group('next', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        final august20th = DateTime(2022, DateTime.august, 20);
        test(
          'If the given date would be generated, generate a new one anyway',
          () {
            expect(
              Weekday.saturday.every.next(august13th),
              equals(august20th),
            );
          },
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () {
            expect(
              Weekday.saturday.every.next(august12th2022),
              equals(august13th),
            );
          },
        );
      });
      group('previous', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        final august6th = DateTime(2022, DateTime.august, 6);
        test(
          'If the given date would be generated, generate a new one anyway',
          () {
            expect(
              Weekday.saturday.every.previous(august13th),
              equals(august6th),
            );
          },
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () {
            expect(
              Weekday.saturday.every.previous(august12th2022),
              equals(august6th),
            );
          },
        );
      });
    });

    group('Every Saturday', () {
      const everySaturday = EveryWeekday(Weekday.saturday);
      group('Local', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        test('This saturday', () {
          expect(everySaturday.startDate(august12th2022), equals(august13th));
        });
        test('Previous Saturday', () {
          final previousSaturday = DateTime(2022, DateTime.august, 6);
          expect(
            everySaturday.addWeeks(august13th, -1),
            equals(previousSaturday),
          );
        });
        test('Next Saturday', () {
          final nextSaturday = DateTime(2022, DateTime.august, 20);
          expect(
            everySaturday.addWeeks(august13th, 1),
            equals(nextSaturday),
          );
        });
      });
      group('UTC', () {
        final thisSaturdayUtc = DateTime.utc(2022, DateTime.august, 13);
        test('This saturday', () {
          expect(
            everySaturday.startDate(august12th2022Utc),
            equals(thisSaturdayUtc),
          );
        });
        test('Previous Saturday', () {
          final previousSaturdayUtc = DateTime.utc(2022, DateTime.august, 6);
          expect(
            everySaturday.addWeeks(thisSaturdayUtc, -1),
            equals(previousSaturdayUtc),
          );
        });
        test('Next Saturday', () {
          final nextSaturdayUtc = DateTime.utc(2022, DateTime.august, 20);
          expect(
            everySaturday.addWeeks(thisSaturdayUtc, 1),
            equals(nextSaturdayUtc),
          );
        });
      });
    });
    group('Every Wednesday', () {
      const everyWednesday = EveryWeekday(Weekday.wednesday);
      test('Local', () {
        final wednesday = DateTime(2022, DateTime.august, 17);
        expect(everyWednesday.startDate(august12th2022), equals(wednesday));
      });
      test('UTC', () {
        final wednesdayUtc = DateTime.utc(2022, DateTime.august, 17);
        expect(
          everyWednesday.startDate(august12th2022Utc),
          equals(wednesdayUtc),
        );
      });
    });
  });
  group('EveryWeekdayCountInMonth:', () {
    final august12th2022 = DateTime(2022, DateTime.august, 12);
    final august12th2022Utc = DateTime.utc(2022, DateTime.august, 12);

    group('Test base methods logic', () {
      const every = EveryWeekdayCountInMonth(
        day: Weekday.saturday,
        week: Week.second,
      );
      group('startDate', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        test('If the given date would be generated, return it', () {
          expect(every.startDate(august13th), equals(august13th));
        });
        test('If the given date would not be generated, use next', () {
          expect(
            every.startDate(DateTime(2022, DateTime.august, 14)),
            equals(every.next(DateTime(2022, DateTime.august, 14))),
          );
        });
      });
      group('next', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        final september10th = DateTime(2022, DateTime.september, 10);
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(every.next(august13th), equals(september10th)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(every.next(august12th2022), equals(august13th)),
        );
      });
      group('previous', () {
        final august13th = DateTime(2022, DateTime.august, 13);
        final july9th = DateTime(2022, DateTime.july, 9);
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(every.previous(august13th), equals(july9th)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(every.previous(august12th2022), equals(july9th)),
        );
      });
    });

    group('First Monday', () {
      const firstMondayOfMonth = EveryWeekdayCountInMonth(
        week: Week.first,
        day: Weekday.monday,
      );
      group('Local', () {
        test('Day 1', () {
          final middleOfPreviousMonth = DateTime(2022, DateTime.july, 15);
          final matcher = DateTime(2022, DateTime.august);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonth),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonth, 0),
            equals(matcher),
          );
        });
        test('Day 2', () {
          final middleOfPreviousMonth = DateTime(2022, DateTime.december, 15);
          final matcher = DateTime(2023, DateTime.january, 2);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonth),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonth, 0),
            equals(matcher),
          );
        });
        test('Day 3', () {
          final middleOfPreviousMonth = DateTime(2022, DateTime.september, 15);
          final matcher = DateTime(2022, DateTime.october, 3);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonth),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonth, 0),
            equals(matcher),
          );
        });
        test('Day 4', () {
          final middleOfPreviousMonth = DateTime(2022, DateTime.june, 15);
          final matcher = DateTime(2022, DateTime.july, 4);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonth),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonth, 0),
            equals(matcher),
          );
        });
        test('Day 5', () {
          final matcher = DateTime(2022, DateTime.september, 5);
          expect(firstMondayOfMonth.startDate(august12th2022), equals(matcher));
          expect(
            firstMondayOfMonth.addMonths(august12th2022, 0),
            equals(matcher),
          );
        });
        test('Day 6', () {
          final middleOfPreviousMonth = DateTime(2023, DateTime.january, 15);
          final matcher = DateTime(2023, DateTime.february, 6);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonth),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonth, 0),
            equals(matcher),
          );
        });
        test('Day 7', () {
          final middleOfPreviousMonth = DateTime(2022, DateTime.october, 15);
          final matcher = DateTime(2022, DateTime.november, 7);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonth),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonth, 0),
            equals(matcher),
          );
        });
      });
      group('UTC', () {
        test('Day 1', () {
          final middleOfPreviousMonthUtc = DateTime.utc(
            2022,
            DateTime.july,
            15,
          );
          final matcher = DateTime.utc(2022, DateTime.august);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonthUtc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonthUtc, 0),
            equals(matcher),
          );
        });
        test('Day 2', () {
          final middleOfPreviousMonthUtc = DateTime.utc(
            2022,
            DateTime.december,
            15,
          );
          final matcher = DateTime.utc(2023, DateTime.january, 2);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonthUtc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonthUtc, 0),
            equals(matcher),
          );
        });
        test('Day 3', () {
          final middleOfPreviousMonthUtc = DateTime.utc(
            2022,
            DateTime.september,
            15,
          );
          final matcher = DateTime.utc(2022, DateTime.october, 3);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonthUtc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonthUtc, 0),
            equals(matcher),
          );
        });
        test('Day 4', () {
          final middleOfPreviousMonthUtc = DateTime.utc(
            2022,
            DateTime.june,
            15,
          );
          final matcher = DateTime.utc(2022, DateTime.july, 4);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonthUtc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonthUtc, 0),
            equals(matcher),
          );
        });
        test('Day 5', () {
          final matcher = DateTime.utc(2022, DateTime.september, 5);
          expect(
            firstMondayOfMonth.startDate(august12th2022Utc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(august12th2022Utc, 0),
            equals(matcher),
          );
        });
        test('Day 6', () {
          final middleOfPreviousMonthUtc = DateTime.utc(
            2023,
            DateTime.january,
            15,
          );
          final matcher = DateTime.utc(2023, DateTime.february, 6);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonthUtc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonthUtc, 0),
            equals(matcher),
          );
        });
        test('Day 7', () {
          final middleOfPreviousMonthUtc = DateTime.utc(
            2022,
            DateTime.october,
            15,
          );
          final matcher = DateTime.utc(2022, DateTime.november, 7);
          expect(
            firstMondayOfMonth.startDate(middleOfPreviousMonthUtc),
            equals(matcher),
          );
          expect(
            firstMondayOfMonth.addMonths(middleOfPreviousMonthUtc, 0),
            equals(matcher),
          );
        });
      });
    });
    group('Last wednesday', () {
      const lastWednesdayOfMonth = EveryWeekdayCountInMonth(
        week: Week.last,
        day: Weekday.wednesday,
      );
      group('Local', () {
        final middleOfMonth = DateTime(2024, DateTime.february, 15);
        test('Subtract months so is March', () {
          final matcher = DateTime(2023, DateTime.march, 29);
          expect(
            lastWednesdayOfMonth.addMonths(middleOfMonth, -11),
            equals(matcher),
          );
        });
        test('Add months so is March in leap year', () {
          final matcher = DateTime(2024, DateTime.march, 27);
          expect(
            lastWednesdayOfMonth.addMonths(middleOfMonth, 1),
            equals(matcher),
          );
        });
      });
      group('UTC', () {
        final middleOfMonthUtc = DateTime.utc(2024, DateTime.february, 15);
        test('Subtract months so is March', () {
          final matcher = DateTime.utc(2023, DateTime.march, 29);
          expect(
            lastWednesdayOfMonth.addMonths(middleOfMonthUtc, -11),
            equals(matcher),
          );
        });
        test('Add months so is March in leap year', () {
          final matcher = DateTime.utc(2024, DateTime.march, 27);
          expect(
            lastWednesdayOfMonth.addMonths(middleOfMonthUtc, 1),
            equals(matcher),
          );
        });
      });
    });
  });
  group('EveryDueDayMonth:', () {
    group('Test base methods logic', () {
      const every = EveryDueDayMonth(15);
      group('startDate', () {
        final august15th = DateTime(2022, DateTime.august, 15);
        test('If the given date would be generated, return it', () {
          expect(every.startDate(august15th), equals(august15th));
        });
        test('If the given date would not be generated, use next', () {
          expect(
            every.startDate(DateTime(2022, DateTime.august, 14)),
            equals(every.next(DateTime(2022, DateTime.august, 14))),
          );
        });
      });
      group('next', () {
        final august15th = DateTime(2022, DateTime.august, 15);
        final september15th = DateTime(2022, DateTime.september, 15);
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(every.next(august15th), equals(september15th)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(
            every.next(DateTime(2022, DateTime.august, 14)),
            equals(august15th),
          ),
        );
      });
      group('previous', () {
        final august15th = DateTime(2022, DateTime.august, 15);
        final july15th = DateTime(2022, DateTime.july, 15);
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(every.previous(august15th), equals(july15th)),
        );
        test(
          'If the given date would not be generated, generate the previous '
          'valid date',
          () => expect(
            every.previous(DateTime(2022, DateTime.august, 16)),
            equals(august15th),
          ),
        );
      });
    });

    group('Every day 31', () {
      const everyDay31 = EveryDueDayMonth(31);
      group('Local', () {
        test('Month ending in 31', () {
          final august12th2022 = DateTime(2022, DateTime.august, 12);
          final matcher = DateTime(2022, DateTime.august, 31);
          expect(everyDay31.startDate(august12th2022), equals(matcher));
        });
        test('Month ending in 30', () {
          final endOfAugust = DateTime(2022, DateTime.august, 31);
          final matcher = DateTime(2022, DateTime.september, 30);
          expect(everyDay31.addMonths(endOfAugust, 1), equals(matcher));
        });
        test('Month ending in 29', () {
          final previousMonth = DateTime(2024, DateTime.january, 31);
          final matcher = DateTime(2024, DateTime.february, 29);
          expect(everyDay31.addMonths(previousMonth, 1), equals(matcher));
        });
        test('Month ending in 28', () {
          final previousMonth = DateTime(2022, DateTime.january, 31);
          final nextMonth = DateTime(2022, DateTime.march, 31);
          final matcher = DateTime(2022, DateTime.february, 28);
          expect(everyDay31.addMonths(previousMonth, 1), equals(matcher));
          expect(everyDay31.addMonths(nextMonth, -1), equals(matcher));
        });
      });
      group('UTC', () {
        test('Month ending in 31', () {
          final august12th2022Utc = DateTime.utc(2022, DateTime.august, 12);
          final matcher = DateTime.utc(2022, DateTime.august, 31);
          expect(everyDay31.startDate(august12th2022Utc), equals(matcher));
        });
        test('Month ending in 30', () {
          final endOfAugustUtc = DateTime.utc(2022, DateTime.august, 31);
          final matcher = DateTime.utc(2022, DateTime.september, 30);
          expect(everyDay31.addMonths(endOfAugustUtc, 1), equals(matcher));
        });
        test('Month ending in 29', () {
          final previousMonthUtc = DateTime.utc(2024, DateTime.january, 31);
          final matcher = DateTime.utc(2024, DateTime.february, 29);
          expect(everyDay31.addMonths(previousMonthUtc, 1), equals(matcher));
        });
        test('Month ending in 28', () {
          final previousMonthUtc = DateTime.utc(2022, DateTime.january, 31);
          final nextMonthUtc = DateTime.utc(2022, DateTime.march, 31);
          final matcher = DateTime.utc(2022, DateTime.february, 28);
          expect(everyDay31.addMonths(previousMonthUtc, 1), equals(matcher));
          expect(everyDay31.addMonths(nextMonthUtc, -1), equals(matcher));
        });
      });
    });
    group('Every day 15', () {
      const everyDay15 = EveryDueDayMonth(15);
      test('Local', () {
        final august12th2022 = DateTime(2022, DateTime.august, 12);
        final matcher = DateTime(2022, DateTime.august, 15);
        expect(everyDay15.startDate(august12th2022), equals(matcher));
      });
      test('UTC', () {
        final august12th2022Utc = DateTime.utc(2022, DateTime.august, 12);
        final matcher = DateTime.utc(2022, DateTime.august, 15);
        expect(everyDay15.startDate(august12th2022Utc), equals(matcher));
      });
    });
  });
  group('EveryDayInYear:', () {
    final august12th2022 = DateTime(2022, DateTime.august, 12);
    final august12th2022Utc = DateTime.utc(2022, DateTime.august, 12);

    group('Test base methods logic', () {
      const every = EveryDayInYear(15);
      group('startDate', () {
        final january15th = DateTime(2022, DateTime.january, 15);
        test('If the given date would be generated, return it', () {
          expect(
            every.startDate(january15th),
            equals(january15th),
          );
        });
        test('If the given date would not be generated, use next', () {
          expect(
            every.startDate(DateTime(2022, DateTime.january, 14)),
            equals(every.next(DateTime(2022, DateTime.january, 14))),
          );
        });
      });
      group('next', () {
        final january15th2022 = DateTime(2022, DateTime.january, 15);
        final january15th2023 = DateTime(2023, DateTime.january, 15);
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(every.next(january15th2022), equals(january15th2023)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(
            every.next(DateTime(2022, DateTime.january, 14)),
            equals(january15th2022),
          ),
        );
      });
      group('previous', () {
        final january15th2022 = DateTime(2022, DateTime.january, 15);
        final january15th2021 = DateTime(2021, DateTime.january, 15);

        test(
          'If the given date would be generated, generate a new one anyway',
          () =>
              expect(every.previous(january15th2022), equals(january15th2021)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(
            every.previous(DateTime(2022, DateTime.january, 14)),
            equals(january15th2021),
          ),
        );
      });
    });

    group('Every Day 1', () {
      const everyDay1 = EveryDayInYear(1);
      group('Local', () {
        final nextYearsDayOne = DateTime(2023);
        test('Next Year', () {
          expect(everyDay1.startDate(august12th2022), equals(nextYearsDayOne));
        });
        test('Previous Year', () {
          final previousYearsDay1 = DateTime(2022);
          expect(
            everyDay1.addYears(august12th2022, -1),
            equals(previousYearsDay1),
          );
        });
        test('Next Two Years', () {
          final twoYearsDay1 = DateTime(2024);
          expect(
            everyDay1.addYears(nextYearsDayOne, 1),
            equals(twoYearsDay1),
          );
        });
      });
      group('UTC', () {
        final nextYearsDayOneUtc = DateTime.utc(2023);
        test('Next Year', () {
          expect(
            everyDay1.startDate(august12th2022Utc),
            equals(nextYearsDayOneUtc),
          );
        });
        test('Previous Year', () {
          final previousYearsDay1Utc = DateTime.utc(2022);
          expect(
            everyDay1.addYears(august12th2022Utc, -1),
            equals(previousYearsDay1Utc),
          );
        });
        test('Next Two Years', () {
          final twoYearsDay1Utc = DateTime.utc(2024);
          expect(
            everyDay1.addYears(nextYearsDayOneUtc, 1),
            equals(twoYearsDay1Utc),
          );
        });
      });
    });
    group("Every Programmer's Day", () {
      const programmersDay = EveryDayInYear(256);
      group('Local', () {
        test('This year', () {
          final programmersDay2022 = DateTime(2022, DateTime.september, 13);
          expect(
            programmersDay.startDate(august12th2022),
            equals(programmersDay2022),
          );
        });
        test('Next year', () {
          final programmersDay2022 = DateTime(2022, DateTime.september, 13);
          final programmersDay2023 = DateTime(2023, DateTime.september, 13);
          expect(
            programmersDay.addYears(august12th2022, 1),
            equals(programmersDay2023),
          );
          expect(
            programmersDay.addYears(programmersDay2022, 1),
            equals(programmersDay2023),
          );
        });
        test('Previous year', () {
          final programmersDay2021 = DateTime(2021, DateTime.september, 13);
          expect(
            programmersDay.addYears(august12th2022, -1),
            equals(programmersDay2021),
          );
        });
        test('Leap year', () {
          final programmersDay2024 = DateTime(2024, DateTime.september, 12);
          expect(
            programmersDay.addYears(august12th2022, 2),
            equals(programmersDay2024),
          );
        });
      });
      group('UTC', () {
        test('This year', () {
          final programmersDay2022Utc = DateTime.utc(
            2022,
            DateTime.september,
            13,
          );
          expect(
            programmersDay.startDate(august12th2022Utc),
            equals(programmersDay2022Utc),
          );
        });
        test('Next year', () {
          final programmersDay2022Utc = DateTime.utc(
            2022,
            DateTime.september,
            13,
          );
          final programmersDay2023Utc = DateTime.utc(
            2023,
            DateTime.september,
            13,
          );
          expect(
            programmersDay.addYears(august12th2022Utc, 1),
            equals(programmersDay2023Utc),
          );
          expect(
            programmersDay.addYears(programmersDay2022Utc, 1),
            equals(programmersDay2023Utc),
          );
        });
        test('Previous year', () {
          final programmersDay2021Utc = DateTime.utc(
            2021,
            DateTime.september,
            13,
          );
          expect(
            programmersDay.addYears(august12th2022Utc, -1),
            equals(programmersDay2021Utc),
          );
        });
        test('Leap year', () {
          final programmersDay2024Utc = DateTime.utc(
            2024,
            DateTime.september,
            12,
          );
          expect(
            programmersDay.addYears(august12th2022Utc, 2),
            equals(programmersDay2024Utc),
          );
        });
      });
    });
    group('End of year', () {
      const endOfYear = EveryDayInYear(366);
      group('Local', () {
        test('This year', () {
          final endOf2022 = DateTime(2022, DateTime.december, 31);
          expect(
            endOfYear.startDate(august12th2022),
            equals(endOf2022),
          );
        });
        test('Leap year', () {
          final endOf2024 = DateTime(2024, DateTime.december, 31);
          expect(
            endOfYear.addYears(august12th2022, 2),
            equals(endOf2024),
          );
        });
      });
      group('UTC', () {
        test('This year', () {
          final endOf2022Utc = DateTime.utc(2022, DateTime.december, 31);
          expect(
            endOfYear.startDate(august12th2022Utc),
            equals(endOf2022Utc),
          );
        });
        test('Leap year', () {
          final endOf2024Utc = DateTime.utc(2024, DateTime.december, 31);
          expect(
            endOfYear.addYears(august12th2022Utc, 2),
            equals(endOf2024Utc),
          );
        });
      });
    });
  });
  group('EveryDateValidatorIntersection', () {
    const everies = EveryDateValidatorIntersection([
      EveryDueDayMonth(24),
      EveryDateValidatorDifference([EveryWeekday(Weekday.saturday)]),
    ]);

    group('Test base methods logic', () {
      final date = DateTime(2021, DateTime.july, 25);
      final expected = DateTime(2022, DateTime.september, 24);
      group('startDate', () {
        test('If the given date would be generated, return it', () {
          expect(
            everies.startDate(expected),
            equals(expected),
          );
        });
        test('If the given date would not be generated, use next', () {
          expect(
            everies.startDate(date),
            equals(everies.next(date)),
          );
        });
      });
      group('next', () {
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(
            everies.next(expected),
            equals(DateTime(2022, DateTime.december, 24)),
          ),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(everies.next(date), equals(expected)),
        );
      });
      group('previous', () {
        final expectedPrevious = DateTime(2021, DateTime.july, 24);

        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(
            everies.previous(expected),
            equals(expectedPrevious),
          ),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(everies.previous(date), equals(expectedPrevious)),
        );
      });
    });

    group('Start Date', () {
      test('September 24th 2022', () {
        final date = DateTime(2021, DateTime.july, 25);
        final expected = DateTime(2022, DateTime.september, 24);
        expect(everies.startDate(date), equals(expected));
      });
      test('July 24th 2021', () {
        final date = DateTime(2021, DateTime.july, 23);
        final expected = DateTime(2021, DateTime.july, 24);
        expect(everies.startDate(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2021, DateTime.july, 22);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2021, DateTime.july, 23);
          expect(
            () => everies.startDate(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2021, DateTime.july, 23);
        final expected = DateTime(2021, DateTime.july, 24);

        expect(everies.startDate(date, limit: expected), equals(expected));
      });
    });
    group('Next', () {
      test('September 24th 2022', () {
        final date = DateTime(2021, DateTime.july, 25);
        final expected = DateTime(2022, DateTime.september, 24);
        expect(everies.next(date), equals(expected));
      });
      test('July 24th 2021', () {
        final date = DateTime(2021, DateTime.july, 23);
        final expected = DateTime(2021, DateTime.july, 24);
        expect(everies.next(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2021, DateTime.july, 22);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2021, DateTime.july, 23);
          expect(
            () => everies.next(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2021, DateTime.july, 23);
        final expected = DateTime(2021, DateTime.july, 24);

        expect(everies.next(date, limit: expected), equals(expected));
      });
    });
    group('Previous', () {
      test('July 24th 2021', () {
        final date = DateTime(2022, DateTime.september, 24);
        final expected = DateTime(2021, DateTime.july, 24);
        expect(everies.previous(date), equals(expected));
      });
      test('September 24th 2022', () {
        final date = DateTime(2022, DateTime.september, 25);
        final expected = DateTime(2022, DateTime.september, 24);
        expect(everies.previous(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2022, DateTime.september, 26);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2022, DateTime.september, 25);
          expect(
            () => everies.previous(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2021, DateTime.september, 26);
        final expected = DateTime(2021, DateTime.july, 24);

        expect(everies.previous(date, limit: expected), equals(expected));
      });
    });
  });
  group('DateValidatorUnion', () {
    const everies = EveryDateValidatorUnion([
      EveryDueDayMonth(24),
      EveryDateValidatorDifference([EveryWeekday(Weekday.saturday)]),
    ]);

    group('Test base methods logic', () {
      final date = DateTime(2022, DateTime.september, 23);
      final expected = DateTime(2022, DateTime.september, 24);
      group('startDate', () {
        test('If the given date would be generated, return it', () {
          expect(
            everies.startDate(expected),
            equals(expected),
          );
        });
        test('If the given date would not be generated, use next', () {
          expect(
            everies.startDate(date),
            equals(everies.next(date)),
          );
        });
      });
      group('next', () {
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(
            everies.next(expected),
            equals(DateTime(2022, DateTime.october)),
          ),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(
            everies.next(DateTime(2022, DateTime.september, 17)),
            equals(expected),
          ),
        );
      });
      group('previous', () {
        final expectedPrevious = DateTime(2022, DateTime.september, 17);

        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(everies.previous(expected), equals(expectedPrevious)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(everies.previous(date), equals(expectedPrevious)),
        );
      });
    });

    group('Start Date', () {
      test('All valid', () {
        final date = DateTime(2022, DateTime.september, 23);
        final expected = DateTime(2022, DateTime.september, 24);
        expect(everies.startDate(date), equals(expected));
      });
      test('Wrong day', () {
        final date = DateTime(2022, DateTime.september, 16);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.startDate(date), equals(expected));
      });
      test('Wrong weekday', () {
        final date = DateTime(2022, DateTime.august, 23);
        final expected = DateTime(2022, DateTime.august, 24);
        expect(everies.startDate(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2021, DateTime.july, 22);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2021, DateTime.july, 23);
          expect(
            () => everies.startDate(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2021, DateTime.july, 23);
        final expected = DateTime(2021, DateTime.july, 24);

        expect(everies.startDate(date, limit: expected), equals(expected));
      });
    });
    group('Next', () {
      test('All valid', () {
        final date = DateTime(2022, DateTime.september, 17);
        final expected = DateTime(2022, DateTime.september, 24);
        expect(everies.next(date), equals(expected));
      });
      test('Wrong day', () {
        final date = DateTime(2022, DateTime.september, 16);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.next(date), equals(expected));
      });
      test('Wrong weekday', () {
        final date = DateTime(2022, DateTime.august, 23);
        final expected = DateTime(2022, DateTime.august, 24);
        expect(everies.next(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2021, DateTime.july, 22);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2021, DateTime.july, 23);
          expect(
            () => everies.next(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2021, DateTime.july, 23);
        final expected = DateTime(2021, DateTime.july, 24);

        expect(everies.next(date, limit: expected), equals(expected));
      });
    });
    group('Previous', () {
      test('All valid', () {
        final date = DateTime(2022, DateTime.september, 25);
        final expected = DateTime(2022, DateTime.september, 24);
        expect(everies.previous(date), equals(expected));
      });
      test('Wrong day', () {
        final date = DateTime(2022, DateTime.september, 24);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.previous(date), equals(expected));
      });
      test('Wrong weekday', () {
        final date = DateTime(2022, DateTime.august, 25);
        final expected = DateTime(2022, DateTime.august, 24);
        expect(everies.previous(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2022, DateTime.september, 26);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2022, DateTime.september, 25);
          expect(
            () => everies.previous(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2022, DateTime.september, 25);
        final expected = DateTime(2022, DateTime.september, 24);

        expect(everies.previous(date, limit: expected), equals(expected));
      });
    });
  });
  group('DateValidatorDifference', () {
    const everies = EveryDateValidatorDifference([
      EveryDueDayMonth(24),
      EveryDateValidatorIntersection([EveryWeekday(Weekday.saturday)]),
    ]);

    group('Test base methods logic', () {
      final date = DateTime(2022, DateTime.september, 23);
      final expected = DateTime(2022, DateTime.october);
      group('startDate', () {
        test('If the given date would be generated, return it', () {
          expect(
            everies.startDate(expected),
            equals(expected),
          );
        });
        test('If the given date would not be generated, use next', () {
          expect(
            everies.startDate(date),
            equals(everies.next(date)),
          );
        });
      });
      group('next', () {
        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(
            everies.next(expected),
            equals(DateTime(2022, DateTime.october, 8)),
          ),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(everies.next(date), equals(expected)),
        );
      });
      group('previous', () {
        final expectedPrevious = DateTime(2022, DateTime.september, 17);

        test(
          'If the given date would be generated, generate a new one anyway',
          () => expect(everies.previous(expected), equals(expectedPrevious)),
        );
        test(
          'If the given date would not be generated, generate the next valid '
          'date',
          () => expect(everies.previous(date), equals(expectedPrevious)),
        );
      });
    });

    group('Start Date', () {
      test('All valid', () {
        final date = DateTime(2022, DateTime.september, 24);
        final expected = DateTime(2022, DateTime.october);
        expect(everies.startDate(date), equals(expected));
      });
      test('Wrong day', () {
        final date = DateTime(2022, DateTime.september, 16);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.startDate(date), equals(expected));
      });
      test('Wrong weekday', () {
        final date = DateTime(2022, DateTime.august, 23);
        final expected = DateTime(2022, DateTime.august, 24);
        expect(everies.startDate(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2022, DateTime.september, 24);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2022, DateTime.september, 25);
          expect(
            () => everies.startDate(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2022, DateTime.september, 24);
        final expected = DateTime(2022, DateTime.october);

        expect(everies.startDate(date, limit: expected), equals(expected));
      });
    });
    group('Next', () {
      test('All valid', () {
        final date = DateTime(2022, DateTime.september, 24);
        final expected = DateTime(2022, DateTime.october);
        expect(everies.next(date), equals(expected));
      });
      test('Wrong day', () {
        final date = DateTime(2022, DateTime.september, 16);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.next(date), equals(expected));
      });
      test('Wrong weekday', () {
        final date = DateTime(2022, DateTime.august, 23);
        final expected = DateTime(2022, DateTime.august, 24);
        expect(everies.next(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2022, DateTime.september, 24);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2022, DateTime.september, 25);
          expect(
            () => everies.next(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2022, DateTime.september, 24);
        final expected = DateTime(2022, DateTime.october);

        expect(everies.next(date, limit: expected), equals(expected));
      });
    });
    group('Previous', () {
      test('All valid', () {
        final date = DateTime(2022, DateTime.september, 25);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.previous(date), equals(expected));
      });
      test('Wrong day', () {
        final date = DateTime(2022, DateTime.september, 18);
        final expected = DateTime(2022, DateTime.september, 17);
        expect(everies.previous(date), equals(expected));
      });
      test('Wrong weekday', () {
        final date = DateTime(2022, DateTime.august, 25);
        final expected = DateTime(2022, DateTime.august, 24);
        expect(everies.previous(date), equals(expected));
      });
      group('Throws DateTimeLimitReachedException', () {
        final date = DateTime(2022, DateTime.september, 26);
        final throwsDateTimeLimitReachedException = throwsA(
          isA<DateTimeLimitReachedException>(),
        );
        test('Inner every', () {
          final limit = DateTime(2022, DateTime.september, 25);
          expect(
            () => everies.previous(date, limit: limit),
            throwsDateTimeLimitReachedException,
          );
        });
      });
      test('The limit is the expected date', () {
        final date = DateTime(2022, DateTime.september, 26);
        final expected = DateTime(2022, DateTime.september, 17);

        expect(everies.previous(date, limit: expected), equals(expected));
      });
    });
  });
}
