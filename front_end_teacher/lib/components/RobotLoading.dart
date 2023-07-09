import "package:flutter/material.dart";

class RobotLoading extends StatefulWidget {
  const RobotLoading({super.key});

  @override
  State<RobotLoading> createState() => _RobotLoadingState();
}

class _RobotLoadingState extends State<RobotLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 2,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.width / 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/img/robotloading.gif",
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 3.6,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Đang tải...',
                  style: TextStyle(
                      fontFamily: 'Mitr',
                      color: Color.fromARGB(255, 255, 247, 0),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
