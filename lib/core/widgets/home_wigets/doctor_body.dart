import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/extentions/context_extension.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/view/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorBody extends StatelessWidget {
  const DoctorBody({Key? key}) : super(key: key);

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
        future: context.read<HomeCubit>().fetchDoctors(),
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
                      text: "No doctors",
                      size: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: EmedText(
                      text: "Doctors are not available yet",
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(height: 110.0),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: EmedText(
                      text: "Recommended doctors for you",
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                snapshot.data.docs[index]['image'],
                              ),
                            ),
                            title: EmedText(
                              text: snapshot.data.docs[index]['name'],
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              size: 16.0,
                            ),
                            subtitle: EmedText(
                                text: snapshot.data.docs[index]['speciality']),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/infoDoctor',
                                arguments: snapshot.data.docs[index],
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
                    },
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
