import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/widgets/appbar.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/core/widgets/errorsnackbar.dart';
import 'package:emed/view/doctor/cubit/doctor_cubit.dart';
import 'package:emed/view/doctor/state/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmedInfoDrugWidget extends StatelessWidget {
  final dynamic drug;
  const EmedInfoDrugWidget({Key? key, required this.drug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EMedAppBar(
        title: "Taken drug details",
      ),
      body: BaseView(
        viewModal: EmedInfoDrugWidget,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildItemBodyWidget("Drug name", drug[1]['name']),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget("Dose", drug[0]['amount']),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget("Taking dates (start-end)", "${DateFormat("yyyy-MM-dd").format(DateTime.parse(drug[0]['from']))} - ${DateFormat("yyyy-MM-dd").format(DateTime.parse(drug[0]['to']))}"),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget("How many times", drug[1]['description']),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget("Associated with", "Multiple sclerosis"),
                        const SizedBox(height: 16.0),
                        _buildItemBodyWidget("Comments", drug[1]['body']),
                        const SizedBox(height: 16.0),
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
