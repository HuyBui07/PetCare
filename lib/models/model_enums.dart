
enum PetSize { small, medium, large }


enum VeterinarySpecialty
{
  CatSpecialist,
  DogSpecialist,
  Ornithologist,
  Dentist,
  Surgeon,
  Veterinarian,
  Therapist,
  Anethetist,
  Gastroenterologist,
  InfectiousDiseaseSpecialist,
  Cardiologist,
  Neurologist,
  Oncologist,
  Orthopedist,
  Ophthalmologist,
  Radiologist,
  Traumatologist,
  None,
}


class EnumConverter
{
  static VeterinarySpecialty StringToVeterinarySpecialty(String specialty)
  {
    
    switch(specialty)
    {
      case "CatSpecialist":
        return VeterinarySpecialty.CatSpecialist;
      case "DogSpecialist":
        return VeterinarySpecialty.DogSpecialist;
      case "Ornithologist":
        return VeterinarySpecialty.Ornithologist;
      case "Dentist":
        return VeterinarySpecialty.Dentist;
      case "Surgeon":
        return VeterinarySpecialty.Surgeon;
      case "Veterinarian":
        return VeterinarySpecialty.Veterinarian;
      case "Therapist":
        return VeterinarySpecialty.Therapist;
      case "Anethetist":
        return VeterinarySpecialty.Anethetist;
      case "Gastroenterologist":
        return VeterinarySpecialty.Gastroenterologist;
      case "InfectiousDiseaseSpecialist":
        return VeterinarySpecialty.InfectiousDiseaseSpecialist;
      case "Cardiologist":
        return VeterinarySpecialty.Cardiologist;
      case "Neurologist":
        return VeterinarySpecialty.Neurologist;
      case "Oncologist":
        return VeterinarySpecialty.Oncologist;
      case "Orthopedist":
        return VeterinarySpecialty.Orthopedist;
      case "Ophthalmologist":
        return VeterinarySpecialty.Ophthalmologist;
      case "Radiologist":
        return VeterinarySpecialty.Radiologist;
      case "Traumatologist":
        return VeterinarySpecialty.Traumatologist;
      //case with VeternarySpecialty.Name
      // Example: 
      //case "VeterinarySpecialty.CatSpecialist":
      //   return VeterinarySpecialty.CatSpecialist;
      
      

     

      default:
        return VeterinarySpecialty.None;
    }
  }
  static StringToPetSize (String size)
  {
    switch(size)
    {
      case "small":
        return PetSize.small;
      case "medium":
        return PetSize.medium;
      case "large":
        return PetSize.large;
      default:
        return PetSize.small;
    }
  }
  static String PetSizeToString (PetSize size)
  {
    return size.toString().split('.').last;
  }
  static String VeterinarySpecialtyToString (VeterinarySpecialty spl)
  {
    return spl.toString().split('.').last;
  }
  
  
  
}