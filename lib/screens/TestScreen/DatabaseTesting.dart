import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcare_search/models/model_enums.dart';
import 'package:petcare_search/models/pet_model.dart';
import 'package:petcare_search/models/review_model.dart';
import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/models/veterinary_model.dart';
import 'package:petcare_search/repository/petRepository.dart';
import 'package:petcare_search/repository/reviewRepository.dart';
import 'package:petcare_search/repository/userRepository.dart';
import 'package:petcare_search/repository/vetRepository.dart';

class DatabaseTestScreen extends StatefulWidget {
  const DatabaseTestScreen({Key? key}) : super(key: key);

  @override
  State<DatabaseTestScreen> createState() => _DatabaseTestScreenState();
}

class _DatabaseTestScreenState extends State<DatabaseTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Database Test"),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DBT_GetUserTest(),
              //Add pet to user
              DBT_AddPetToUserTest(),
              DBT_GetPetFromUserTest(),
              DBT_RemovePetFromUserTest(),
              DBT_AddUserTest(),
              //Add vet button
              DBT_AddAVetTest(),
              DBT_GetVetTest(),
              DBT_AddReviewTest(),
              DBT_RemoveReviewTest(),
              DBT_GetReviewTest(),
            ],
          ),
        ),
      ),
    );
  }
}
//Enter user mail and pet name. If it exist, alert it's detail and remove it. If not exist, alert error
class DBT_RemovePetFromUserTest extends StatefulWidget {
  const DBT_RemovePetFromUserTest({super.key});

  @override
  State<DBT_RemovePetFromUserTest> createState() => _DBT_RemovePetFromUserTestState();
}

class _DBT_RemovePetFromUserTestState extends State<DBT_RemovePetFromUserTest> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Get pet by email
        Pet petToDisplay;
        TextEditingController emailController = TextEditingController();
        TextEditingController petNameController = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Enter email"),
                content: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Owner email",
                      ),
                    ),
                    TextField(
                      controller: petNameController,
                      decoration: const InputDecoration(
                        labelText: "Pet name",
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                  TextButton(
                    onPressed: () {
                      //Get user by email
                      try {
                        PetRepository.GetPetFromOwner(
                                petNameController.text.trim(),
                                emailController.text.trim())
                            .then((value) {
                          if (value != null) {
                            petToDisplay = value;
                            //Display user
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Pet name: ${petToDisplay.name}"),
                                    content: Text(
                                        "Pet breed: ${petToDisplay.breed}\nPet size: ${EnumConverter.PetSizeToString(petToDisplay.size)}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          //Remove pet
                                          try {
                                            await PetRepository.RemovePetFromOwner(
                                                petToDisplay.name,
                                                emailController.text.trim());
                                            //Alert
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Pet removed"),
                                                    content: const Text(
                                                        "Pet removed"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Close"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          } catch (e) {
                                            //Display error
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Error removing pet"),
                                                    content: Text("$e"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Close"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }
                                        },
                                        child: const Text("Remove pet"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Pet not found"),
                                    content: const Text("Pet not found"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      } catch (e) {
                        //Display error
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error getting pet"),
                                content: Text("$e"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Close"),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: const Text("Get pet"),
                  ),
                ],
              );
            });
      },
      child: const Text("Remove pet from user"),
    );
  }
}



//Enter user mail, pet name. Return pet detail if exist. Else, alert error
class DBT_GetPetFromUserTest extends StatefulWidget {
  const DBT_GetPetFromUserTest({super.key});

  @override
  State<DBT_GetPetFromUserTest> createState() => _DBT_GetPetFromUserTestState();
}

class _DBT_GetPetFromUserTestState extends State<DBT_GetPetFromUserTest> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () async {
        // Get pet by email
        Pet petToDisplay;
        TextEditingController emailController = TextEditingController();
        TextEditingController petNameController = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Enter email"),
                content: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Owner email",
                      ),
                    ),
                    TextField(
                      controller: petNameController,
                      decoration: const InputDecoration(
                        labelText: "Pet name",
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                  TextButton(
                    onPressed: () {
                      //Get user by email
                      try {
                        PetRepository.GetPetFromOwner(
                                petNameController.text.trim(),
                                emailController.text.trim())
                            .then((value) {
                          if (value != null) {
                            petToDisplay = value;
                            //Display user
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Pet name: ${petToDisplay.name}"),
                                    content: Text(
                                        "Pet breed: ${petToDisplay.breed}\nPet size: ${EnumConverter.PetSizeToString(petToDisplay.size)}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Pet not found"),
                                    content: const Text("Pet not found"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      } catch (e) {
                        //Display error
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error getting pet"),
                                content: Text("$e"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Close"),
                                  ),
                                ],
                              );
                            });
                  
                       }
                    },
                    child: const Text("Get pet"),
                  ),
                ],
              );
            });
      },
      child: const Text("Get pet from user"),
    );
  }
}


class DBT_GetUserTest extends StatefulWidget {
  const DBT_GetUserTest({super.key});

  @override
  State<DBT_GetUserTest> createState() => _GetUserTestState();
}

class _GetUserTestState extends State<DBT_GetUserTest> {
  @override
  Widget build(BuildContext context) {
    return //Show dialog to enter email. Then get user by email and display it using show dialog
        ElevatedButton(
      onPressed: () async {
        // Get user by email
        UserModel userToDisplay;
        TextEditingController emailController = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Enter email"),
                content: TextField(
                  controller: emailController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                  TextButton(
                    onPressed: () {
                      //Get user by email
                      try {
                        UserRepository.GetUserWithEmail(
                                email: emailController.text.trim())
                            .then((value) {
                          if (value != null) {
                            userToDisplay = value;
                            //Display user
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "User name: ${userToDisplay.name}"),
                                    content: Text(
                                        "User email: ${userToDisplay.email}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("User not found"),
                                    content: const Text("User not found"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      } catch (e) {
                        //Display error
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error getting user"),
                                content: Text("$e"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Close"),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: const Text("Get user"),
                  ),
                ],
              );
            });
      },
      child: const Text("Get user by email"),
    );
  }
}

//Enter user mail and vet mail. If review exists between a vet and user , display it's detail similiarly to remove pet using dialog, then remove it. If not , alert error
class DBT_RemoveReviewTest extends StatefulWidget {
  const DBT_RemoveReviewTest({super.key});

  @override
  State<DBT_RemoveReviewTest> createState() => _DBT_RemoveReviewTestState();
}

class _DBT_RemoveReviewTestState extends State<DBT_RemoveReviewTest> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController vetMailController = TextEditingController();
    return ElevatedButton
    (
      onPressed: () {
        showDialog(
            context:  context,
            builder : (BuildContext context)  
            {
                return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text("Enter email"),
                  content: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Reviewer email",
                        ),
                      ),
                      TextField(
                        controller: vetMailController,
                        decoration: const InputDecoration(
                          labelText: "Reviewed vet email",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () async {
                        //Get user by email
                        try {
                          if (await UserRepository.DoesUserExist(
                                  emailController.text.trim()) != false) {
                            //Remove review
                            await ReviewRepository.RemoveReviewUsingMail(
                                emailController.text.trim(),
                                vetMailController.text.trim());
                            //Alert
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Review removed"),
                                    content: const Text("Review removed"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("User not found"),
                                    content: const Text("User not found"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        } catch (e) {
                          //Display error
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error removing review"),
                                  content: Text("$e"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text("Remove review"),
                    ),
                  ],
                ),
              );
            });
      },
      child: const Text("Remove review"),
    );
  }
}

//Enter user mail, and reviewed vet mail. Then get review and display it using dialog
class DBT_GetReviewTest extends StatefulWidget {
  const DBT_GetReviewTest({super.key});

  @override
  State<DBT_GetReviewTest> createState() => _DBT_GetReviewTestState();
}

class _DBT_GetReviewTestState extends State<DBT_GetReviewTest> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () async {
        // Get review by email
        Review reviewToDisplay;
        TextEditingController emailController = TextEditingController();
        TextEditingController vetMailController = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text("Enter email"),
                  content: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Reviewer email",
                        ),
                      ),
                      TextField(
                        controller: vetMailController,
                        decoration: const InputDecoration(
                          labelText: "Reviewed vet email",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () {
                        //Get user by email
                        try {
                          ReviewRepository.GetReviewOfVetByUserUsingMail(
                                  emailController.text.trim(),
                                  vetMailController.text.trim())
                              .then((value) {
                            if (value != null) {
                              reviewToDisplay = value;
                              //Display user
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Review rating: ${reviewToDisplay.rating}"),
                                      content: Text(
                                          "Review description: ${reviewToDisplay.reviewDescription}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Review not found"),
                                      content: const Text("Review not found"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          });
                        } catch (e) {
                          //Display error
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error getting review"),
                                  content: Text("$e"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text("Get review"),
                    ),
                  ],
                ),
              );
            });
      },
      child: const Text("Get review by email"),
    );

  }
}


class DBT_AddPetToUserTest extends StatefulWidget {
  const DBT_AddPetToUserTest({super.key});

  @override
  State<DBT_AddPetToUserTest> createState() => _DBT_AddPetToUserTestState();
}

class _DBT_AddPetToUserTestState extends State<DBT_AddPetToUserTest> {
  @override
  Widget build(BuildContext context) {
    // Get user by email

    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController breedController = TextEditingController();
    PetSize sizeController = PetSize.small;
    bool isNeuteredController = false;
    bool isVaccinatedController = false;
    bool isFriendlyWithDogController = false;
    bool isFriendlyWithCatController = false;
    //Fill with default value
    Pet randomPet = Pet(
      name: "WeBallin${Random().nextInt(100)}",
      avatarPath: "img",
      ownerMail: "amongus@gmail.com",
      breed: "BreedX",
      size: PetSize.small,
      isNeutered: false,
      isVaccinated: false,
      isFriendlyWithDog: false,
      isFriendlyWithCat: true,
    );
    return ElevatedButton(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text("Edit pet information"),
                  content: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Owner mail",
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Pet name",
                        ),
                      ),

                      TextField(
                        controller: breedController,
                        decoration: const InputDecoration(
                          labelText: "Pet breed",
                        ),
                      ),
                      //Note: for some reason the data does not update when changing dropdown value. But the value does, check it's print out.
                      DropdownButton<PetSize>(
                        value: sizeController,
                        onChanged: (PetSize? newValue) {
                          setState(() {
                            //set size
                            sizeController = newValue!;
                            print("Size changed to: " +
                                sizeController.toString());
                          });
                        },
                        items: PetSize.values
                            .map<DropdownMenuItem<PetSize>>((PetSize value) {
                          return DropdownMenuItem<PetSize>(
                            value: value,
                            child: Text(EnumConverter.PetSizeToString(value)),
                          );
                        }).toList(),
                      ),
                      CheckboxListTile(
                        title: const Text("Is neutered"),
                        value: isNeuteredController,
                        onChanged: (newValue) {
                          setState(() {
                            isNeuteredController = newValue!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Is vaccinated"),
                        value: isVaccinatedController,
                        onChanged: (newValue) {
                          setState(() {
                            isVaccinatedController = newValue!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Is friendly with dog"),
                        value: isFriendlyWithDogController,
                        onChanged: (newValue) {
                          setState(() {
                            isFriendlyWithDogController = newValue!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Is friendly with cat"),
                        value: isFriendlyWithCatController,
                        onChanged: (newValue) {
                          setState(() {
                            isFriendlyWithCatController = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () async {
                        //Get user by email
                        try {
                          if (await UserRepository.DoesUserExist(
                                  emailController.text.trim()) !=
                              false) {
                            //Update pet
                            randomPet = Pet(
                              name: nameController.text.trim(),
                              avatarPath: "img",
                              ownerMail: emailController.text.trim(),
                              breed: breedController.text.trim(),
                              size: sizeController,
                              isNeutered: isNeuteredController,
                              isVaccinated: isVaccinatedController,
                              isFriendlyWithDog: isFriendlyWithDogController,
                              isFriendlyWithCat: isFriendlyWithCatController,
                            );
                            //Add pet to db

                            await PetRepository.AddPetToOwnerUsingMail(
                                randomPet, emailController.text.trim());
                            //Alert
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Pet added"),
                                    content: const Text("Pet added"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("User not found"),
                                    content: const Text("User not found"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error adding pet"),
                                  content: Text("$e"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text("Add random pet"),
                    )
                  ],
                ),
              );
            });
      },
      child: const Text("Add pet to user"),
    );
  }
}

class DBT_AddReviewTest extends StatefulWidget {
  const DBT_AddReviewTest({super.key});

  @override
  State<DBT_AddReviewTest> createState() => _DBT_AddReviewTestState();
}

class _DBT_AddReviewTestState extends State<DBT_AddReviewTest> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String defaultReviewerMail = "amongus22@gmail.com";
        String defaultReviewedVetMail = "among16@gmail.com";
        //Add review to db
        Review review = Review(
          reviewedVetMail: defaultReviewedVetMail,
          reviewerMail: defaultReviewerMail,
          rating: 5,
          reviewDescription: "This is a review",
          reviewDate: DateTime.now(),
        );

        //Show dialog with default value of review.
        //Allow user to edit review
        TextEditingController emailController = TextEditingController();
        TextEditingController vetMailController = TextEditingController();
        TextEditingController ratingController = TextEditingController();
        TextEditingController reviewDescriptionController =
            TextEditingController();
        //Fill with default value
        ratingController.text = review.rating.toString();
        emailController.text = review.reviewerMail;
        vetMailController.text = review.reviewedVetMail;
        reviewDescriptionController.text = review.reviewDescription;
        //Show dialog to get user to edit review, vetMail, and reviewerMail
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text("Enter review information"),
                  content: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Reviewer email",
                        ),
                      ),
                      TextField(
                        controller: vetMailController,
                        decoration: const InputDecoration(
                          labelText: "Reviewed vet email",
                        ),
                      ),
                      TextField(
                        controller: ratingController,
                        decoration: const InputDecoration(
                          labelText: "Rating",
                        ),
                      ),
                      TextField(
                        controller: reviewDescriptionController,
                        decoration: const InputDecoration(
                          labelText: "Review description",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () async {
                        //Get user by email

                        if (await UserRepository.DoesUserExist(
                                    emailController.text.trim()) !=
                                false &&
                            await VeterinaryRepository.DoesVetExist(
                                    vetMailController.text.trim()) !=
                                false) {
                          //Update review
                          review = Review(
                            reviewedVetMail: vetMailController.text.trim(),
                            reviewerMail: emailController.text.trim(),
                            rating: int.parse(ratingController.text.trim()),
                            reviewDescription:
                                reviewDescriptionController.text.trim(),
                            reviewDate: DateTime.now(),
                          );
                          //Add review to db
                          try {
                            await ReviewRepository.AddReviewUsingMail(
                                emailController.text.trim(),
                                vetMailController.text.trim(),
                                review);
                            //Alert
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Review added"),
                                    content: const Text("Review added"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error adding review"),
                                    content: Text("$e"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        }
                        else 
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("User or vet not found"),
                                  content: const Text("User or vet not found"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text("Add review"),
                    )
                  ],
                ),
              );
            });
      },
      child: const Text("Add review to a vet"),
    );
  }
}

class DBT_GetVetTest extends StatefulWidget {
  const DBT_GetVetTest({super.key});

  @override
  State<DBT_GetVetTest> createState() => _DBT_GetVetTestState();
}

class _DBT_GetVetTestState extends State<DBT_GetVetTest> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          //Enter email then display information of said vet using dialog. If not exist, alert
          TextEditingController emailController = TextEditingController();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Enter vet email"),
                  content: TextField(
                    controller: emailController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () {
                        //Get user by email
                        VeterinaryRepository.GetVeterinaryWithEmail(
                                emailController.text.trim())
                            .then((value) {
                          if (value != null) {
                            //Display vet
                            //Print all vet
                            print(value.toJson());
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Vet name: ${value.name}"),
                                    content: Text(
                                        "Vet email: ${value.vetMail}\n Vet specialty: ${EnumConverter.VeterinarySpecialtyToString(value.specialty)}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            //Display error
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Vet not found"),
                                    content: const Text("Vet not found"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      },
                      child: const Text("Get vet"),
                    )
                  ],
                );
              });
        },
        child: const Text("Get vet"));
  }
}

class DBT_AddAVetTest extends StatefulWidget {
  const DBT_AddAVetTest({super.key});

  @override
  State<DBT_AddAVetTest> createState() => _DBT_AddAVetTestState();
}

class _DBT_AddAVetTestState extends State<DBT_AddAVetTest> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Add a vet
        Veterinary vetTest = Veterinary(
          name: "TestVet",
          vetMail: "among${Random().nextInt(100)}@gmail.com",
          imagePath: "path",
          specialty: VeterinarySpecialty.Dentist,
          price: 2,
          biography: "bio",
          educationIntroduction: "edu",
          professionalExperience: "pro",
          personalInformation: "personal",
        );
        //Use dialog to get user to edit above information if want to
        TextEditingController emailController = TextEditingController();
        TextEditingController nameController = TextEditingController();
        TextEditingController imagePathController = TextEditingController();
        VeterinarySpecialty specialty = VeterinarySpecialty.Dentist;
        TextEditingController priceController = TextEditingController();
        TextEditingController biographyController = TextEditingController();
        TextEditingController educationIntroductionController =
            TextEditingController();
        TextEditingController professionalExperienceController =
            TextEditingController();
        TextEditingController personalInformationController =
            TextEditingController();
        //Fill with default value
        emailController.text = vetTest.vetMail;
        nameController.text = vetTest.name;
        imagePathController.text = vetTest.imagePath;
        specialty = vetTest.specialty;
        priceController.text = vetTest.price.toString();
        biographyController.text = vetTest.biography;
        educationIntroductionController.text =
            vetTest.educationIntroduction.toString();
        professionalExperienceController.text =
            vetTest.professionalExperience.toString();
        personalInformationController.text =
            vetTest.personalInformation.toString();

        //Use dialog to ask user to edit information if needed. Fill the text field with default value
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text("Enter vet information"),
                  content: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      TextField(
                        controller: imagePathController,
                        decoration: const InputDecoration(
                          labelText: "Image path",
                        ),
                      ),
                      //Note: for some reason the data does not update when changing dropdown value. But the value does, check it's print out.
                      DropdownButton<VeterinarySpecialty>(
                        value: specialty,
                        onChanged: (VeterinarySpecialty? newValue) {
                          setState(() {
                            //set specialty

                            specialty = newValue!;
                            print("Specialty changed to: " +
                                specialty.toString());
                          });
                        },
                        items: VeterinarySpecialty.values
                            .map<DropdownMenuItem<VeterinarySpecialty>>(
                                (VeterinarySpecialty value) {
                          return DropdownMenuItem<VeterinarySpecialty>(
                            value: value,
                            child: Text(
                                EnumConverter.VeterinarySpecialtyToString(
                                    value)),
                          );
                        }).toList(),
                      ),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: "Price",
                        ),
                      ),
                      TextField(
                        controller: biographyController,
                        decoration: const InputDecoration(
                          labelText: "Biography",
                        ),
                      ),
                      TextField(
                        controller: educationIntroductionController,
                        decoration: const InputDecoration(
                          labelText: "Education introduction",
                        ),
                      ),
                      TextField(
                        controller: professionalExperienceController,
                        decoration: const InputDecoration(
                          labelText: "Professional experience",
                        ),
                      ),
                      TextField(
                        controller: personalInformationController,
                        decoration: const InputDecoration(
                          labelText: "Personal information",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () {
                        //Get user by email
                        VeterinaryRepository.GetVeterinaryWithEmail(
                                emailController.text.trim())
                            .then((value) async {
                          if (value != null) {
                            //Update vet
                            vetTest = Veterinary(
                              name: nameController.text.trim(),
                              vetMail: emailController.text.trim(),
                              imagePath: imagePathController.text.trim(),
                              specialty: specialty,
                              price: double.parse(priceController.text.trim()),
                              biography: biographyController.text.trim(),
                              educationIntroduction:
                                  educationIntroductionController.text.trim(),
                              professionalExperience:
                                  professionalExperienceController.text.trim(),
                              personalInformation:
                                  personalInformationController.text.trim(),
                            );
                            //Add vet to db
                            await VeterinaryRepository.UpdateVet(vetTest);
                            //Alert
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Vet updadted"),
                                    content: const Text("Vet updated"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            //Add vet
                            vetTest = Veterinary(
                              name: nameController.text.trim(),
                              vetMail: emailController.text.trim(),
                              imagePath: imagePathController.text.trim(),
                              specialty: specialty,
                              price: double.parse(priceController.text.trim()),
                              biography: biographyController.text.trim(),
                              educationIntroduction:
                                  educationIntroductionController.text.trim(),
                              professionalExperience:
                                  professionalExperienceController.text.trim(),
                              personalInformation:
                                  personalInformationController.text.trim(),
                            );
                            //Add vet to db
                            await VeterinaryRepository.AddVet(vetTest);
                            //Alert
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Vet added"),
                                    content: const Text("Vet added"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      },
                      child: const Text("Add vet"),
                    )
                  ],
                ),
              );
            });
      },
      child: const Text("Add vet"),
    );
  }
}

class DBT_AddUserTest extends StatefulWidget {
  const DBT_AddUserTest({super.key});

  @override
  State<DBT_AddUserTest> createState() => _DBT_AddUserTestState();
}

class _DBT_AddUserTestState extends State<DBT_AddUserTest> {
  @override
  Widget build(BuildContext context) {
    UserModel userToAdd = UserModel(
      email: "amongusx15@gmail.com",
      name: "TestUser",
      aboutMe: "about me",
      phoneNumber: "123456789",
      gender: Gender.male,
    );

    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController aboutMeController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    Gender genderController = Gender.none;
    //Fill with default value
    emailController.text = userToAdd.email;
    nameController.text = userToAdd.name;
    aboutMeController.text = userToAdd.aboutMe;
    phoneNumberController.text = userToAdd.phoneNumber!;
    return ElevatedButton(
      onPressed: () {
        // Add a user

        //Use dialog to ask user to edit information.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: AlertDialog(
                  title: const Text("Add a user"),
                  content: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      TextField(
                        controller: aboutMeController,
                        decoration: const InputDecoration(
                          labelText: "About me",
                        ),
                      ),
                      TextField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: "Phone number",
                        ),
                      ),
                      //Edit gender dropdown box
                      DropdownButton<Gender>(
                          value: genderController,
                          items: Gender.values
                              .map<DropdownMenuItem<Gender>>((Gender value) {
                            return DropdownMenuItem<Gender>(
                              value: value,
                              child: Text(EnumConverter.GenderToString(value)),
                            );
                          }).toList(),
                          onChanged: (Gender? newGender) {
                            setState(() {
                              genderController = newGender!;
                            });
                          }),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                    TextButton(
                      onPressed: () async {
                        userToAdd.email = emailController.text.trim();
                        userToAdd.name = nameController.text.trim();
                        userToAdd.aboutMe = aboutMeController.text.trim();
                        userToAdd.phoneNumber =
                            phoneNumberController.text.trim();
                        userToAdd.gender = genderController;
                        //Add user to db
                        try {
                          await UserRepository.AddUser(userToAdd);
                          //Alert
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("User added"),
                                  content: const Text("User added"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        } catch (e) {
                          //Show dialog of error
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error adding user"),
                                  content: Text("$e"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text("Add user"),
                    ),
                  ]),
            );
          },
        );
      },
      child: const Text("Add user"),
    );
  }
}

