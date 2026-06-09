import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/constants/enums.dart';
import 'package:context_log/core/database/converters/enum_converters.dart';

void main() {
  group('SampleTypeConverter', () {
    const converter = SampleTypeConverter();

    test('round-trips current values', () {
      for (final type in SampleType.values) {
        expect(converter.fromSql(converter.toSql(type)), type);
      }
    });

    test('maps new bone values by name', () {
      expect(converter.toSql(SampleType.animalBone), 'animalBone');
      expect(converter.toSql(SampleType.humanBone), 'humanBone');
      expect(converter.fromSql('animalBone'), SampleType.animalBone);
      expect(converter.fromSql('humanBone'), SampleType.humanBone);
    });

    test('legacy removed values fall back to other instead of throwing', () {
      // Existing databases may still contain these strings until the v8
      // migration rewrites them — conversion must never crash.
      expect(converter.fromSql('bulk'), SampleType.other);
      expect(converter.fromSql('pollen'), SampleType.other);
    });

    test('unknown strings fall back to other', () {
      expect(converter.fromSql('something_unexpected'), SampleType.other);
    });
  });
}
