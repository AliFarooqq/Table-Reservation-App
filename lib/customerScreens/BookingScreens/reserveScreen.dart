import 'package:bookabite/core/utils/variables.dart';
import 'package:bookabite/customerScreens/BookingScreens/thkuScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReserveScreen extends StatefulWidget {
  final email;
  ReserveScreen({super.key, this.email});

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  DateTime _currentDate = DateTime.now();
  List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  List<String> _time = ['9 am', '1 pm', '4 pm', '8 pm', '12 pm'];
  int isSelected = 0;
  List<String> _people = ['1 - 2', '3 - 4', '5 - 6', '6 +'];
  int isSelected2 = 0;
  @override
  Widget build(BuildContext context) {
    int todayIndex = DateTime.now().weekday % 7; // 1 (Monday) - 7 (Sunday)

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekDays.asMap().entries.map((entry) {
                int idx = entry.key;
                String day = entry.value;
                bool isToday = idx == todayIndex;

                return Flexible(
                  child: Material(
                    elevation: isToday ? 3.0 : 0.0,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 20,
                      width: 38,
                      alignment: Alignment.center,
                      decoration: isToday
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          color: isToday ? Colors.red : Colors.black,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            TableCalendar(
              rowHeight: 30.0,
              daysOfWeekVisible: false,
              focusedDay: DateTime.now(),
              firstDay: DateTime(2020, 1, 1),
              lastDay: DateTime(2050, 12, 31),
              headerVisible: false,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) {
                  return DateFormat('E', locale).format(date).substring(0, 1);
                },
                weekdayStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                weekendStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              calendarStyle: CalendarStyle(
                rowDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  height: 0.5,
                  color: Colors.white,
                  fontSize: 12,
                ),
                todayDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                todayTextStyle: TextStyle(
                  height: 0.5,
                  color: Colors.red,
                  fontSize: 12,
                ),
                defaultTextStyle: TextStyle(
                  height: 0.5,
                  color: Colors.black,
                  fontSize: 12,
                ),
                weekendTextStyle: TextStyle(
                  height: 0.5,
                  color: Colors.black,
                  fontSize: 12,
                ),
                outsideTextStyle: TextStyle(
                  height: 0.5,
                  color: Colors.black,
                  fontSize: 12,
                ),
                outsideDaysVisible: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _time.asMap().entries.map((entry) {
                int idx = entry.key;
                String day = entry.value;

                return InkWell(
                  onTap: () {
                    print(idx);
                    isSelected = idx;
                    setState(() {});
                  },
                  child: Flexible(
                    child: Material(
                      elevation: isSelected == idx ? 3.0 : 0.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 36,
                        width: 38,
                        alignment: Alignment.center,
                        decoration: isSelected == idx
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              )
                            : null,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                isSelected == idx ? Colors.red : Colors.black,
                            fontWeight: isSelected == idx
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Number of people',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _people.asMap().entries.map((entry) {
                int idx = entry.key;
                String day = entry.value;

                return InkWell(
                  onTap: () {
                    print(idx);
                    isSelected2 = idx;
                    setState(() {});
                  },
                  child: Flexible(
                    child: Material(
                      elevation: isSelected2 == idx ? 3.0 : 0.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 36,
                        width: 38,
                        alignment: Alignment.center,
                        decoration: isSelected2 == idx
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              )
                            : null,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                isSelected2 == idx ? Colors.red : Colors.black,
                            fontWeight: isSelected2 == idx
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pay : 1500 Pkr',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    onPressed: () {
                      String docId =
                          '${Variables.emailUser}_${widget.email}_${DateTime.now().toString()}}';

                      FirebaseFirestore.instance
                          .collection('Orders')
                          .doc(docId)
                          .set({
                        'emailUser': Variables.emailUser,
                        'emailOwner': widget.email,
                        'date': _currentDate.toString(),
                        'time': _time[isSelected].toString(),
                        'people': _people[isSelected2].toString(),
                        'status': 'Pending',
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThkuScreen()));
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
