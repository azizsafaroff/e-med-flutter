import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emed/view/hospital/state/hospital_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalCubit extends Cubit<HospitalState> {
  HospitalCubit() : super(HospitalInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future fetchDoctorWithId(id) async {
    CollectionReference doctors = _firestore.collection('doctors');

    return await doctors.doc(id).get();
  }
}
