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

//String to gender 
Gender StringToGender(String gd)
{
  switch (gd)
  {
    case "male":
      return Gender.male;
    case "female":
      return Gender.female;
    default:
      return Gender.other;
    
  }
}