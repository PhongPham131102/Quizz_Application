import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/personal_information/personal_information_contract.dart';
import 'package:frontend_flutter/features/personal_information/personal_information_presenter.dart';

import '../../components/Button.dart';
import '../../models/User.dart';
import '../change_password/change_password_view.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView>
    implements PersonalInformationContract {
  late PersonalInformationPresenter _presenter;
  _PersonalInformationViewState() {
    _presenter = PersonalInformationPresenter(this);
  }
  User? user;
  @override
  SetUser(User _user) {
    user = _user;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _presenter.GetUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
              ),
              Positioned(
                bottom: 0,
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 25,
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 7,
                      right: MediaQuery.of(context).size.width / 7),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/home/frame1.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Họ Và Tên",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 97, 5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(left: 12, right: 20),
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/img/home/textbutton2.png',
                                    ),
                                    fit: BoxFit.fill)),
                            child: Text(
                              user == null ? "đang tải..." : user!.fullName,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 122, 97, 5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 97, 5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(left: 12, right: 20),
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/img/home/textbutton2.png',
                                    ),
                                    fit: BoxFit.fill)),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                user == null ? "đang tải..." : user!.email,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 97, 5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Mật Khẩu",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 97, 5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(left: 12, right: 20),
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/img/home/textbutton2.png',
                                    ),
                                    fit: BoxFit.fill)),
                            child: Text(
                              "**************",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 122, 97, 5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonCustom(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ChangePassWordView(),
                                    );
                                  },
                                  child: Text(
                                    "Thay đổi mật khẩu",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(255, 122, 97, 5),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 10,
                right: MediaQuery.of(context).size.width / 10,
                top: 0,
                bottom: MediaQuery.of(context).size.height / 1.9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/home/personalinfo.gif"),
                          fit: BoxFit.fill)),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 15,
                  right: MediaQuery.of(context).size.width / 25,
                  child: ButtonCustom(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/img/home/closebutton.png"),
                              fit: BoxFit.fill)),
                    ),
                  ))
            ],
          ),
        ));
  }
}
