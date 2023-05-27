import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/store/store_contract.dart';
import 'package:frontend_flutter/features/store/store_presenter.dart';

import '../../components/DialogMessage.dart';
import '../../models/Item.dart';
import '../../models/Profile.dart';
import '../../models/UserItem.dart';

class StoreView extends StatefulWidget {
  Profile userProfile;
  StoreView({super.key, required this.userProfile});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView>
    with SingleTickerProviderStateMixin
    implements StoreContract {
  late StorePresenter _presenter;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool isloading = false;
  bool _isDropDown = false;
  List<Item>? items;
  String? type;
  String? detailType;
  List<String> types = [];
  List<String> detailTypes = [];
  List<Item>? itemsfilter;
  List<UsersItem> usersitemlist = [];
  List<String> UsersidItems = [];
  String _selectedItem = "Tất cả";
  int selectedindex = 0;
  _StoreViewState() {
    _presenter = StorePresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.ease));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExpanded() {
    _controller.isDismissed ? _controller.forward() : _controller.reverse();
    _isDropDown = !_isDropDown;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/mainbgstore.jpg"),
                    fit: BoxFit.fill)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 10,
                              alignment: Alignment.center,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: MediaQuery.of(context).size.height / 10,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("img/shoptitle.png"),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 20,
                              bottom: 20,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("img/return.png"),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 40,
                                    ),
                                    Positioned(
                                      top: 8,
                                      bottom: 8,
                                      right: 0,
                                      child: Container(
                                        width: 120,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "img/buttoncoin.png"),
                                                fit: BoxFit.fill)),
                                        child: Text(
                                          this
                                              .widget
                                              .userProfile
                                              .gold
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 2.5,
                                      bottom: 2.5,
                                      left: 0,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage("img/gold.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 40,
                                    ),
                                    Positioned(
                                      top: 8,
                                      bottom: 8,
                                      right: 0,
                                      child: Container(
                                        width: 120,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "img/buttoncoin.png"),
                                                fit: BoxFit.fill)),
                                        child: Text(
                                          this
                                              .widget
                                              .userProfile
                                              .diamond
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      bottom: 5,
                                      left: 0,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "img/diamond.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "img/character/male.png",
                                width:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      color: Color(0xFFDA7931),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        topRight: const Radius.circular(15.0),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFFDA),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(13.0),
                          topRight: const Radius.circular(13.0),
                        ),
                      ),
                      child: !isloading
                          ? Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 15),
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xFF9D4E0B),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 195, 112, 49),
                                            width: 4)),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: types.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            selectedindex = index;
                                            detailTypes = items!
                                                .where((item) =>
                                                    item.type ==
                                                    types[selectedindex])
                                                .map((item) => item.detailType)
                                                .toSet()
                                                .toList();
                                            _selectedItem = "Tất cả";
                                            type = types[selectedindex];
                                            itemsfilter = items!
                                                .where((a) => a.type == type)
                                                .toList();
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40) /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: selectedindex == index
                                                  ? Color(0xFFFFAD4A)
                                                  : Color(0xFF9D4E0B),
                                            ),
                                            child: Text(
                                              types[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2 -
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          padding: EdgeInsets.only(top: 35),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2 -
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  9,
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: (itemsfilter!.length / 2)
                                                .ceil(),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    if (index * 2 <
                                                        itemsfilter!.length)
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2.1,
                                                            height: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        2 -
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        10) /
                                                                1.3,
                                                          ),
                                                          Container(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2.1,
                                                            height: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        2 -
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        10) /
                                                                1.4,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Color(
                                                                    0xFF502102),
                                                                border:
                                                                    Border.all(
                                                                        color: Color(
                                                                            0xFFA24505),
                                                                        width:
                                                                            5)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  itemsfilter![
                                                                          index *
                                                                              2]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                                Image.asset(
                                                                  "img/shop/${itemsfilter![index * 2].shortName}.png",
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          30) /
                                                                      3.5,
                                                                  height: (MediaQuery.of(context).size.height /
                                                                              2 -
                                                                          MediaQuery.of(context).size.height /
                                                                              10) /
                                                                      3,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          35,
                                                                    ),
                                                                    Positioned(
                                                                      top: 2,
                                                                      bottom: 2,
                                                                      right: 0,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            90,
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15.0)),
                                                                          gradient:
                                                                              LinearGradient(
                                                                            begin:
                                                                                Alignment.bottomCenter,
                                                                            end:
                                                                                Alignment.topCenter,
                                                                            colors: [
                                                                              Color(0xFF3D8500),
                                                                              Color(0xFFE4E843),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "${itemsfilter![index * 2].price}",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w800),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      top: 2.5,
                                                                      bottom:
                                                                          2.5,
                                                                      left: 0,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        decoration:
                                                                            BoxDecoration(image: DecorationImage(image: AssetImage("img/${itemsfilter![index * 2].typeMoney}.png"), fit: BoxFit.fill)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                              bottom: 0,
                                                              left: 25,
                                                              right: 25,
                                                              child: itemsfilter![
                                                                          index *
                                                                              2]
                                                                      .quantityPurchasable
                                                                  ? GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        final data = await showDialog(
                                                                            context: context,
                                                                            builder: (context) => DialogDetailItem(
                                                                                  userProfile: this.widget.userProfile,
                                                                                  item: itemsfilter![index * 2],
                                                                                ));
                                                                        if (data !=
                                                                            null) {
                                                                          if (itemsfilter![index * 2].typeMoney ==
                                                                              "gold") {
                                                                            widget.userProfile.gold -=
                                                                                data as int;
                                                                          } else {
                                                                            widget.userProfile.diamond -=
                                                                                data as int;
                                                                          }
                                                                          GetAllItem();
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          height: 35,
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/button.png"))),
                                                                          child: Text(
                                                                            "Mua",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w800),
                                                                          )),
                                                                    )
                                                                  : (UsersidItems.contains(
                                                                          itemsfilter![index * 2]
                                                                              .id))
                                                                      ? Container(
                                                                          height:
                                                                              35,
                                                                          alignment: Alignment
                                                                              .center,
                                                                          decoration:
                                                                              BoxDecoration(image: DecorationImage(image: AssetImage("img/button.png"))),
                                                                          child: Text(
                                                                            "Đã Sỡ Hữu",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w800),
                                                                          ))
                                                                      : GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            final data = await showDialog(
                                                                                context: context,
                                                                                builder: (context) => DialogDetailItem(
                                                                                      userProfile: this.widget.userProfile,
                                                                                      item: itemsfilter![index * 2],
                                                                                    ));
                                                                            if (data !=
                                                                                null) {
                                                                              if (itemsfilter![index * 2].typeMoney == "gold") {
                                                                                widget.userProfile.gold -= data as int;
                                                                              } else {
                                                                                widget.userProfile.diamond -= data as int;
                                                                              }
                                                                              GetAllItem();
                                                                            }
                                                                          },
                                                                          child: Container(
                                                                              height: 35,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/button.png"))),
                                                                              child: Text(
                                                                                "Mua",
                                                                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
                                                                              )),
                                                                        ))
                                                        ],
                                                      ),
                                                    if (index * 2 + 1 <
                                                        itemsfilter!.length)
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2.1,
                                                            height: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        2 -
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        10) /
                                                                1.3,
                                                          ),
                                                          Container(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2.1,
                                                            height: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        2 -
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        10) /
                                                                1.4,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Color(
                                                                    0xFF502102),
                                                                border:
                                                                    Border.all(
                                                                        color: Color(
                                                                            0xFFA24505),
                                                                        width:
                                                                            5)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  itemsfilter![
                                                                          index *
                                                                              2]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                                Image.asset(
                                                                  "img/shop/${itemsfilter![index * 2 + 1].shortName}.png",
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          30) /
                                                                      3.5,
                                                                  height: (MediaQuery.of(context).size.height /
                                                                              2 -
                                                                          MediaQuery.of(context).size.height /
                                                                              10) /
                                                                      3,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          35,
                                                                    ),
                                                                    Positioned(
                                                                      top: 2,
                                                                      bottom: 2,
                                                                      right: 0,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            90,
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15.0)),
                                                                          gradient:
                                                                              LinearGradient(
                                                                            begin:
                                                                                Alignment.bottomCenter,
                                                                            end:
                                                                                Alignment.topCenter,
                                                                            colors: [
                                                                              Color(0xFF3D8500),
                                                                              Color(0xFFE4E843),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "${itemsfilter![index * 2 + 1].price}",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w800),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      top: 2.5,
                                                                      bottom:
                                                                          2.5,
                                                                      left: 0,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        decoration:
                                                                            BoxDecoration(image: DecorationImage(image: AssetImage("img/${itemsfilter![index * 2 + 1].typeMoney}.png"), fit: BoxFit.fill)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 25,
                                                            right: 25,
                                                            child: itemsfilter![
                                                                        index *
                                                                            2]
                                                                    .quantityPurchasable
                                                                ? GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      final data = await showDialog(
                                                                          context: context,
                                                                          builder: (context) => DialogDetailItem(
                                                                                userProfile: this.widget.userProfile,
                                                                                item: itemsfilter![index * 2 + 1],
                                                                              ));
                                                                      if (data !=
                                                                          null) {
                                                                        if (itemsfilter![index * 2 + 1].typeMoney ==
                                                                            "gold") {
                                                                          widget
                                                                              .userProfile
                                                                              .gold -= data as int;
                                                                        } else {
                                                                          widget
                                                                              .userProfile
                                                                              .diamond -= data as int;
                                                                        }
                                                                        GetAllItem();
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                        height: 35,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/button.png"))),
                                                                        child: Text(
                                                                          "Mua",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w800),
                                                                        )),
                                                                  )
                                                                : (UsersidItems.contains(
                                                                        itemsfilter![index * 2 +
                                                                                1]
                                                                            .id))
                                                                    ? Container(
                                                                        height:
                                                                            35,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        decoration:
                                                                            BoxDecoration(image: DecorationImage(image: AssetImage("img/button.png"))),
                                                                        child: Text(
                                                                          "Đã Sỡ Hữu",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w800),
                                                                        ))
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          final data = await showDialog(
                                                                              context: context,
                                                                              builder: (context) => DialogDetailItem(
                                                                                    userProfile: this.widget.userProfile,
                                                                                    item: itemsfilter![index * 2 + 1],
                                                                                  ));
                                                                          if (data !=
                                                                              null) {
                                                                                print(data);
                                                                            if (itemsfilter![index * 2 + 1].typeMoney ==
                                                                                "gold") {
                                                                              widget.userProfile.gold -= data as int;
                                                                            } else {
                                                                              widget.userProfile.diamond -= data as int;
                                                                            }
                                                                            GetAllItem();
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                            height: 35,
                                                                            alignment: Alignment.center,
                                                                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/button.png"))),
                                                                            child: Text(
                                                                              "Mua",
                                                                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
                                                                            )),
                                                                      ),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 150,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2 -
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: toggleExpanded,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width: 100,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFe18422),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft: const Radius
                                                                .circular(5),
                                                            bottomLeft:
                                                                const Radius
                                                                    .circular(5),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 100,
                                                          height: 35,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 2,
                                                                  left: 2,
                                                                  bottom: 2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    195,
                                                                    112,
                                                                    49),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: const Radius
                                                                  .circular(5),
                                                              bottomLeft:
                                                                  const Radius
                                                                      .circular(5),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            _selectedItem,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        )),
                                                    Container(
                                                      width: 36,
                                                      height: 36,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: _isDropDown
                                                              ? AssetImage(
                                                                  "img/up.png")
                                                              : AssetImage(
                                                                  "img/down.png"),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizeTransition(
                                                axisAlignment: 1.0,
                                                sizeFactor: _heightFactor,
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      color: Color(0xFF9D4E0B)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ...detailTypes
                                                          .map((e) => InkWell(
                                                                onTap: () {
                                                                  _selectedItem =
                                                                      e;
                                                                  itemsfilter = items!
                                                                      .where((a) =>
                                                                          a.type ==
                                                                          type)
                                                                      .where((element) =>
                                                                          element
                                                                              .detailType ==
                                                                          _selectedItem)
                                                                      .toList();
                                                                  toggleExpanded();
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 100,
                                                                  height: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFDA7931),
                                                                  ),
                                                                  child: Text(
                                                                    "$e",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w800),
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ])));
  }
}

class DialogDetailItem extends StatefulWidget {
  Profile userProfile;
  Item item;
  DialogDetailItem({super.key, required this.userProfile, required this.item});

  @override
  State<DialogDetailItem> createState() => _DialogDetailItemState();
}

class _DialogDetailItemState extends State<DialogDetailItem> {
  int plusheight = 0;
  int quantity = 1;
  @override
  void initState() {
    if (this.widget.item.quantityPurchasable) {
      plusheight += 80;
    }
    super.initState();
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
                                image: AssetImage("img/frame.png"),
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
                                "img/shop/${widget.item.shortName}.png",
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
                                            image: widget.item.typeMoney == "gold"?AssetImage("img/gold.png"):AssetImage("img/diamond.png"),
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
                                        GestureDetector(
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
                                        GestureDetector(
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
                    left: MediaQuery.of(context).size.height / 15,
                    right: MediaQuery.of(context).size.height / 15,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 80,
                      height: MediaQuery.of(context).size.height / 8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("img/detail.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 15,
                    right: MediaQuery.of(context).size.width / 30,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("img/closebutton.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3.5,
                    right: MediaQuery.of(context).size.width / 3.5,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.item.typeMoney == "gold") {
                          if (widget.userProfile.gold >=
                              quantity * widget.item.price) {
                            setState(() {
                              isloading = true;
                            });
                            bool isBuy = await UsersItemController()
                                .buyItem(this.widget.item.id, quantity);
                            setState(() {
                              isloading = false;
                            });
                            if (isBuy) {
                              Navigator.pop(context, quantity * widget.item.price);
                              DialogMessage(
                                  context, "Mua vật phẩm thành công!");
                            } else {
                              Navigator.pop(context);
                              DialogMessage(
                                  context, "Vật phẩm này đang có lỗi!");
                            }
                          } else {
                            DialogMessage(context, "Không đủ vàng!");
                          }
                        } else {
                          if (widget.userProfile.diamond >=
                              quantity * widget.item.price) {
                            setState(() {
                              isloading = true;
                            });
                            bool isBuy = await UsersItemController()
                                .buyItem(this.widget.item.id, quantity);
                            setState(() {
                              isloading = false;
                            });
                            if (isBuy) {
                              Navigator.pop(context, quantity * widget.item.price);
                              DialogMessage(
                                  context, "Mua vật phẩm thành công!");
                            } else {
                              Navigator.pop(context);
                              DialogMessage(
                                  context, "Vật phẩm này đang có lỗi!");
                            }
                          } else {
                            DialogMessage(context, "Không đủ kim cương hãy nạp thêm!");
                          }
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("img/button.png"),
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
              child: CircularProgressIndicator(),
            ),
    );
  }
}
