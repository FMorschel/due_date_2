# Change Log

## 2.0.2 - 2023.12.13

- Simple test

## 2.0.1 - 2023.12.13

- Added more tests for [Every] to make it more robust.
- Added more tests for [EveryMonth.addMonths] to make it more robust.
- Resolved inconsistencies in [EveryMonth.addMonths].
- Added [LimitedOrEveryHandler] to handle [Every] and [Limited] in the same way.
- Added [DateDirection], and some implementations for the new [EveryModifier].

## 2.0.0 - 2023.03.28

- Added [DateValidator] and some implementations.
- Implemented [DateValidator] in all implementations of [Every].
- Created [Period] and some implementations.
- Created [PeriodGeneratorMixin] and some implementations.

### Breaking changes

- API changes to always use optional named parameters.
- API changes replacing optional positional parameters for optional named parameters.

## 1.0.4 - 2022.08.23

- Fixed typo on changelog.
- Updated dependency `time` to fix issues.

## 1.0.3 - 2022.08.23

- Fixed repository and issues pointing to wrong package.
- Fixed example README.

## 1.0.2 - 2022.08.23

- Renamed `isWorkDay` -> `isWorkday`. Since is the same day of release, I won't consider this a breaking change.

## 1.0.1 - 2022.08.23

- Fixed Dart Conventions, added more description to the `pubspec.yaml`.

## 1.0.0 - 2022.08.23

- Initial stable release.
