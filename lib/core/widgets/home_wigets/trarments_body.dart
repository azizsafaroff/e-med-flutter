import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/extentions/context_extension.dart';
import 'package:emed/core/widgets/treatment_tabs/current_treatment_widget.dart';
import 'package:emed/core/widgets/treatment_tabs/drug_history_widget.dart';
import 'package:emed/core/widgets/treatment_tabs/medical_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrarmentsBody extends StatelessWidget {
  TrarmentsBody({Key? key}) : super(key: key);

  final List<Widget> bodies = [
    const CurrentTreatmentsWidget(),
    const MedicalHistoryWidget(),
    const DrugHistoryWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: TabBar(
            isScrollable: true,
            labelColor: ColorConst.kMainBlue,
            unselectedLabelColor: const Color(0xFF6A6975),
            indicatorColor: ColorConst.kMainBlue,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.5,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            labelStyle: const TextStyle(
              fontSize: 16.0,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16.0,
            ),
            tabs: const [
              Tab(
                text: "Current treatment",
              ),
              Tab(
                text: "Medical history",
              ),
              Tab(
                text: "Drug history",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: bodies,
        ),
      ),
    );
  }
}
