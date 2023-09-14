enum Gender {
  male,
  female,
  other,
}

parseGender(String value, Gender pz) {
  for (var name in Gender.values) {
    if (name.toString() == value) {
      pz = name;
    }
  }
  return pz;
}
