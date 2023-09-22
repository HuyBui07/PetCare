class VetArgs {
  final String nameVet, nameLocation;
  final double lat, long;
  VetArgs(this.nameVet, this.nameLocation, this.lat, this.long);

  String get vetNames => nameVet;
}
