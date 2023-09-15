enum PetSize {
  xsmall,
  small,
  medium,
  large,
  xlarge,
  other,
}

List<Map<String, PetSize>> sizes = [
  {'xSmall': PetSize.xsmall},
  {'Small': PetSize.small},
  {'Medium': PetSize.medium},
  {'Large': PetSize.large},
  {'xLarge': PetSize.xlarge},
];
Map<String, PetSize> sizesMap = {
  'xSmall': PetSize.xsmall,
  'Small': PetSize.small,
  'Medium': PetSize.medium,
  'Large': PetSize.large,
  'xLarge': PetSize.xlarge
};
parseSize(String value, PetSize pz) {
  for (var name in PetSize.values) {
    if (name.toString() == value) {
      pz = name;
    }
  }
  return pz;
}
