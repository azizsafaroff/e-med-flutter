abstract class HospitalState {
  HospitalState();
}

class HospitalInitial extends HospitalState {
  HospitalInitial();
}

class HospitalLoading extends HospitalState {
  HospitalLoading();
}

class HospitalError extends HospitalState {
  String msg;
  HospitalError({required this.msg});
}
