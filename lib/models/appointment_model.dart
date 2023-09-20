

import 'package:petcare_search/repository/appointmentRepository.dart';
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
    
  });

  Future<void> Finish() async
  {
    finished = true;
    await AppointmentRepos.FinishAppointment(this);
  }

  //fromJson
  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    bookerUID: json["bookerUID"],
    bookedVetMail: json["bookedVetMail"],
    bookedDate: json["bookedDate"].toDate(),
    bookedOn: json["bookedOn"].toDate(),
  );
  //To json
  Map<String, dynamic> toJson() => {
    "bookerUID": bookerUID,
    "bookedVetMail": bookedVetMail,
    "bookedDate": bookedDate,
    "bookedOn": bookedOn,
  };
}