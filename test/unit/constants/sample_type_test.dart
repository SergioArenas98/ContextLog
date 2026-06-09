import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/constants/enums.dart';

void main() {
  group('SampleType', () {
    test('exposes exactly the supported field options in order', () {
      expect(SampleType.values, [
        SampleType.soil,
        SampleType.soilCharcoal,
        SampleType.animalBone,
        SampleType.humanBone,
        SampleType.other,
      ]);
    });

    test('display names match the field options', () {
      expect(SampleType.soil.displayName, 'Soil');
      expect(SampleType.soilCharcoal.displayName, 'Soil + charcoal');
      expect(SampleType.animalBone.displayName, 'Animal bone');
      expect(SampleType.humanBone.displayName, 'Human bone');
      expect(SampleType.other.displayName, 'Other');
    });

    test('removed values are no longer selectable', () {
      final names = SampleType.values.map((e) => e.name).toList();
      expect(names, isNot(contains('bulk')));
      expect(names, isNot(contains('pollen')));
    });
  });
}
