abstract class DoctorState {
  DoctorState();
}

class DoctorInitial extends DoctorState {
  DoctorInitial();
}

class DoctorLoading extends DoctorState {
  DoctorLoading();
}

class DoctorError extends DoctorState {
  String msg;
  DoctorError({required this.msg});
}
