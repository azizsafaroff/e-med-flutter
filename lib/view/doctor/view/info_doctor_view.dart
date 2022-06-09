import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/widgets/appbar.dart';
import 'package:emed/core/widgets/emed_button.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/core/widgets/errorsnackbar.dart';
import 'package:emed/view/doctor/cubit/doctor_cubit.dart';
import 'package:emed/view/doctor/state/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmedInfoDoctorView extends StatelessWidget {
  final dynamic doctor;
  const EmedInfoDoctorView({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EMedAppBar(
        title: "Doctor",
      ),
      body: BaseView(
        viewModal: EmedInfoDoctorView,
        onPageBuilder: (context, widget) {
          return BlocProvider<DoctorCubit>(
            create: (context) => DoctorCubit(),
            child: BlocConsumer<DoctorCubit, DoctorState>(
              listener: (context, state) {
                if (state is DoctorError) {
                  showErrorSnackBar(context, "Another Error");
                }
              },
              builder: (context, state) {
                if (state is DoctorInitial) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          radius: 70.0,
                          backgroundImage: NetworkImage(doctor['image']),
                        ),
                        const SizedBox(height: 24.0),
                        EmedText(
                          text: doctor['name'],
                          color: Colors.black,
                          size: 20.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        EmedText(
                          text: doctor['speciality'],
                          color: Colors.black,
                          size: 16.0,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 76.0),
                        _buildItemBodyWidget(
                          "Place of work",
                          doctor['place_work'],
                        ),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget(
                          "Work location",
                          doctor['location_work'],
                        ),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget(
                            "Available time", doctor['time_work']),
                        const SizedBox(height: 16.0),
                        EMedBlueButton(
                            index: 1,
                            text: 'Book an appointment',
                            currentPage: 1,
                            onpressed: () {
                              Navigator.pushNamed(context, '/confirmDoctor', arguments: doctor);
                            }),
                      ],
                    ),
                  );
                } else if (state is DoctorLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  return showErrorSnackBar(context, "Another Error");
                }
              },
            ),
          );
        },
      ),
    );
  }

  Column _buildItemBodyWidget(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EmedText(
          text: title,
          size: 16.0,
        ),
        const SizedBox(height: 4.0),
        EmedText(
          text: description,
          size: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
