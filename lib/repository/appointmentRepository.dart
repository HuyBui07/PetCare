


//Simply add, update and remove appointment from db.
//Also load all apointment for users.



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare_search/models/appointment_model.dart';
import 'package:petcare_search/repository/userRepository.dart';

class AppointmentRepos
{
  static final AppointmentRepos _instance = AppointmentRepos._internal();
  factory AppointmentRepos() => _instance;
  static final db = FirebaseFirestore.instance;
 
  AppointmentRepos._internal() {
    // init things inside this
  }
  //Get all appointment for a user
  static Future<List<Appointment>> GetAllAppointmentForUser(String uid) async
  {
    //Get user ref
    DocumentReference userRef = await UserRepository.GetUserRefWithUID(uid);
    //Get all appointment for user
    QuerySnapshot querySnap = await db.collection("Appointments").where ("bookerUID", isEqualTo: userRef).get();
    //Convert to list of appointment
    List<Appointment> appointments = [];
    querySnap.docs.forEach((doc) {
      appointments.add(Appointment.fromJson(doc.data() as Map<String, dynamic>));
    });
    return appointments;
  }
  //Get all unfinished appointment for a user
  static Future<List<Appointment>> GetAllUnfinishedAppointmentForUser(String uid) async
  {
    //Get user ref
    DocumentReference userRef = await UserRepository.GetUserRefWithUID(uid);
    //Get all appointment for user
    QuerySnapshot querySnap = await db.collection("Appointments").where ("bookerUID", isEqualTo: userRef)
    .where ("finished", isEqualTo: false).get();
    //Convert to list of appointment
    List<Appointment> appointments = [];
    querySnap.docs.forEach((doc) {
      appointments.add(Appointment.fromJson(doc.data() as Map<String, dynamic>));
    });
    return appointments;
  }
  //Get all finished appointment for a user
  static Future<List<Appointment>> GetAllFinishedAppointmentForUser(String uid) async
  {
    //Get user ref
    DocumentReference userRef = await UserRepository.GetUserRefWithUID(uid);
    //Get all appointment for user
    QuerySnapshot querySnap = await db.collection("Appointments").where ("bookerUID", isEqualTo: userRef)
    .where ("finished", isEqualTo: true).get();
    //Convert to list of appointment
    List<Appointment> appointments = [];
    querySnap.docs.forEach((doc) {
      appointments.add(Appointment.fromJson(doc.data() as Map<String, dynamic>));
    });
    return appointments;
  }
  
  //Finish appointment/ Simply change status to finished 
  static Future<void> FinishAppointment(Appointment appointment) async
  {
    //Update appointment
    await db.collection("Appointments").where ("bookerUID", isEqualTo: appointment.bookerUID)
    .where ("bookedVetMail", isEqualTo: appointment.bookedVetMail)
    .where ("bookedDate", isEqualTo: appointment.bookedDate).get()
    .then((value) {
      value.docs.forEach((element) {
        element.reference.update({"finished": true});
      });
    });
    print("[APPOINTMENT REPOS] Appointment with date ${appointment.bookedDate} finished");
    return Future.value(null);
  }


  //Add appointment to db
  static Future<void> AddAppointment(Appointment appointment) async
  {
    //Add appointment
    await db.collection("Appointments").doc().set(appointment.toJson());
    print("[APPOINTMENT REPOS] Appointment on date ${appointment.bookedDate} added");
    return Future.value(null);
  }
  //Update appointment in db
  static Future<void> UpdateAppointment(Appointment appointment) async
  {
    //Update appointment
    await db.collection("Appointments").where ("bookerUID", isEqualTo: appointment.bookerUID)
    .where ("bookedVetMail", isEqualTo: appointment.bookedVetMail)
    .where ("bookedDate", isEqualTo: appointment.bookedDate).get()
    .then((value) {
      value.docs.forEach((element) {
        element.reference.update(appointment.toJson());
      });
    });
    print("[APPOINTMENT REPOS] Appointment with date ${appointment.bookedDate} updated");
    return Future.value(null);
  }
  //Remove appointment from db
  static Future<void> RemoveAppointment(Appointment appointment) async
  {
    //Remove appointment
    await db.collection("Appointments").where ("bookerUID", isEqualTo: appointment.bookerUID)
    .where ("bookedVetMail", isEqualTo: appointment.bookedVetMail)
    .where ("bookedDate", isEqualTo: appointment.bookedDate)
    .where ("finished", isEqualTo: appointment.finished).get()
    .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
    print("[APPOINTMENT REPOS] Appointment with date ${appointment.bookedDate} removed");
    return Future.value(null);
  }
  //Get appointment of a vet and a user. Only return one appointment
  //For debugging mostly
  static Future<Appointment?> GetUnfinishedAppointmentForVetAndUser(String uid, String vetMail) async
  {
    
    //Get appointment
    QuerySnapshot querySnap = await db.collection("Appointments").where ("bookerUID", isEqualTo: uid)
    .where ("bookedVetMail", isEqualTo: vetMail).where ("finished", isEqualTo: false).get();
    
    
    //Convert to list of appointment
    List<Appointment> appointments = [];
    querySnap.docs.forEach((doc) {
      appointments.add(Appointment.fromJson(doc.data() as Map<String, dynamic>));
    });
    if (appointments.length == 0)
      return null;
    return appointments[0];
  }
}