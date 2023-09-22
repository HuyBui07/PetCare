class VetArgs {
  final String nameVet, nameLocation;
  final double lat, long;
  final String personalInf;
  VetArgs(
      this.nameVet, this.nameLocation, this.lat, this.long, this.personalInf);

  String get vetNames => nameVet;
  String get vetBio => personalInf;
}
