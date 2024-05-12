import 'package:flutter/material.dart';
import 'package:reminder_app/features/calendar/presentation/pages/add_task_page.dart';
import 'package:reminder_app/features/calendar/presentation/pages/all_tasks_page.dart';
import 'package:reminder_app/features/calendar/presentation/pages/completed_page.dart';
import 'package:reminder_app/features/calendar/presentation/pages/upcomming_page.dart';
import 'package:reminder_app/features/calendar/presentation/pages/urgent_page.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/botton_widget.dart';
import 'package:reminder_app/features/calendar/presentation/widgets/floating_button.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    _controller.initialPage == _currint;
    super.initState();
  }

  int _currint = 0;
  final PageController _controller = PageController();
  List<Widget> pages = [
    const AlltasksPage(),
    const UrgentPage(),
    const CompletedPage(),
    const UpcommingPage()
  ];
  List bottonModel = ["All", "Urgent", "Completed", "Upcomming"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10),
        child: FloatingWidget(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddtaskPge(),
            ));
          },
          icon: Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Welcome !',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BottonWidget(
                          text: bottonModel[index],
                          color: (_currint == index)
                              ? Colors.red
                              : Colors.transparent,
                          onPressed: () {
                            _controller.jumpToPage(
                              index,
                            );
                            //   duration: const Duration(seconds: 1),
                            //   curve: Curves.ease);
                            setState(() {
                              _currint = index;
                            });
                          },
                          textColor:
                              (_currint == index) ? Colors.white : Colors.black,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 6),
                  itemCount: bottonModel.length,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  onPageChanged: (int value) {
                    _currint = value;
                    setState(() {});
                  },
                  children: const [
                    AlltasksPage(),
                    UrgentPage(),
                    CompletedPage(),
                    UpcommingPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
