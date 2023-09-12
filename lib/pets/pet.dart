import 'package:petcare_search/pets/size.dart';
import 'package:petcare_search/users/gender.dart';

class MyPet {
  String id;
  String imgPath;
  String name;
  String species;
  String breed;
  PetSize size;
  Gender gender;
  DateTime dob;
  bool isneutered;
  bool isvaccinated;
  bool isfwd;
  bool isfwc;
  bool isfwkl;
  bool isfwkm;
  bool ismicrochipped;
  bool ispurebred;
  String nursename;

  MyPet(
      this.id,
      this.imgPath,
      this.name,
      this.species,
      this.breed,
      this.size,
      this.gender,
      this.dob,
      this.isneutered,
      this.isvaccinated,
      this.isfwd,
      this.isfwc,
      this.isfwkl,
      this.isfwkm,
      this.ismicrochipped,
      this.ispurebred,
      this.nursename);
}
