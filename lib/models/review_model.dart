import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/models/veterinary_model.dart';
import 'package:petcare_search/repository/reviewRepository.dart';
import 'package:petcare_search/repository/userRepository.dart';
import 'package:petcare_search/repository/vetRepository.dart';

class Review {
  String reviewedVetMail;
  String reviewerMail;
  int rating; //1-5
  String reviewDescription;
  DateTime reviewDate;
  bool isVerfied;
  String? reviewerName;
  String? vetName;
  UserModel? reviewer;
  Veterinary? reviewedVet;
  Review({
    this.reviewerName,
    this.vetName,
    required this.reviewedVetMail,
    required this.reviewerMail,
    required this.rating,
    required this.reviewDescription,
    required this.reviewDate,
    this.isVerfied = false,
  }) {
    if (rating < 1 )
    {
      rating = 1;
    }
    else if (rating > 5)
    {
      rating = 5;
    }
    else 
    {
      rating = rating;
    }
  }
  //Get user name from usrRef
  Future<UserModel> GetReviewer() async {
    //Todo:: implement security
    if (reviewer != null) {
      return reviewer!;
    }
    else
    {
      reviewer = await UserRepository.GetUserWithEmail(email:reviewerMail);
        return reviewer!;
    }
    
  }

  //Get reviewed vet name from reviewedVetRef
  Future<Veterinary> GetReviewedVet() async {
    //Todo:  implement security
    if (reviewedVet != null) {
      return reviewedVet!;
    }
    else
    {
      reviewedVet = await VeterinaryRepository.GetVeterinaryWithEmail(reviewedVetMail);
        return reviewedVet!;
    }
  }
  Future<void> Update () async
  {
     await ReviewRepository.UpdateReview(this);

  }
  Map<String, dynamic> toJson() {
    return {
      'reviewedVetMail': reviewedVetMail,
      'reviewerMail': reviewerMail,
      'rating': rating,
      'reviewDescription': reviewDescription,
      'reviewDate': reviewDate,
      'isVerfied': isVerfied,
    };
  }

  //Convert from json map to UserModel
  factory Review.fromJson(Map<String, dynamic> json) {
  Timestamp? timestamp = json.containsKey('reviewDate')
      ? json['reviewDate'] as Timestamp
      : null;

  return Review(
    reviewedVetMail: json.containsKey('reviewedVetMail')
        ? json['reviewedVetMail'] as String
        : "",
    reviewerMail: json.containsKey('reviewerMail')
        ? json['reviewerMail'] as String
        : "",
    reviewerName: json.containsKey('reviewerName')
        ? json['reviewerName'] as String
        : "",
    vetName: json.containsKey('vetName') ? json['vetName'] as String : "",
    rating: json.containsKey('rating') ? json['rating'] as int : 0,
    reviewDescription: json.containsKey('reviewDescription')
        ? json['reviewDescription'] as String
        : "",
    reviewDate: timestamp != null ? timestamp.toDate() : DateTime.now(),
    isVerfied:
        json.containsKey('isVerfied') ? json['isVerfied'] as bool : false,
  );
}
}
