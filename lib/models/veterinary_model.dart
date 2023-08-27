import 'package:petcare_search/models/model_enums.dart';
import 'package:petcare_search/models/review_model.dart';
import 'package:petcare_search/repository/reviewRepository.dart';
import 'package:petcare_search/repository/vetRepository.dart';

class Veterinary {
  String name;
  String vetMail;
  String imagePath;
  VeterinarySpecialty specialty;
  //LatLng location;
  double latitude = 0;
  double longitude = 0;
  Clinic clinic;
  double price;
  int yearOfExperience;

  double avgRating = 2;
  String biography;
  String educationIntroduction;
  String professionalExperience;
  String personalInformation;
  List<Review> reviews = [];

  Veterinary(
      {required this.name,
      required this.vetMail,
      this.latitude = 0,
      this.longitude = 0,
      required this.imagePath,
      required this.specialty,
      this.clinic = const Clinic("Nowhere"),
      required this.price,
      this.yearOfExperience = 2,
      required this.biography,
      required this.educationIntroduction,
      required this.professionalExperience,
      this.personalInformation = "",
      this.reviews = const []});

  // To json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'vetMail': vetMail,
      'latitude': latitude,
      'longitude': longitude,
      'imagePath': imagePath,
      'specialty': EnumConverter.VeterinarySpecialtyToString(specialty),
      'clinic': clinic.toJson(),
      'price': price,
      'yearOfExperience': yearOfExperience,
      'biography': biography,
      'educationIntroduction': educationIntroduction,
      'professionalExperience': professionalExperience,
      'personalInformation': personalInformation,
    };
  }

  //Get reviews from database for this vet.
  Future<void> LoadReview() async {
    //Todo:: Implement load
    reviews = await ReviewRepository.GetAllReviewsOfVet(vetMail);
  }
  //Update vet on db
  Future<void> UpdateOnDB() async {
    await VeterinaryRepository.UpdateVet(this);
  }
  //Set location
  void SetLocation(double lat, double long) {
    latitude = lat;
    longitude = long;
  }
  //From json.
  factory Veterinary.fromJson(Map<String, dynamic> json) {
    return Veterinary(
      name: json.containsKey('name') ? json['name'] as String : "",
      latitude: json.containsKey('latitude') ? json['latitude'] as double : 0,
      longitude:
          json.containsKey('longitude') ? json['longitude'] as double : 0,
      vetMail: json.containsKey('vetMail') ? json['vetMail'] as String : "",
      imagePath:
          json.containsKey('imagePath') ? json['imagePath'] as String : "",
      specialty: json.containsKey('specialty')
          ? EnumConverter.StringToVeterinarySpecialty(
              json['specialty'] as String)
          : VeterinarySpecialty.None,
      clinic: json.containsKey('clinic')
          ? Clinic.fromJson(json['clinic'] as Map<String, dynamic>)
          : const Clinic("Nowhere"),
      price: json.containsKey('price') ? json['price'] as double : 0,
      yearOfExperience: json.containsKey('yearOfExperience')
          ? json['yearOfExperience'] as int
          : 0,
      biography:
          json.containsKey('biography') ? json['biography'] as String : "",
      educationIntroduction: json.containsKey('educationIntroduction')
          ? json['educationIntroduction'] as String
          : "",
      professionalExperience: json.containsKey('professionalExperience')
          ? json['professionalExperience'] as String
          : "",
      personalInformation: json.containsKey('personalInformation')
          ? json['personalInformation'] as String
          : "",
    );
  }
}

class Clinic {
  final String name;
  // Add a Location property if needed
  // Location location;

  const Clinic(this.name);

  // To json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  //From json.
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      json.containsKey('name') ? json['name'] as String : "",
    );
  }
}
