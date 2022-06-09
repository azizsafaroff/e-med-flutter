abstract class TreatmentState {
  TreatmentState();
}

class TreatmentInitial extends TreatmentState {
  TreatmentInitial();
}

class TreatmentLoading extends TreatmentState {
  TreatmentLoading();
}

class TreatmentError extends TreatmentState {
  String msg;
  TreatmentError({required this.msg});
}
