import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class Calender extends StatelessWidget {
  final DateTime firstDate;
  final DateTime? focusDate;
  final DateTime lastDate;
  final void Function(DateTime)? onDateChange;
  const Calender(
      {required this.firstDate,
      required this.focusDate,
      required this.lastDate,
      required this.onDateChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);

    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.16,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [MyTheme.primaryColor, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.6]),
      ),

      ///* EasyInfiniteDateTimeLine
      child: EasyInfiniteDateTimeLine(
        locale: appConfigProvider.currentLanguage,
        timeLineProps: const EasyTimeLineProps(
            margin: EdgeInsets.only(top: 13),
            vPadding: 15,
            separatorPadding: 12,
            hPadding: 2),
        showTimelineHeader: false,
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
                color: (appConfigProvider.currentMode == ThemeMode.light)
                    ? MyTheme.primaryColor
                    : MyTheme.petrolColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          inactiveDayNumStyle: Theme.of(context).textTheme.titleMedium,
          todayStyle: DayStyle(
            dayNumStyle: Theme.of(context).textTheme.titleMedium,
            decoration: BoxDecoration(
                color: (appConfigProvider.currentMode == ThemeMode.light)
                    ? MyTheme.whiteColor
                    : MyTheme.blackColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
                color: (appConfigProvider.currentMode == ThemeMode.light)
                    ? MyTheme.whiteColor
                    : MyTheme.petrolColor,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        firstDate: firstDate,
        focusDate: focusDate,
        lastDate: lastDate,
        onDateChange: onDateChange,
      ),
    );
  }
}
