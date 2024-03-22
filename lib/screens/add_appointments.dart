import 'package:app/components/button.dart';
import 'package:app/consts/profile.dart';
import 'package:app/models/booking.dart';
import 'package:app/models/selected_booking.dart';
import 'package:app/repositories/booking_repository.dart';
import 'package:app/service/auth.dart';
import 'package:app/utils/numbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddAppointments extends StatefulWidget {
  final SelectedBooking selectedBooking;

  const AddAppointments({super.key, required this.selectedBooking});

  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  String _hour = '';
  String _typePayment = 'Pix';

  List<String> availableTimes = [];

  List<String> getAvailableHours() {
    availableTimes = [];

    DateTime now = _selectedDay;

    int startHour = 8;
    int endHour = 17;

    for (int hour = startHour; hour <= endHour; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        DateTime currentHour = DateTime(now.year, now.month, now.day, hour, minute);

        if (currentHour.isAfter(now)) {
          String formattedHour = hour.toString().padLeft(2, '0');
          String formattedMinute = minute.toString().padLeft(2, '0');

          availableTimes.add('$formattedHour:$formattedMinute');
        }
      }
    }

    return availableTimes;
  }

  void updateAvailableHours(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      availableTimes = getAvailableHours();
    });
  }

  void updateAvailableHoursToday() {
    setState(() {
      _selectedDay = DateTime.now();
      availableTimes = getAvailableHours();
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    updateAvailableHoursToday();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthServiceProvider>().loggedUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendamento',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.selectedBooking.worker.avatarUrl ?? ProfileConst.avatarUrl),
                  radius: 32,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedBooking.worker.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.selectedBooking.service.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$ ${formatMoney(widget.selectedBooking.value)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Colors.deepOrange),
                    ),
                    const Text(
                      '/hora',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            ),
            TableCalendar(
              rowHeight: 40,
              locale: 'pt_BR',
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
              ),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(selectedDay, _selectedDay)) {
                  if (isSameDay(selectedDay, DateTime.now())) {
                    updateAvailableHoursToday();
                  } else {
                    updateAvailableHours(selectedDay);
                  }
                }
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: Center(
                child: Text(
                  'Selecione um horário',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  final isSelected = _hour == availableTimes[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _hour = availableTimes[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.deepOrangeAccent
                              : Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.deepOrangeAccent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            availableTimes[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.deepOrangeAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Forma de Pagamento',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _typePayment == 'Pix' ? Icons.pix_sharp : Icons.credit_card,
                            size: 32,
                            color: _typePayment == 'Pix' ? const Color.fromRGBO(33, 154, 122, 1) : Colors.black54,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            _typePayment,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Mudar',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Button(
              isDisabled: _hour == '',
              title: 'Agendar',
              onPressed: () async {
                String dateString = _selectedDay.toString();
                String timeString = _hour;

                List<String> dateComponents = dateString.split(' ')[0].split('-');
                int year = int.parse(dateComponents[0]);
                int month = int.parse(dateComponents[1]);
                int day = int.parse(dateComponents[2]);

                List<String> timeComponents = timeString.split(':');
                int hour = int.parse(timeComponents[0]);
                int minute = int.parse(timeComponents[1]);

                DateTime dateTime = DateTime(year, month, day, hour, minute);

                Booking booking = Booking(
                  userId: user!.id,
                  workerId: widget.selectedBooking.worker.id,
                  categoryId: widget.selectedBooking.category.id,
                  serviceId: widget.selectedBooking.service.id,
                  data: dateTime.toString(),
                  typePayment: _typePayment,
                  value: widget.selectedBooking.value,
                  status: 'Pendente',
                );

                await BookingRepository().insertData(booking);

                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
