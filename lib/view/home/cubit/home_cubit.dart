import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emed/view/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int currentIndex = 0;
  bool isAppointment = true;
  final CalendarController calendarCntrl = CalendarController();

  changePageHome(index) {
    currentIndex = index;
    emit(HomeInitial());
  }

  changeIsAppointmentStatus() {
    isAppointment = !isAppointment;
    emit(HomeInitial());
  }

  changeDateTime(DateTime? date) {
    calendarCntrl.selectedDate = date;
    calendarCntrl.displayDate = date;
    emit(HomeInitial());
  }

  Future fetchDoctors() async {
    CollectionReference doctors = _firestore.collection('doctors');

    return await doctors.get();
  }

  Future fetchHospitals() async {
    CollectionReference hospitals = _firestore.collection('hospitals');

    return await hospitals.get();
  }

  fetchMedications(uid) {
    CollectionReference mediactions = _firestore.collection('user_medications');

    return mediactions.where("uid", isEqualTo: uid).snapshots();
  }

  Stream<Object> fetchDayAppoinments(uid) {
    CollectionReference appointments = _firestore.collection('appointments');

    return appointments
        .where("uid", isEqualTo: uid)
        .where(
          "appointment_date",
          isEqualTo: calendarCntrl.selectedDate != null
              ? calendarCntrl.selectedDate.toString()
              : DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ).toString(),
        )
        .snapshots();
  }

  Stream<Object> fetchAllAppoinments(uid) {
    CollectionReference appointments = _firestore.collection('appointments');

    return appointments.where("uid", isEqualTo: uid).snapshots();
  }

  Future fetchDoctorWithId(id) async {
    CollectionReference doctors = _firestore.collection('doctors');

    return await doctors.doc(id).get();
  }

  Future fetchMedicationWithId(id) async {
    CollectionReference mediactions = _firestore.collection('medications');

    return await mediactions.doc(id).get();
  }

  Future fetchMedicationsList() async {
    CollectionReference medications = _firestore.collection('medications');

    return await medications.get();
  }
}
