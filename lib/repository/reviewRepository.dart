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
//
//Utils
//+Check if user has reviewed a certain vet using mail
//++Get average rating of a vet
//++Get number of reviews of a vet
//Path storage: Reviews/{VetMail}/{UserMail}/{Review}
//User and vet has ReviewPaths that point toward specific review related to them
class ReviewRepository {
  static final ReviewRepository _instance = ReviewRepository._internal();
  factory ReviewRepository() => _instance;
  static final db = FirebaseFirestore.instance;
  ReviewRepository._internal() {
    // init things inside this
  }

//Add review to db
  static Future<void> AddReview(
      UserModel? user, Veterinary? reviewedVet, Review review) async {
    //if either user or vet is null, return

    if (user == null || reviewedVet == null) {
      return Future.error("User or vet is null");
    }
    DocumentReference userRef =
        await UserRepository.GetUserReferenceWithEmail(user.email);
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
    if (await HasReviewBetween(user.email, reviewedVet.vetMail)) //Exist
    {
      print(
          "[REVIEW REPOS] User has already reviewed this vet: Reviewer: ${user.email} Reviewed vet: ${reviewedVet.vetMail}");
      return Future.error("User has already reviewed this vet");
    } else {
      try {
        //Add review to db
       await db.collection("Reviews").doc("${reviewedVet.vetMail}-${user.email}").set(review.toJson());
        print(
            "[REVIEW REPOS] Review path added to user and vet: Reviewer: ${user.email} Reviewed vet: ${reviewedVet.vetMail}");
      } catch (e) {
        print(e);
      }
    }
    return Future.value(null);
  }
  //Update a review between user and vet
  Future <void> UpdateReviewBetween(String userMail, String vetMail, Review updatedReview) async 
  {
    //Check if review exist
    if ( await HasReviewBetween(userMail, vetMail))
    {
      //Update review
      db.collection("Reviews").doc("${vetMail}-${userMail}").update(updatedReview.toJson());
    }
    else
    {
      print ("[REVIEW REPOS] Review not found to update");
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
      return Future.error("[REVIEW REPOS - ADD WITH MAIL] User or vet not found");
    }
    
    //Check if user has already reviewed this vet.
    if (await HasReviewBetween(userMail, vetMail) == true) {
      print(
          "[REVIEW REPOS - ADD WITH MAIL] User has already reviewed this vet: Reviewer: ${userMail} Reviewed vet: ${vetMail}");
      return Future.error("User has already reviewed this vet");
    } else {
      try {

        //Add review to db
        await db.collection("Reviews").doc("${vetMail}-${userMail}").set(review.toJson());
        print(
            "[REVIEW REPOS - ADD WITH MAIL] Review added to user and vet: Reviewer: ${userMail} Reviewed vet: ${vetMail}");
      } catch (e) {
        print(e);
      }
    }
    return Future.value(null);
  }

  //Check if user has reviewed this vet.
  static Future<bool> HasReviewBetween(String userMail, String vetMail) async {
    //Check if user and vet exist. If not, print and return error
    if (await UserRepository.DoesUserExist(userMail) == false
        ) {
      print("[REVIEW REPOS] User not found");
      return Future.error("[REVIEW REPOS]  User not found");
    } 
    else if  (await VeterinaryRepository.DoesVetExist(vetMail) == false) {
      print("[REVIEW REPOS] Vet are the same");
      return Future.error("REVIEW REPOS] Vet not found");
    }
    else {
      //Perform query in DB/Reviews.
      final reviewsRef = await db.collection("Reviews");
      final query = await reviewsRef
          .where("reviewedVetMail", isEqualTo: vetMail)
          .where("reviewerMail", isEqualTo: userMail)
          .get();
      if (query.docs.length > 0) {
        print ("[REVIEW REPOS] Review found");
        return true;
      } else {
        print ("[REVIEW REPOS] Review not found");
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
        await reviewsRef.where("reviewedVetRef", isEqualTo: vetMail).get();
    reviews = query.docs.map((e) => Review.fromJson(e.data())).toList();
    return reviews;
  }

  //Get all reviews of a user (to all vets). Can be empty
  static Future<List<Review>?> GetAllReviewsOfUser(String userMail) async {

    if (await UserRepository.DoesUserExist(userMail)) {
      print("[REVIEW REPOS] User not found");
      return Future.error("[REVIEW REPOS] User not found");
    }

    List<Review> reviews = [];
    final reviewsRef = await db.collection("Reviews");
    final query =
        await reviewsRef.where("reviewerRef", isEqualTo: userMail).get();
    reviews = query.docs.map((e) => Review.fromJson(e.data())).toList();
    return reviews;
  }

  //Get a review of a vet by a particular user. Can be null, meaning user has not reviewed this vet
  static Future<Review?> GetReviewOfVetByUser(
      UserModel user, Veterinary vet) async {
    Review? review;
    final reviewsRef = await db.collection("Reviews");
    final query = await reviewsRef
        .where("reviewedVetMail", isEqualTo: vet.vetMail)
        .where("reviewerMail", isEqualTo: user.email)
        .get();
    if (query.docs.length > 0) {
      review = Review.fromJson(query.docs.first.data());
    } else {
      review = null;
    }
    return review;
  }
  //Get a review of a vet by a particular user using mail. Can be null, meaning user has not reviewed this vet
  static Future<Review?> GetReviewOfVetByUserUsingMail(
      String userMail, String vetMail) async {
    Review? review;
    final reviewsRef = await db.collection("Reviews");
    final query = await reviewsRef
        .where("reviewedVetMail", isEqualTo: vetMail)
        .where("reviewerMail", isEqualTo: userMail)
        .get();
    if (query.docs.length > 0) {
      review = Review.fromJson(query.docs.first.data());
    } else {
      review = null;
    }
    return review;
  }
  //Delete a review using mail of reviewer and vet
  static Future<void> RemoveReviewUsingMail(String userMail, String vetMail) async {
    //Check if review exist
    if (await HasReviewBetween(userMail, vetMail)) {
      //Delete review
      try {
        await db
            .collection("Reviews")
            .doc("${vetMail}-${userMail}")
            .delete();
      } catch (e) {
        print(e);
        return Future.error(e);
      }
    } else {
      print("[REVIEW REPOS] Review not found to delete");
      return Future.error("Review not found to delete");
    }
  }
  //Delete a review
  static Future<void> RemoveReview(Review review) async {
    //Check if review exist
    if (await HasReviewBetween(review.reviewerMail, review.reviewedVetMail)) {
      //Delete review
      try {
        await db
            .collection("Reviews")
            .doc("${review.reviewedVetMail}-${review.reviewerMail}")
            .delete();
      } catch (e) {
       
        return Future.error(e);
      }
    } else {
      print("[REVIEW REPOS] Review not found to delete");
      return Future.error("Review not found to delete");
    }
  }
  //Update review
  static Future<void> UpdateReview(Review review) async {
    //Check if review exist
    if (await HasReviewBetween(review.reviewerMail, review.reviewedVetMail)) {
      //Update review
      try {
        await db
            .collection("Reviews")
            .doc("${review.reviewedVetMail}-${review.reviewerMail}")
            .update(review.toJson());
      } catch (e) {
        print(e);
      }
    } else {
      print("[REVIEW REPOS] Review not found to update");
      return Future.error("Review not found to update");
    }
  }
}
