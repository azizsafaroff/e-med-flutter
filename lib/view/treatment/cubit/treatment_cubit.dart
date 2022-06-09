import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emed/view/treatment/state/doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreatmentCubit extends Cubit<TreatmentState> {
  TreatmentCubit() : super(TreatmentInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future fetchDoctors() async {
    CollectionReference medications = _firestore.collection('medications');

    return await medications.get();
  }
}
