import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/components/input_comp.dart';
import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/widgets/appbar.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:emed/view/doctor/cubit/doctor_cubit.dart';
import 'package:emed/view/doctor/state/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EmedConfirmDoctorView extends StatelessWidget {
  final dynamic doctor;
  const EmedConfirmDoctorView({Key? key, required this.doctor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: EMedAppBar(
        title: "Book an appointment",
      ),
      body: BaseView(
        viewModal: EmedConfirmDoctorView,
        onPageBuilder: (context, widget) {
          return BlocProvider<DoctorCubit>(
            create: (context) => DoctorCubit(),
            lazy: true,
            child: BlocConsumer<DoctorCubit, DoctorState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 24.0),
                  child: Form(
                    key: context.read<DoctorCubit>().formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        EmedText(
                          text: "Appointment to:",
                          size: 18.0,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundImage: NetworkImage(doctor['image']),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    size: 16.0,
                                  ),
                                  const SizedBox(height: 4.0),
                                  EmedText(
                                    text: doctor['place_work'],
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(),
                        const SizedBox(height: 20.0),
                        EmedText(
                          text: "Enter the time",
                          color: Colors.black,
                          size: 16.0,
                        ),
                        const SizedBox(height: 8.0),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDateTime = await showDatePicker(
                              context: context,
                              initialDate:
                                  context.read<DoctorCubit>().dateTimePicker ??
                                      DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                      ),
                              firstDate: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ),
                              lastDate: DateTime(2030),
                            );

                            if (pickedDateTime != null) {
                              context
                                  .read<DoctorCubit>()
                                  .changeDateTime(pickedDateTime);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: const Color(0xFF6A6975),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  width: 24.0,
                                ),
                                EmedText(
                                  text: context
                                              .read<DoctorCubit>()
                                              .dateTimePicker !=
                                          null
                                      ? context
                                          .read<DoctorCubit>()
                                          .dateTimePicker
                                          .toString()
                                          .split(' ')
                                          .first
                                      : "DD.MM.YYYY",
                                  size: 16.0,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 26.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        EmedText(
                          text: "Enter the time",
                          color: Colors.black,
                          size: 16.0,
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: context.read<DoctorCubit>().timeCntrl,
                          decoration: InputComp.inputDecoration(
                            hintText: "HH:MM - HH:MM",
                          ),
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '##:## ##:##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy)
                          ],
                          keyboardType: TextInputType.number,
                          validator: (text) {
                            if (text!.length < 11) {
                              return "Please, enter the appoinment time!";
                            }
                          },
                        ),
                        const Spacer(),
                        RoundedLoadingButton(
                          animateOnTap: true,
                          controller: context.read<DoctorCubit>().btnController,
                          color: ColorConst.kMainBlue,
                          onPressed: () {
                            if (context
                                .read<DoctorCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<DoctorCubit>().addAppointment(
                                    context,
                                    context.read<AuthCubit>().userInfo!.id!,
                                    doctor['id'],
                                  );
                            } else {
                              context.read<DoctorCubit>().btnController.reset();
                            }
                          },
                          width: MediaQuery.of(context).size.width * 1.0,
                          elevation: 0,
                          child: EmedText(
                            text: 'Continue',
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
