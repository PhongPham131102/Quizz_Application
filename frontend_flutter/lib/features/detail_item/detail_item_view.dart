// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:frontend_flutter/components/DialogMessage.dart';

import '../../components/Button.dart';
import '../../components/RobotLoading.dart';
import '../../models/Item.dart';
import '../../models/Profile.dart';
import 'detail_item_contract.dart';
import 'detail_item_presenter.dart';

class DetailItemView extends StatefulWidget {
  Profile userProfile;
  Item item;
  DetailItemView({super.key, required this.userProfile, required this.item});

  @override
  State<DetailItemView> createState() => _DetailItemViewState();
}

class _DetailItemViewState extends State<DetailItemView>
    implements DetailItemContract {
  late DetailItemPresenter _presenter;
  _DetailItemViewState() {
    _presenter = DetailItemPresenter(this);
  }
  int plusheight = 0;
  int quantity = 1;
  @override
  void initState() {
    if (this.widget.item.quantityPurchasable) {
      plusheight += 80;
    }
    super.initState();
  }

  @override
  setIsloading(bool _isLoading) {
    isloading = _isLoading;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  showMessage(String message, bool ispop, bool isbuy) {
    if (ispop && isbuy) {
      if (mounted) {
        Navigator.pop(context, quantity * this.widget.item.price);
      }
    } else if (ispop) {
      if (mounted) {
        Navigator.pop(context);
      }
    }
    DialogMessage(context, message);
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0x0000000),
      child: !isloading
          ? Center(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:
                        MediaQuery.of(context).size.height / 1.9 + plusheight,
                  ),
                  Positioned(
                      left: 10,
                      right: 10,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom:
                                (MediaQuery.of(context).size.height / 15) / 4),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 15,
                            bottom: MediaQuery.of(context).size.height / 15),
                        height: (MediaQuery.of(context).size.height / 1.9 -
                                MediaQuery.of(context).size.height / 12) +
                            plusheight,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/maingame/frame.png"),
                                fit: BoxFit.fill)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF742F00),
                                border: Border.all(
                                    width: 3, color: Color(0xFFA54403)),
                              ),
                              alignment:
                                  Alignment.center, // canh giữa container con
                              child: Image.asset(
                                "assets/img/store/${widget.item.shortName}.png",
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 7,
                              ),
                            ),
                            Text(
                              widget.item.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                ),
                                Positioned(
                                  top: 5,
                                  bottom: 5,
                                  right: 0,
                                  child: Container(
                                    width: 85,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color(0xFF3D8500),
                                          Color(0xFFE4E843),
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      "${widget.item.price * quantity}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: widget.item.typeMoney ==
                                                    "gold"
                                                ? AssetImage(
                                                    "assets/img/maingame/gold.gif")
                                                : AssetImage(
                                                    "assets/img/maingame/diamond.gif"),
                                            fit: BoxFit.fill)),
                                  ),
                                )
                              ],
                            ),
                            widget.item.quantityPurchasable
                                ? Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 237, 193, 164),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ButtonCustom(
                                          onTap: () {
                                            setState(() {
                                              quantity = quantity > 1
                                                  ? quantity - 1
                                                  : quantity;
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            alignment: Alignment.center,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 201, 83, 5),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 148, 63, 6),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          alignment: Alignment.center,
                                          height: 40,
                                          child: Text(
                                            '$quantity',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        ButtonCustom(
                                          onTap: () {
                                            setState(() {
                                              quantity = quantity < 10
                                                  ? quantity + 1
                                                  : quantity;
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            alignment: Alignment.center,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 201, 83, 5),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 148, 63, 6),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      )),
                  Positioned(
                    top: MediaQuery.of(context).size.height/50,
                    left: MediaQuery.of(context).size.height / 15,
                    right: MediaQuery.of(context).size.height / 15,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 80,
                      height: MediaQuery.of(context).size.height / 8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/historybattle/detail.gif"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 15,
                    right: MediaQuery.of(context).size.width / 30,
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
                                AssetImage("assets/img/store/closebutton.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3.5,
                    right: MediaQuery.of(context).size.width / 3.5,
                    bottom: 0,
                    child: ButtonCustom(
                      onTap: () => _presenter.BuyItem(
                          this.widget.item, this.widget.userProfile, quantity),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/img/maingame/button.png"),
                                fit: BoxFit.fill)),
                        child: Text(
                          "Mua",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: RobotLoading(),
            ),
    );
  }
}
