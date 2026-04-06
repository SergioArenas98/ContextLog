/// All domain enums for ContextLog.
/// Each enum has a [displayName] extension for UI display.
library;

enum PhotoStage {
  preEx,
  midEx,
  workingShot,
  postEx;

  String get displayName => switch (this) {
        PhotoStage.preEx => 'Pre-excavation',
        PhotoStage.midEx => 'Mid-excavation',
        PhotoStage.workingShot => 'Working shot',
        PhotoStage.postEx => 'Post-excavation',
      };
}

enum CardinalOrientation {
  n,
  ne,
  e,
  se,
  s,
  sw,
  w,
  nw,
  unknown;

  String get displayName => switch (this) {
        CardinalOrientation.n => 'N',
        CardinalOrientation.ne => 'NE',
        CardinalOrientation.e => 'E',
        CardinalOrientation.se => 'SE',
        CardinalOrientation.s => 'S',
        CardinalOrientation.sw => 'SW',
        CardinalOrientation.w => 'W',
        CardinalOrientation.nw => 'NW',
        CardinalOrientation.unknown => 'Unknown',
      };
}

enum ContextType {
  cut,
  fill;

  String get displayName => switch (this) {
        ContextType.cut => 'Cut',
        ContextType.fill => 'Fill',
      };
}

enum CutType {
  stakehole,
  posthole,
  pit,
  kiln,
  ditch,
  linearFeature,
  hearth,
  other;

  String get displayName => switch (this) {
        CutType.stakehole => 'Stakehole',
        CutType.posthole => 'Posthole',
        CutType.pit => 'Pit',
        CutType.kiln => 'Kiln',
        CutType.ditch => 'Ditch',
        CutType.linearFeature => 'Linear feature',
        CutType.hearth => 'Hearth',
        CutType.other => 'Other',
      };
}

enum FindMaterialType {
  flint,
  stone,
  ceramic,
  metal,
  bone,
  shell,
  glass,
  other;

  String get displayName => switch (this) {
        FindMaterialType.flint => 'Flint',
        FindMaterialType.stone => 'Stone',
        FindMaterialType.ceramic => 'Ceramic',
        FindMaterialType.metal => 'Metal',
        FindMaterialType.bone => 'Bone',
        FindMaterialType.shell => 'Shell',
        FindMaterialType.glass => 'Glass',
        FindMaterialType.other => 'Other',
      };
}

enum SampleType {
  soil,
  soilCharcoal,
  bulk,
  pollen,
  other;

  String get displayName => switch (this) {
        SampleType.soil => 'Soil',
        SampleType.soilCharcoal => 'Soil + charcoal',
        SampleType.bulk => 'Bulk',
        SampleType.pollen => 'Pollen',
        SampleType.other => 'Other',
      };
}

enum StorageType {
  bucket,
  bag,
  jar,
  other;

  String get displayName => switch (this) {
        StorageType.bucket => 'Bucket',
        StorageType.bag => 'Bag',
        StorageType.jar => 'Jar',
        StorageType.other => 'Other',
      };
}

enum DrawingType {
  section,
  profile;

  String get displayName => switch (this) {
        DrawingType.section => 'Section',
        DrawingType.profile => 'Profile',
      };
}

enum HarrisRelationType {
  above,
  below,
  cuts,
  cutBy,
  equalTo,
  contemporaryWith;

  String get displayName => switch (this) {
        HarrisRelationType.above => 'Above',
        HarrisRelationType.below => 'Below',
        HarrisRelationType.cuts => 'Cuts',
        HarrisRelationType.cutBy => 'Cut by',
        HarrisRelationType.equalTo => 'Equal to',
        HarrisRelationType.contemporaryWith => 'Contemporary with',
      };
}
