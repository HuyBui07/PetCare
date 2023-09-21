

import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/models/veterinary_model.dart';
import 'package:petcare_search/repository/appointmentRepository.dart';
import 'package:petcare_search/repository/userRepository.dart';
import 'package:petcare_search/repository/vetRepository.dart';
import 'package:petcare_search/screens/appoinment_tab/appointmentScreen.dart';

class Appointment
{
  String bookerUID;
  String bookedVetMail;
  DateTime bookedDate;
  DateTime bookedOn;
  bool finished = false;

  Appointment({
    required this.bookerUID,
    required this.bookedVetMail,
    required this.bookedDate,
    required this.bookedOn,
    this.finished = false,
  });

  Future<void> Finish() async
  {
    finished = true;
    await AppointmentRepos.FinishAppointment(this);
  }
  Future<UserModel?> GetUser () async
  {
    UserModel? user = await UserRepository.GetUserWithUID(bookerUID);
    if (user == null)
      return Future.error ("User not found");
    return user;
  }
  Future<Veterinary> GetVet () async
  {
    Veterinary? vet = await VeterinaryRepository.GetVeterinaryWithEmail(bookedVetMail);
    if (vet == null)
      return Future.error ("Vet not found");
    return vet;
  }

  //fromJson
  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    bookerUID: json["bookerUID"],
    bookedVetMail: json["bookedVetMail"],
    bookedDate: json["bookedDate"].toDate(),
    bookedOn: json["bookedOn"].toDate(),
    finished: json["finished"],
  );
  //To json
  Map<String, dynamic> toJson() => {
    "bookerUID": bookerUID,
    "bookedVetMail": bookedVetMail,
    "bookedDate": bookedDate,
    "bookedOn": bookedOn,
    "finished": finished,
  };
}