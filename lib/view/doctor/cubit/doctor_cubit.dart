import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emed/view/doctor/state/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final timeCntrl = TextEditingController();
  DateTime? dateTimePicker;

  changeDateTime(DateTime? date) {
    dateTimePicker = date;
    emit(DoctorInitial());
  }

  Future addAppointment(
    context,
    String uid,
    String id,
  ) async {
    btnController.start();
    CollectionReference appoinments = _firestore.collection('appointments');

    return await appoinments.add({
      'appointment_date': dateTimePicker == null
          ? DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).toString()
          : dateTimePicker.toString(),
      'appointment_time': timeCntrl.text.trim(),
      'doctor': id,
      'uid': uid,
    }).then((value) {
      btnController.success();

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }).catchError((error) {
      btnController.stop();
    });
  }
}
