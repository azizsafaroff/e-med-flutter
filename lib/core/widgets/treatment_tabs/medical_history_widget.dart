import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:emed/view/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalHistoryWidget extends StatelessWidget {
  const MedicalHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: context
          .read<HomeCubit>()
          .fetchAllAppoinments(context.read<AuthCubit>().userInfo!.id),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: EmedText(
              text: "Error: ${snapshot.error}",
              textAlign: TextAlign.center,
            ),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data.docs.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 110),
                Center(
                  child: EmedText(
                    text: "No medical history",
                    size: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: EmedText(
                    text: "You have not yet been treated for any illness",
                    size: 16.0,
                  ),
                ),
                const SizedBox(height: 110.0),
              ],
            );
          }

          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: context
                    .read<HomeCubit>()
                    .fetchDoctorWithId(snapshot.data.docs[index]['doctor']),
                builder: (context, AsyncSnapshot doctor) {
                  if (doctor.hasError) {
                    return Center(
                      child: EmedText(
                        text: "Error: ${doctor.error}",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (doctor.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/infoTreatment",
                                arguments: doctor.data.data());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: EmedText(
                                        text: doctor.data.data()['speciality'],
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        size: 18.0,
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      size: 16.0,
                                      color: const Color(0xFF6A6975)
                                          .withOpacity(.6),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                EmedText(
                                  text: doctor.data.data()['name'],
                                  color: Colors.black,
                                  size: 16.0,
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: EmedText(
                                        text: doctor.data.data()['place_work'],
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    EmedText(
                                      text: DateTime.parse(snapshot.data
                                              .docs[index]['appointment_date'])
                                          .toString()
                                          .split(' ')
                                          .first,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Divider(
                            endIndent: 5,
                            height: 0,
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 240.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: ColorConst.kLoadingColor,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    width: 160.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: ColorConst.kLoadingColor,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 160.0,
                                        height: 16.0,
                                        decoration: BoxDecoration(
                                          color: ColorConst.kLoadingColor,
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                      ),
                                      Container(
                                        width: 80.0,
                                        height: 16.0,
                                        decoration: BoxDecoration(
                                          color: ColorConst.kLoadingColor,
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Divider(
                          endIndent: 5,
                          height: 0,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
