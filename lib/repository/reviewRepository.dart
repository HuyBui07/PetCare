import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:petcare_search/models/review_model.dart';
import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/models/veterinary_model.dart';
import 'package:petcare_search/repository/userRepository.dart';
import 'package:petcare_search/repository/vetRepository.dart';

//A user can only add one review to a vet. It can be updated.
//This repos contains ways to:
//+Add review
//+Update review
//+Delete review
//+Get all reviews of a vet
//+Get all reviews of a user
//+Get a review of a vet by user
// Reviews ID is randomized. Accessing reviews is done using query. Can be slow if database grow large.
// ACCESSING REVIEW is done generally using user UID, email, and vet mail. Vet mail can be considered unique.
//
//Utility functions:
//+ Check if user has reviewed a certain vet using mail
//+ Get average rating of a vet
//+ Get number of reviews of a vet
//Path storage: Reviews/{VetMail}/{UserMail}/{Review}
//User and vet has ReviewPaths that point toward specific review related to them

// GENERALLY GUIDE:
// ADDING : Create a review -> Call repos to add it to database.
// UPDATING: Get current user review of vet -> Call update on it.
// REMOVAL : Get current user review of vet -> Call remove on it.

class ReviewRepository {
  static final ReviewRepository _instance = ReviewRepository._internal();
  factory ReviewRepository() => _instance;
  static final db = FirebaseFirestore.instance;
  ReviewRepository._internal() {
    // init things inside this
  }

//Add review to db
//Review ID is randomized on firestore.
  static Future<void> AddReview(
      UserModel? user, Veterinary? reviewedVet, Review review) async {
    //if either user or vet is null, return

    if (user == null || reviewedVet == null) {
      return Future.error("User or vet is null");
    }
    DocumentReference userRef =
        await UserRepository.GetUserRefWithUID(user.uid);
    DocumentReference vetRef =
        await VeterinaryRepository.GetVetReferenceWithEmail(
            reviewedVet.vetMail);
    //Snapshot user and vet doc to check if they exist
    DocumentSnapshot userSnap = await userRef.get();
    DocumentSnapshot vetSnap = await vetRef.get();
    //Check if user and vet exist, if not , return
    if (!userSnap.exists || !vetSnap.exists) {
      return Future.error("User or vet not found");
    }

    //Check if user has already reviewed this vet.
    if (await HasReviewBetween(user.uid, reviewedVet.vetMail)) //Exist
    {
      print(
          "[REVIEW REPOS] User has already reviewed this vet: Reviewer UID: ${user.uid} Reviewed vet: ${reviewedVet.vetMail}");
      return Future.error("User has already reviewed this vet");
    } else {
      try {
        //Add review to db
        await db.collection("Reviews").doc().set(review.toJson());
        print(
            "[REVIEW REPOS] Review path added to user and vet: Reviewer UID: ${user.uid} Reviewed vet: ${reviewedVet.vetMail}");
      } catch (e) {
        print(e);
      }
    }
    return Future.value(null);
  }

  //Update a review between user and vet
  Future<void> UpdateReviewBetween(
      String userUID, String vetMail, Review updatedReview) async {
    //Check if review exist
    if (await HasReviewBetween(userUID, vetMail)) {
      //Update review
      db
          .collection("Reviews")
          .where("reviewedVetMail", isEqualTo: vetMail)
          .where("reviewerUID", isEqualTo: userUID)
          .get() //Get first review
          .then((value) =>
              value.docs.first.reference.update(updatedReview.toJson()));
      print("[REVIEW REPOS] Review updated");
    } else {
      print("[REVIEW REPOS] Review not found to update");
      return Future.error("Review not found to update");
    }
  }

  //Add review using mails.
  static Future<void> AddReviewUsingMail(
      String userMail, String vetMail, Review review) async {
    DocumentReference userRef =
        await UserRepository.GetUserReferenceWithEmail(userMail);
    DocumentReference vetRef =
        await VeterinaryRepository.GetVetReferenceWithEmail(vetMail);
    //Snapshot user and vet doc to check if they exist
    DocumentSnapshot userSnap = await userRef.get();
    DocumentSnapshot vetSnap = await vetRef.get();
    //Check if user and vet exist, if not , return
    if (!userSnap.exists || !vetSnap.exists) {
      return Future.error(
          "[REVIEW REPOS - ADD WITH MAIL] User or vet not found");
    }
    //Bit of a waste of time but its ok
    UserModel? user = await UserRepository.GetUserWithReference(userRef);
    //Check if user has already reviewed this vet.
    if (await HasReviewBetween(user!.uid, vetMail) == true) {
      print(
          "[REVIEW REPOS - ADD WITH MAIL] User has already reviewed this vet: Reviewer: ${user.uid} with mail ${user.email} Reviewed vet: ${vetMail}");
      return Future.error("User has already reviewed this vet");
    } else {
      try {
        //Add review to db
        await db.collection("Reviews").doc().set(review.toJson());
        print(
            "[REVIEW REPOS - ADD WITH MAIL] Review added to user and vet: Reviewer: ${user.uid} with mail ${user.email} Reviewed vet: ${vetMail}");
      } catch (e) {
        print(e);
      }
    }
    return Future.value(null);
  }

  //-------ULTILITY FUNCTIONS-------

  //Check if user has reviewed this vet.
  static Future<bool> HasReviewBetween(String userUID, String vetMail) async {
    //Check if user and vet exist. If not, print and return error
    if (await UserRepository.DoesUserWithUIDExist(userUID) == false) {
      print("[REVIEW REPOS] User not found");
      return Future.error("[REVIEW REPOS]  User not found");
    } else if (await VeterinaryRepository.DoesVetExist(vetMail) == false) {
      print("[REVIEW REPOS] Vet are the same");
      return Future.error("REVIEW REPOS] Vet not found");
    } else {
      //Perform query in DB/Reviews.
      final reviewsRef = await db.collection("Reviews");
      final query = await reviewsRef
          .where("reviewedVetMail", isEqualTo: vetMail)
          .where("reviewerUID",
              isEqualTo: await UserRepository.GetUserMailWithUID(userUID))
          .get();
      if (query.docs.length > 0) {
        print(
            "[REVIEW REPOS] Review with user UID ${userUID} and vet ${vetMail} found");
        return true;
      } else {
        print(
            "[REVIEW REPOS] No review found with user UID ${userUID} and vet ${vetMail}");
        return false;
      }
    }
  }

  //Get all reviews of a vet ( by all users)
  static Future<List<Review>> GetAllReviewsOfVet(String vetMail) async {
    List<Review> reviews = [];
    //Perform queries
    final reviewsRef = await db.collection("Reviews");
    final query =
        await reviewsRef.where("reviewedVetMail", isEqualTo: vetMail).get();
    reviews = query.docs.map((e) => Review.fromJson(e.data())).toList();
    return reviews;
  }

  //Get all reviews of a user (to all vets). Can be empty
  static Future<List<Review>?> GetAllReviewsOfUser(String userUID) async {
    if (await UserRepository.DoesUserWithUIDExist(userUID) == false) {
      print("[REVIEW REPOS] User not found");
      return Future.error("[REVIEW REPOS] User not found");
    }

    List<Review> reviews = [];
    final reviewsRef = await db.collection("Reviews");
    final query =
        await reviewsRef.where("reviewerUID", isEqualTo: userUID).get();
    reviews = query.docs.map((e) => Review.fromJson(e.data())).toList();
    return reviews;
  }

  //Get a review of a vet by a particular user. Can be null, meaning user has not reviewed this vet
  //Generally used on current user

  static Future<Review?> GetReviewOfVetByUser(
      UserModel user, Veterinary vet) async {
    Review? review;
    final reviewsRef = await db.collection("Reviews");
    final query = await reviewsRef
        .where("reviewedVetMail", isEqualTo: vet.vetMail)
        .where("reviewerUID", isEqualTo: user.uid)
        .get();
    if (query.docs.length > 0) {
      review = Review.fromJson(query.docs.first.data());
    } else {
      review = null;
    }
    return review;
  }

  //Get a review of a vet by a particular user using mail. Can be null, meaning user has not reviewed this vet
  //Generally used on current user or on other review of a particular vet.
  static Future<Review?> GetReviewOfVetByUserUsingMail(
      String userMail, String vetMail) async {
    Review? review;
    final reviewsRef = await db.collection("Reviews");
    final query = await reviewsRef
        .where("reviewedVetMail", isEqualTo: vetMail)
        .where("reviewerUID",
            isEqualTo: await UserRepository.GetUserUIDWithMail(
                userMail)) //Dont try to read this. It get UID from mail
        .get();

    if (query.docs.length > 0) {
      review = Review.fromJson(query.docs.first.data());
    } else {
      review = null;
    }
    return review;
  }

  //Delete a review using mail of reviewer and vet.
  //Not used often
  static Future<void> RemoveReviewUsingUID(
      String userUID, String vetMail) async {
    //Check if review exist
    if (await HasReviewBetween(userUID, vetMail)) {
      //Delete review
      try {
        await db
            .collection("Reviews")
            .where("reviewedVetMail", isEqualTo: vetMail)
            .where("reviewerUID", isEqualTo: userUID)
            .get()
            .then((value) => value.docs.first.reference.delete());
      } catch (e) {
        print(e);
        return Future.error(e);
      }
    } else {
      print("[REVIEW REPOS] Review not found to delete");
      return Future.error("Review not found to delete");
    }
  }

  //Delete a review.
  //Used on Review model.
  static Future<void> RemoveReview(Review review) async {
    //Check if review exist
    if (await HasReviewBetween(review.reviewerUID, review.reviewedVetMail)) {
      //Delete review
      try {
        await db
            .collection("Reviews")
            .where("reviewedVetMail", isEqualTo: review.reviewedVetMail)
            .where("reviewerUID", isEqualTo: review.reviewerUID)
            .get()
            .then((value) => value.docs.first.reference.delete());
      } catch (e) {
        return Future.error(e);
      }
    } else {
      print("[REVIEW REPOS] Review not found to delete");
      return Future.error("Review not found to delete");
    }
  }

  //Update review
  //Used on Review model
  static Future<void> UpdateReview(Review review) async {
    //Check if review exist
    if (await HasReviewBetween(review.reviewerUID, review.reviewedVetMail)) {
      //Update review
      try {
        await db
            .collection("Reviews")
            .where("reviewedVetMail", isEqualTo: review.reviewedVetMail)
            .where("reviewerUID", isEqualTo: review.reviewerUID)
            .get()
            .then(
                (value) => value.docs.first.reference.update(review.toJson()));
      } catch (e) {
        print(e);
      }
    } else {
      print("[REVIEW REPOS] Review not found to update");
      return Future.error("Review not found to update");
    }
  }

  //Get average rating of a vet
  static Future<double> GetAverageRatingOfVet(String vetMail) async {
    double averageRating = 0;
    //Get all reviews of vet
    List<Review> reviews = await GetAllReviewsOfVet(vetMail);
    //Calculate average
    if (reviews.length > 0) {
      averageRating = reviews
              .map((e) => e.rating)
              .reduce((value, element) => value + element) /
          reviews.length;
    }
    return averageRating;
  }

  //Get review UID
  static Future<String?> GetReviewUID(String userUID, String vetMail) async {
    //Check if review exist
    if (await HasReviewBetween(userUID, vetMail)) {
      //Update review
      try {
        return db
            .collection("Reviews")
            .where("reviewedVetMail", isEqualTo: vetMail)
            .where("reviewerUID", isEqualTo: userUID)
            .get()
            .then((value) => value.docs.first.id);
      } catch (e) {
        print(e);
      }
    }
  }
}
