import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petcare_search/models/appointment_model.dart';
import 'package:petcare_search/models/model_enums.dart';
import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/models/veterinary_model.dart';
import 'package:petcare_search/repository/appointmentRepository.dart';
import 'package:petcare_search/repository/userRepository.dart';
import 'package:petcare_search/repository/vetRepository.dart';
//Push generated vet information to database

// class PushVetInformationScreen extends StatefulWidget {
//   const PushVetInformationScreen({super.key});

//   @override
//   State<PushVetInformationScreen> createState() => _PushVetInformationScreenState();
// }

// class _PushVetInformationScreenState extends State<PushVetInformationScreen> {
//   TextEditingController vetNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Push Vet Information"),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [

//               //A single text field that contains all json information
//               TextField(
//                 controller: vetNameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Vet Information',
//                 ),
//               ),

//               //Button to push vet information to database
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: () {
//                 //Check if any text field is empty
//                 if ( vetNameController.text.isEmpty)
//                 {
//                   //Show dialog to tell user to fill in all text field
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text("Error"),
//                         content: const Text("Please fill in all text field"),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("OK"),
//                           )
//                         ],
//                       );
//                     }
//                   );
//                   return;
//                 }
//                 //Take all the text from a text box
//                 String content = vetNameController.text;
//                 //Parse the text into a vet object
//                 Veterinary vet = parseVeterinaryFromJson(content);

//                 try {
//                   VeterinaryRepository.AddVet(vet);
//                   //Show dialog to tell user that vet information is pushed to database
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text("Success"),
//                         content: const Text("Vet information is pushed to database"),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("OK"),
//                           )
//                         ],
//                       );
//                     }
//                   );
//                 } catch (e) {
//                   //Show dialog to tell user that vet information is not pushed to database
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text("Error"),
//                         content:  Text("Push failed. Error : ${e.toString()}"),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("OK"),
//                           )
//                         ],
//                       );
//                     }
//                   );
//                 }

//               }, child: Text("Push Vet Information"))

//             ]
//           ),
//         ),
//       ),
//     );

//   }
// }

// Veterinary parseVeterinaryFromJson(String jsonString) {
//   // Parse the JSON string into a Map
//   Map<String, dynamic> jsonMap = json.decode(jsonString);

//   // Create a Veterinary object from the JSON data
//   Veterinary vet = Veterinary.fromJson(jsonMap);

//   return vet;
// }

class BookApointmentTest extends StatefulWidget {
  const BookApointmentTest({super.key});

  @override
  State<BookApointmentTest> createState() => _BookApointmentTestState();
}

class _BookApointmentTestState extends State<BookApointmentTest> {
  UserModel? userTest;
  String vetMail = "emily1234@example.com";
  @override
  
  @override
  Widget build(BuildContext context) {
    //Show dialog info of vet and status of the appointment. Another "Finish" button to change the appointment status
    return Scaffold(
        appBar: AppBar(
          title: const Text("Book Appointment Test"),
        ),
        body: Column(children: [
          ElevatedButton(
              onPressed: () async {
                //Get vet information
                userTest =
        await UserRepository.GetUserWithUID("40daOKYh7PNWj3UrAFqZx1MKwko1");
                Veterinary? vet =
                    await VeterinaryRepository.GetVeterinaryWithEmail(vetMail);
                //Create appointment
               try 
               {
                 Appointment appointment = Appointment(
                    bookedDate: DateTime.now(),
                    bookedOn:  DateTime.now(),
                    bookedVetMail: vetMail,
                    bookerUID: userTest!.uid,
                );
                //Add appointment to database
                await AppointmentRepos.AddAppointment(appointment);
                //Show dialog to tell user that vet information is pushed to database
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Success"),
                        content: const Text("Appointment is booked"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          )
                        ],
                      );
                    });
               }
               catch (e)
               {
                  //Show dialog to tell user that vet information is not pushed to database
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content:  Text("Book failed. Error : ${e.toString()}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            )
                          ],
                        );
                      }
                    );
               }
              },
              child: Text("Book Appointment")),
              //Finish appointment
              ElevatedButton(
              onPressed: () async {
                //Get the appointment between user and vet. Call finish
                Appointment? appointment = await AppointmentRepos.GetUnfinishedAppointmentForVetAndUser(userTest!.uid, vetMail);
                if (appointment == null)
                {
                  //Show dialog to tell user that vet information is not pushed to database
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content:  Text("Appointment not found"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            )
                          ],
                        );
                      }
                    );
                    return;
                }
                //Show appointment time with a button to finish
                showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Appointment"),
                          content:  Text("Appointment on ${appointment.bookedDate}"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                //Finish appointment
                                await appointment.Finish();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Finish"),
                            )
                          ],
                        );
                      }
                    );
              },
              child: Text("Finish Appointment")
              )


        ]));
  }
}
