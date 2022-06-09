import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/widgets/appbar.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/core/widgets/errorsnackbar.dart';
import 'package:emed/view/hospital/cubit/hospital_cubit.dart';
import 'package:emed/view/hospital/state/hospital_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emed/core/extentions/context_extension.dart';

class EmedInfoHospitalView extends StatelessWidget {
  final dynamic hospital;
  const EmedInfoHospitalView({Key? key, required this.hospital})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EMedAppBar(
        title: "Hospital",
      ),
      body: BaseView(
        viewModal: EmedInfoHospitalView,
        onPageBuilder: (context, widget) {
          return BlocProvider<HospitalCubit>(
            create: (context) => HospitalCubit(),
            child: BlocConsumer<HospitalCubit, HospitalState>(
              listener: (context, state) {
                if (state is HospitalError) {
                  showErrorSnackBar(context, "Another Error");
                }
              },
              builder: (context, state) {
                if (state is HospitalInitial) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CircleAvatar(
                                radius: 70.0,
                                backgroundImage: NetworkImage(
                                  hospital['image'],
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              EmedText(
                                text: hospital['name'],
                                color: Colors.black,
                                size: 20.0,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24.0),
                              _buildItemBodyWidget(
                                "Phone number",
                                hospital['name'],
                              ),
                              const SizedBox(height: 16.0),
                              _buildItemBodyWidget(
                                  "Working time",
                                  hospital['work_weekday'] +
                                      "\n" +
                                      hospital['work_time']),
                              const SizedBox(height: 16.0),
                              _buildItemBodyWidget(
                                  "Location", hospital['location']),
                              const SizedBox(height: 16.0),
                              _buildItemBodyWidget(
                                  "Website", hospital['website']),
                              const SizedBox(height: 16.0),
                              if (hospital['doctors'].isNotEmpty)
                                EmedText(
                                  text: "Doctors at this hospital",
                                  size: 16.0,
                                ),
                              if (hospital['doctors'].isNotEmpty)
                                const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        if (hospital['doctors'].isNotEmpty)
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: hospital['doctors'].length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: context
                                    .read<HospitalCubit>()
                                    .fetchDoctorWithId(
                                        hospital['doctors'][index]),
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
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                              snapshot.data.data()['image'],
                                            ),
                                          ),
                                          title: EmedText(
                                            text: snapshot.data.data()['name'],
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            size: 16.0,
                                          ),
                                          subtitle: EmedText(
                                              text: snapshot.data
                                                  .data()['speciality']),
                                          trailing: const Icon(
                                              CupertinoIcons.forward),
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/infoDoctor',
                                              arguments: snapshot.data.data(),
                                            );
                                          },
                                        ),
                                        Divider(
                                          indent: context.w * 0.13,
                                          endIndent: 5,
                                          height: 0,
                                        ),
                                      ],
                                    );
                                  }

                                  return ListTile(
                                    minVerticalPadding: 4.0,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 24.0,
                                      backgroundColor: ColorConst.kLoadingColor,
                                    ),
                                    title: Container(
                                      width: 120.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        color: ColorConst.kLoadingColor,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8.0),
                                        Container(
                                          width: 120.0,
                                          height: 16.0,
                                          decoration: BoxDecoration(
                                            color: ColorConst.kLoadingColor,
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  );
                } else if (state is HospitalLoading) {
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
