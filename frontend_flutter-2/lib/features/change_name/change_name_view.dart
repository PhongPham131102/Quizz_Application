import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/change_name/change_name_contract.dart';
import 'package:frontend_flutter/features/change_name/change_name_presenter.dart';

import '../../components/DialogMessage.dart';

class ChangeNameView extends StatefulWidget {
  String idItem;

  ChangeNameView({super.key, required this.idItem});

  @override
  State<ChangeNameView> createState() => _ChangeNameViewState();
}

class _ChangeNameViewState extends State<ChangeNameView>
    implements ChangeNameContract {
  late ChangeNamePresenter _presenter;
  _ChangeNameViewState() {
    _presenter = ChangeNamePresenter(this);
  }
  TextEditingController nameController = TextEditingController();
  String validateName = "";
  bool isloading = false;
  @override
  void setisloading(bool _isloading) {
    isloading = _isloading;
    setState(() {});
  }

  @override
  updateNameSucces() {
    Navigator.pop(context,1);
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
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            IgnorePointer(
              ignoring: isloading,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 35, right: 70, top: 40),
                                margin: EdgeInsets.only(top: 50),
                                width: MediaQuery.of(context).size.width - 40,
                                height:
                                    MediaQuery.of(context).size.height / 2.7,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nhập tên nhân vật:",
                                          style: TextStyle(
                                              color: Color(0xFF502102),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
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
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6)),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromARGB(
                                                          255, 154, 122, 6))),
                                            ),
                                          ),
                                          validateName != ""
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    validateName,
                                                    style: TextStyle(
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
                                              color: Color(0xFFFF0303),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Tên nhân vật không quá 15 ký tự",
                                      maxLines: 2,
                                      softWrap: true,
                                      style: TextStyle(
                                          color: Color(0xFF502102),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () => _presenter.SetName(
                                              nameController.text.trim(),
                                              this.widget.idItem),
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
                                              "Đổi Tên",
                                              style: TextStyle(
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
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height / 12,
                              right: MediaQuery.of(context).size.width / 12,
                              child: GestureDetector(
                                onTap: () =>   Navigator.pop(context),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/store/closebutton.png"),
                                          fit: BoxFit.fill)),
                                ),
                              ))
                        ],
                      )
                    ]),
              ),
            ),
            isloading
                ? Positioned(
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
