import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/core/widgets/home_appoinment_widget.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:emed/view/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.read<AuthCubit>().signout(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, top: 12.0, bottom: 12.0),
            width: 32.0,
            height: 32.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/person.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.kWhite,
        elevation: 0.5,
        foregroundColor: ColorConst.kMainBlue,
        title: SvgPicture.asset(
          'assets/icons/e-med_blue.svg',
          width: 80.0,
          height: 26.0,
        ),
        actions: [
          IconButton(
            splashRadius: 20.0,
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/notifications.svg'),
          ),
          const SizedBox(width: 4.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: EmedText(
                text: "Today's medications",
                size: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildMedicationWidget(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: EmedText(
                      text: "Monthly appointments",
                      size: FontConst.kMediumFont,
                      color: context.watch<HomeCubit>().isAppointment
                          ? ColorConst.kMainBlue
                          : const Color(0xFF6A6975),
                    ),
                    onPressed: () {
                      context.read<HomeCubit>().changeIsAppointmentStatus();
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDateTime = await showDatePicker(
                        context: context,
                        initialDate: context
                                .read<HomeCubit>()
                                .calendarCntrl
                                .selectedDate ??
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
                            .read<HomeCubit>()
                            .changeDateTime(pickedDateTime);
                        
                      }
                    },
                    child: Row(
                      children: [
                        EmedText(
                          text: DateFormat("MMMM yyyy").format(context
                                  .read<HomeCubit>()
                                  .calendarCntrl
                                  .selectedDate ??
                              DateTime.now()),
                          size: FontConst.kMediumFont,
                          color: ColorConst.kMainBlue,
                        ),
                        const SizedBox(width: 6.0),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: ColorConst.kMainBlue,
                          size: 16.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            context.watch<HomeCubit>().isAppointment
                ? vAppoinments(context)
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  StreamBuilder<Object> _buildMedicationWidget(BuildContext context) {
    return StreamBuilder<Object>(
      stream: context
          .read<HomeCubit>()
          .fetchMedications(context.read<AuthCubit>().userInfo!.id),
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
                const SizedBox(height: 108.0),
                Center(
                  child: EmedText(
                    text: "No medications",
                    size: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: EmedText(
                    text:
                        "They will appear here only when doctor\nadds them to your account.",
                    textAlign: TextAlign.center,
                    size: 16.0,
                  ),
                ),
                const SizedBox(height: 124.0),
              ],
            );
          }

          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) => FutureBuilder(
              future: context.read<HomeCubit>().fetchMedicationWithId(
                  snapshot.data.docs[index]['medication']),
              builder: (context, AsyncSnapshot medication) {
                if (medication.hasError) {
                  return Center(
                    child: EmedText(
                      text: "Error: ${medication.error}",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (medication.hasData) {
                  return ListTile(
                    onTap: () {},
                    minVerticalPadding: 4.0,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    leading: Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConst.kCian,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/pill.svg',
                      ),
                    ),
                    title: EmedText(
                      text: medication.data.data()['name'],
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 18.0,
                    ),
                    subtitle: EmedText(
                      text: medication.data.data()['description'],
                    ),
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
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Container(
                        width: 120.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: ColorConst.kLoadingColor,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Column vAppoinments(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SfCalendar(
            controller: context.watch<HomeCubit>().calendarCntrl,
            view: CalendarView.month,
            headerHeight: 0,
            firstDayOfWeek: 1,
            allowViewNavigation: false,
            allowDragAndDrop: true,
            onSelectionChanged: (selection) {
              context.read<HomeCubit>().changeDateTime(selection.date);
            },
          ),
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: EmedText(
            text:
                '${context.watch<HomeCubit>().calendarCntrl.selectedDate != DateTime.now() ? DateFormat("d MMMM yyyy").format(context.read<HomeCubit>().calendarCntrl.selectedDate ?? DateTime.now()) : "Today's"} appointments',
            size: 16.0,
            color: Colors.black,
          ),
        ),
        StreamBuilder<Object>(
          stream: context
              .read<HomeCubit>()
              .fetchDayAppoinments(context.read<AuthCubit>().userInfo!.id),
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
                        text: "No appointments",
                        size: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Center(
                      child: EmedText(
                        text: "You haven't added any appointment yet",
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
                padding: const EdgeInsets.only(top: 16.0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) => FutureBuilder(
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
                      return HomeAppoinmentWidget(
                        doctor: doctor.data.data(),
                        appoinmentTime: snapshot.data.docs[index]
                            ['appointment_time'],
                      );
                    }

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 20.0,
                          ),
                          leading: CircleAvatar(
                            radius: 32.0,
                            backgroundColor: ColorConst.kLoadingColor,
                          ),
                          title: Container(
                            width: 120.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: ColorConst.kLoadingColor,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              Container(
                                width: 120.0,
                                height: 18.0,
                                decoration: BoxDecoration(
                                  color: ColorConst.kLoadingColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                width: 120.0,
                                height: 18.0,
                                decoration: BoxDecoration(
                                  color: ColorConst.kLoadingColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                width: 120.0,
                                height: 18.0,
                                decoration: BoxDecoration(
                                  color: ColorConst.kLoadingColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(height: 0),
                        ),
                      ],
                    );
                  },
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  Padding textInputName(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: EmedText(
        text: name,
        size: FontConst.kMediumFont,
        textAlign: TextAlign.left,
      ),
    );
  }
}
