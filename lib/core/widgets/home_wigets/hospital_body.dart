import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/view/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HospitalBody extends StatelessWidget {
  const HospitalBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
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
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF767680).withOpacity(.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: const Color(0xFF3C3C43).withOpacity(.6),
                    ),
                    const SizedBox(width: 8.0),
                    EmedText(
                      text: "Search doctors by name or position",
                      size: 16.0,
                      color: const Color(0xFF3C3C43).withOpacity(.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: context.read<HomeCubit>().fetchHospitals(),
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
                return Center(
                  child: EmedText(
                    text: "Data is empty!",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    EmedText(
                      text: "Recommended hospitals for you",
                      size: 16.0,
                    ),
                    const SizedBox(height: 12.0),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, "/infoHospital",
                              arguments: snapshot.data.docs[index]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 240.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data.docs[index]['image'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 12.0,
                                    left: 12.0,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0, horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.9),
                                            borderRadius:
                                                BorderRadius.circular(44.0),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/calendar.svg',
                                                width: 20.0,
                                              ),
                                              const SizedBox(width: 6.0),
                                              EmedText(
                                                text: snapshot.data.docs[index]
                                                    ['work_weekday'],
                                                size: 14.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.9),
                                            borderRadius:
                                                BorderRadius.circular(44.0),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                height: 24.0,
                                                child: Center(
                                                  child: Icon(
                                                    CupertinoIcons.clock,
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 4.0),
                                              EmedText(
                                                text: snapshot.data.docs[index]
                                                    ['work_time'],
                                                size: 14.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12.0),
                              EmedText(
                                text: snapshot.data.docs[index]['name'],
                                size: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              EmedText(
                                text: snapshot.data.docs[index]['location'],
                                size: 14.0,
                              ),
                              const SizedBox(height: 32.0),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
