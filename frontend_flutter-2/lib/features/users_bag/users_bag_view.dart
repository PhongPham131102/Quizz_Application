import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:frontend_flutter/features/change_name/change_name_view.dart';
import 'package:frontend_flutter/features/users_bag/users_bag_contract.dart';
import 'package:frontend_flutter/features/users_bag/users_bag_presenter.dart';

import '../../models/Item.dart';
import '../../models/Profile.dart';
import '../../models/UserItem.dart';

class UsersBagView extends StatefulWidget {
  Profile userProfile;
  UsersBagView({super.key, required this.userProfile});

  @override
  State<UsersBagView> createState() => _UsersBagViewState();
}

class _UsersBagViewState extends State<UsersBagView>
    with SingleTickerProviderStateMixin
    implements UsersBagContract {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  Map<String, UsersItem> usersitemMap = {};
  bool isloading = false;
  bool ischange = false;
  bool _isDropDown = false;
  List<Item>? items;
  String? type;
  String? detailType;
  List<String> types = [];
  List<String> detailTypes = [];
  List<Item>? itemsfilter;
  List<UsersItem> usersitemlist = [];
  List<String> UsersidItems = [];
  String selectedItem = "Tất cả";
  int selectedindex = 0;
  late UsersBagPresenter _presenter;
  _UsersBagViewState() {
    _presenter = UsersBagPresenter(this);
  }
  @override
  setDetailType(String _detailType) {
    detailType = _detailType;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String gettypesSelectedIndex() {
    return types[selectedindex];
  }

  @override
  setItemFilter(List<Item> _itemsfilter) {
    itemsfilter = _itemsfilter;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListDetailType(List<String> _detailTypes) {
    detailTypes = _detailTypes;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListItems(List<Item> _items) {
    items = _items;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListType(List<String> _types) {
    types = _types;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setType(String _type) {
    type = _type;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setUserIdItems(List<String> _UsersidItems) {
    UsersidItems = _UsersidItems;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  setUserItems(List<UsersItem> _usersitemlist) {
    usersitemlist = _usersitemlist;
    for (var userItem in usersitemlist) {
      usersitemMap[userItem.idItem] = userItem;
    }
    print(usersitemMap);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setselectedItem(String _selectedItem) {
    selectedItem = _selectedItem;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setselectedindex(int _selectedindex) {
    selectedindex = _selectedindex;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setisloading(bool _isloading) {
    isloading = _isloading;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setischange(bool _ischange) {
    ischange = _ischange;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool isUsing(Item item) {
    if (item.quantityPurchasable == true) {
      return false;
    } else {
      if (item.detailType == "Áo" &&
          item.shortName == this.widget.userProfile.shirt) {
        return true;
      } else if (item.detailType == "Quần" &&
          item.shortName == this.widget.userProfile.trouser) {
        return true;
      } else if (item.detailType == "Váy" &&
          item.shortName == this.widget.userProfile.trouser) {
        return true;
      } else if (item.detailType == "Giày" &&
          item.shortName == this.widget.userProfile.shoe) {
        return true;
      } else if (item.detailType == "Cặp" &&
          item.shortName == this.widget.userProfile.bag) {
        return true;
      }
      return false;
    }
  }

  @override
  changeClothes(String type, String value) {
    if (type == "Áo") {
      this.widget.userProfile.shirt = value;
    } else if (type == "Quần") {
      this.widget.userProfile.trouser = value;
    } else if (type == "Váy") {
      this.widget.userProfile.trouser = value;
    } else if (type == "Giày") {
      this.widget.userProfile.shoe = value;
    } else if (type == "Cặp") {
      this.widget.userProfile.bag = value;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String getPerformance(Item item) {
    if (item.name == "Thẻ Đổi Tên") return "Đổi Tên";
    return "Sử Dụng";
  }

  @override
  void initState() {
    _presenter.GetAllItem(this.widget.userProfile.gender);
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
      resizeToAvoidBottomInset: false,
      body: IgnorePointer(
        ignoring: ischange,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/store/mainbgstore.jpg"),
                  fit: BoxFit.fill)),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Column(
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
                                        image: AssetImage(
                                            "assets/img/store/baguser.png"),
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
                                          image: AssetImage(
                                              "assets/img/store/return.png"),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 20),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/img/maingame/male.png",
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
                                            selectedItem = "Tất cả";
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
                                                                  "assets/img/store/${itemsfilter![index * 2].shortName}.png",
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
                                                                itemsfilter![index *
                                                                            2]
                                                                        .quantityPurchasable
                                                                    ? Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            GlowText(
                                                                              "Số lượng: " + usersitemMap[itemsfilter![index * 2].id]!.quantity.toString(),
                                                                              style: TextStyle(color: Colors.yellowAccent, fontSize: 13, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 25,
                                                            right: 25,
                                                            child: isUsing(
                                                                    itemsfilter![
                                                                        index *
                                                                            2])
                                                                ? Container(
                                                                    height: 35,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                    child: Text(
                                                                      "Đang Sử Dụng",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w800),
                                                                    ))
                                                                : GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      if (getPerformance(itemsfilter![index *
                                                                              2]) ==
                                                                          "Sử Dụng") {
                                                                        _presenter.changeClothes(itemsfilter![index *
                                                                            2]);
                                                                      } else if (getPerformance(itemsfilter![index *
                                                                              2]) ==
                                                                          "Đổi Tên") {
                                                                        final result = await showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                ChangeNameView(idItem: (itemsfilter![index * 2]).id));
                                                                        if (result !=
                                                                            null) {
                                                                          if (usersitemMap[itemsfilter![index * 2].id]!.quantity ==
                                                                              1) {
                                                                            usersitemMap =
                                                                                {};
                                                                            isloading =
                                                                                false;

                                                                            ischange =
                                                                                false;

                                                                            _isDropDown =
                                                                                false;

                                                                            items =
                                                                                [];

                                                                            type =
                                                                                "";

                                                                            detailType =
                                                                                "";

                                                                            types =
                                                                                [];

                                                                            detailTypes =
                                                                                [];

                                                                            itemsfilter;

                                                                            usersitemlist =
                                                                                [];

                                                                            UsersidItems =
                                                                                [];

                                                                            selectedItem =
                                                                                "Tất cả";
                                                                            selectedindex =
                                                                                0;
                                                                            _presenter.GetAllItem(this.widget.userProfile.gender);
                                                                          } else {
                                                                            usersitemMap[itemsfilter![index * 2].id]!.quantity--;
                                                                          }

                                                                          setState(
                                                                              () {});
                                                                        }
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          35,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                      child:
                                                                          Text(
                                                                        getPerformance(itemsfilter![index *
                                                                            2]),
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w800),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ),
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
                                                                          index * 2 +
                                                                              1]
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
                                                                  "assets/img/store/${itemsfilter![index * 2 + 1].shortName}.png",
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
                                                                itemsfilter![index *
                                                                            2]
                                                                        .quantityPurchasable
                                                                    ? Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            GlowText(
                                                                              "Số lượng: " + usersitemMap[itemsfilter![index * 2].id]!.quantity.toString(),
                                                                              style: TextStyle(color: Colors.yellowAccent, fontSize: 13, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 25,
                                                            right: 25,
                                                            child: isUsing(
                                                                    itemsfilter![
                                                                        index * 2 +
                                                                            1])
                                                                ? Container(
                                                                    height: 35,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                    child: Text(
                                                                      "Đang Sử Dụng",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w800),
                                                                    ))
                                                                : GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      if (getPerformance(itemsfilter![index * 2 +
                                                                              1]) ==
                                                                          "Sử Dụng") {
                                                                        _presenter.changeClothes(itemsfilter![index *
                                                                                2 +
                                                                            1]);
                                                                      } else if (getPerformance(itemsfilter![index * 2 +
                                                                              1]) ==
                                                                          "Đổi Tên") {
                                                                        final result = await showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                ChangeNameView(idItem: (itemsfilter![index * 2 + 1]).id));
                                                                        if (result !=
                                                                            null) {
                                                                          if (usersitemMap[itemsfilter![index * 2 + 1].id]!.quantity ==
                                                                              1) {
                                                                            usersitemMap =
                                                                                {};
                                                                            isloading =
                                                                                false;

                                                                            ischange =
                                                                                false;

                                                                            _isDropDown =
                                                                                false;

                                                                            items =
                                                                                [];

                                                                            type =
                                                                                "";

                                                                            detailType =
                                                                                "";

                                                                            types =
                                                                                [];

                                                                            detailTypes =
                                                                                [];

                                                                            itemsfilter;

                                                                            usersitemlist =
                                                                                [];

                                                                            UsersidItems =
                                                                                [];

                                                                            selectedItem =
                                                                                "Tất cả";
                                                                            selectedindex =
                                                                                0;
                                                                            _presenter.GetAllItem(this.widget.userProfile.gender);
                                                                          } else {
                                                                            usersitemMap[itemsfilter![index * 2 + 1].id]!.quantity--;
                                                                          }

                                                                          setState(
                                                                              () {});
                                                                        }
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          35,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                      child:
                                                                          Text(
                                                                        getPerformance(itemsfilter![index *
                                                                                2 +
                                                                            1]),
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w800),
                                                                      ),
                                                                    ),
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
                                                            selectedItem,
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
                                                                  "assets/img/store/up.png")
                                                              : AssetImage(
                                                                  "assets/img/store/down.png"),
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
                                                                  selectedItem =
                                                                      e;
                                                                  itemsfilter = items!
                                                                      .where((a) =>
                                                                          a.type ==
                                                                          type)
                                                                      .where((element) =>
                                                                          element
                                                                              .detailType ==
                                                                          selectedItem)
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
                ],
              ),
              ischange
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
