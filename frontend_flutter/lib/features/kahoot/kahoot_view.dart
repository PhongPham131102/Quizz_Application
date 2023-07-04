// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/kahoot/kahoot_contract.dart';
import 'package:frontend_flutter/features/kahoot/kahoot_presenter.dart';

import '../../components/Button.dart';
import '../../components/DialogMessage.dart';
import '../../components/RobotLoading.dart';

class KahootView extends StatefulWidget {
  const KahootView({super.key});

  @override
  State<KahootView> createState() => _KahootViewState();
}

class _KahootViewState extends State<KahootView> implements KahootContract {
  late KahootPresenter _presenter;
  bool isloading=false;
  TextEditingController nameController = TextEditingController();
  String validateName = "";
  bool haveRoom=false;
  _KahootViewState()
  {
    _presenter=KahootPresenter(this);
  }
   @override
  void setisloading(bool _isloading) {
    isloading = _isloading;
    setState(() {});
  }

  @override
  void setvalidateName(String _validateName) {
    validateName = _validateName;
    setState(() {});
  }
  @override
  void showDialog(String message) {
    DialogMessage(context, message);
  }
  @override
  void setHaveRoom() {
    haveRoom=true;
    nameController.text="";
    validateName="";
   if(mounted)
   {
    setState(() {
      
    });
   }
  }
  @override
  void initState() {
   _presenter.initSocket();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            IgnorePointer(
              ignoring: isloading,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/img/home/bg.png",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        width: 230,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/home/logo.gif"),
                                fit: BoxFit.fill)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(left: 35, right: 70, top: 40),
                            margin: EdgeInsets.only(top: 50),
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.height / 2.7,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/home/frame2.png"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      haveRoom?"Nhập Tên: ":"Nhập Mã Phòng:",
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color(0xFF502102),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: 8, left: 12, right: 20),
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/img/home/textbutton2.png',
                                                ),
                                                fit: BoxFit.fill)),
                                        child: TextField(
                                          controller: nameController,
                                          keyboardType:haveRoom?TextInputType.number:TextInputType.text,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 154, 122, 6)),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6))),
                                        ),
                                      ),
                                      validateName != ""
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: Text(
                                                validateName,
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.red,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Lưu Ý:",
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color(0xFFFF0303),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                Text(
                                  haveRoom?"Tên Nhân Vật Nên có kích thước phù hợp":"Mã phòng được giáo viên cung cấp.",
                                  maxLines: 2,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color(0xFF502102),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonCustom(
                                      onTap: () {
                                        if(haveRoom)
                                        {
                                          _presenter.sendName(nameController.text.trim());
                                        }else{
                                          _presenter.sendCodeRoom(nameController.text.trim());
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 140,
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/home/button.png"),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          "Tiếp theo",
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 30,
              top: MediaQuery.of(context).size.height / 20,
              child: ButtonCustom(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/store/return.png"),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            isloading
                ? Positioned(
                    child: ButtonCustom(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: RobotLoading(),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}