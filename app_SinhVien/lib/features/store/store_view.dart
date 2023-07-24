import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/Button.dart';
import 'package:frontend_flutter/features/store/store_contract.dart';
import 'package:frontend_flutter/features/store/store_presenter.dart';
import '../../components/RobotLoading.dart';
import '../../models/Item.dart';
import '../../models/Profile.dart';
import '../../models/UserItem.dart';
import '../../spine_flutter.dart';
import '../detail_item/detail_item_view.dart';

// ignore: must_be_immutable
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
  String selectedItem = "Tất cả";
  int selectedindex = 0;
  late Profile profile;
  String selectedShirt = "";
  String selectedTrouser = "";
  String selectedShoe = "";
  String selectedBag = "";
  late String animation;
  late SkeletonAnimation skeleton;
  bool isLoadingCharacter = false;
  _StoreViewState() {
    _presenter = StorePresenter(this);
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
  void initState() {
    profile = this.widget.userProfile;
    selectedShirt = profile.shirt;
    selectedTrouser = profile.trouser;
    selectedShoe = profile.shoe;
    selectedBag = profile.bag;
    setState(() {});
    loadingCharacter();
    _presenter.GetAllItem(this.widget.userProfile.gender);
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.ease));
  }

  SelectedItem(Item item) {
    if (item.detailType == "Áo") {
      profile.shirt = item.shortName;
      selectedShirt = item.shortName;
      loadingCharacter();
    } else if (item.detailType == "Quần") {
      profile.trouser = item.shortName;
      selectedTrouser = item.shortName;
      loadingCharacter();
    } else if (item.detailType == "Váy") {
      profile.trouser = item.shortName;
      selectedTrouser = item.shortName;
      loadingCharacter();
    } else if (item.detailType == "Giày") {
      profile.shoe = item.shortName;
      selectedShoe = item.shortName;
      loadingCharacter();
    } else if (item.detailType == "Cặp") {
      profile.bag = item.shortName;
      selectedBag = item.shortName;
      loadingCharacter();
    }
    setState(() {});
  }

  bool IsSelectedItem(Item item) {
    if (item.detailType == "Áo") {
      if (selectedShirt == item.shortName) return true;
    } else if (item.detailType == "Quần") {
      if (selectedTrouser == item.shortName) return true;
    } else if (item.detailType == "Váy") {
      if (selectedTrouser == item.shortName) return true;
    } else if (item.detailType == "Giày") {
      if (selectedShoe == item.shortName) return true;
    } else if (item.detailType == "Cặp") {
      if (selectedBag == item.shortName) return true;
    }
    return false;
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

  loadingCharacter() async {
    animation =
        "${profile.shirt}_${profile.trouser}_${profile.shoe}_${profile.bag}";
    isLoadingCharacter = false;
    setState(() {});
    skeleton = await SkeletonAnimation.createWithFiles("${profile.gender}",
        pathBase: "assets/img/character/");
    skeleton.state.setAnimation(0, animation, true);
    isLoadingCharacter = true;
    setState(() {});
  }

  Widget _buildCharacter() {
    return SkeletonRenderObjectWidget(
      skeleton: skeleton,
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      playState: PlayState.playing,
      debugRendering: false,
      triangleRendering: true,
    );
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
                    image: AssetImage("assets/img/store/mainbgstore.jpg"),
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
                                        image: AssetImage(
                                            "assets/img/store/shoptitle.gif"),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 20,
                              bottom: 20,
                              child: ButtonCustom(
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
                                                    "assets/img/maingame/buttoncoin.png"),
                                                fit: BoxFit.fill)),
                                        child: Text(
                                          this
                                              .widget
                                              .userProfile
                                              .gold
                                              .toString(),
                                          style: TextStyle(fontFamily: 'Mitr',
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
                                                image: AssetImage(
                                                    "assets/img/maingame/gold.gif"),
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
                                                    "assets/img/maingame/buttoncoin.png"),
                                                fit: BoxFit.fill)),
                                        child: Text(
                                          this
                                              .widget
                                              .userProfile
                                              .diamond
                                              .toString(),
                                          style: TextStyle(fontFamily: 'Mitr',
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
                                                    "assets/img/maingame/diamond.gif"),
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
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                child: isLoadingCharacter
                                    ? _buildCharacter()
                                    : Container(),
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
                                        return ButtonCustom(
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
                                              style: TextStyle(fontFamily: 'Mitr',
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
                                                          ButtonCustom(
                                                            onTap: () {
                                                              SelectedItem(
                                                                  itemsfilter![
                                                                      index *
                                                                          2]);
                                                            },
                                                            child: Container(
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
                                                                  border: Border.all(
                                                                      color: IsSelectedItem(itemsfilter![index *
                                                                              2])
                                                                          ? Colors
                                                                              .orange
                                                                          : Color(
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
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(fontFamily: 'Mitr',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  Image.asset(
                                                                    "assets/img/store/${itemsfilter![index * 2].shortName}.png",
                                                                    width: (MediaQuery.of(context).size.width -
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
                                                                        bottom:
                                                                            2,
                                                                        right:
                                                                            0,
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
                                                                              begin: Alignment.bottomCenter,
                                                                              end: Alignment.topCenter,
                                                                              colors: [
                                                                                Color(0xFF3D8500),
                                                                                Color(0xFFE4E843),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "${itemsfilter![index * 2].price}",
                                                                            style: TextStyle(fontFamily: 'Mitr',
                                                                                color: Colors.white,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w800),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top:
                                                                            2.5,
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
                                                                              BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/${itemsfilter![index * 2].typeMoney}.gif"), fit: BoxFit.fill)),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
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
                                                                  ? ButtonCustom(
                                                                      onTap:
                                                                          () async {
                                                                        final data = await showDialog(
                                                                            context: context,
                                                                            builder: (context) => DetailItemView(
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
                                                                          UsersidItems.add(
                                                                              itemsfilter![index * 2].id);
                                                                          setState(
                                                                              () {});
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          height: 35,
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                          child: Text(
                                                                            "Mua",
                                                                            style: TextStyle(fontFamily: 'Mitr',
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
                                                                              BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                          child: Text(
                                                                            "Đã Sỡ Hữu",
                                                                            style: TextStyle(fontFamily: 'Mitr',
                                                                                color: Colors.black,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w800),
                                                                          ))
                                                                      : ButtonCustom(
                                                                          onTap:
                                                                              () async {
                                                                            final data = await showDialog(
                                                                                context: context,
                                                                                builder: (context) => DetailItemView(
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
                                                                              UsersidItems.add(itemsfilter![index * 2].id);
                                                                              setState(() {});
                                                                            }
                                                                          },
                                                                          child: Container(
                                                                              height: 35,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                              child: Text(
                                                                                "Mua",
                                                                                style: TextStyle(fontFamily: 'Mitr',color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
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
                                                          ButtonCustom(
                                                            onTap: () {
                                                              SelectedItem(
                                                                  itemsfilter![
                                                                      index * 2 +
                                                                          1]);
                                                            },
                                                            child: Container(
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
                                                                  border: Border.all(
                                                                      color: IsSelectedItem(itemsfilter![index * 2 +
                                                                              1])
                                                                          ? Colors
                                                                              .orange
                                                                          : Color(
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
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(fontFamily: 'Mitr',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  Image.asset(
                                                                    "assets/img/store/${itemsfilter![index * 2 + 1].shortName}.png",
                                                                    width: (MediaQuery.of(context).size.width -
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
                                                                        bottom:
                                                                            2,
                                                                        right:
                                                                            0,
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
                                                                              begin: Alignment.bottomCenter,
                                                                              end: Alignment.topCenter,
                                                                              colors: [
                                                                                Color(0xFF3D8500),
                                                                                Color(0xFFE4E843),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "${itemsfilter![index * 2 + 1].price}",
                                                                            style: TextStyle(fontFamily: 'Mitr',
                                                                                color: Colors.white,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w800),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top:
                                                                            2.5,
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
                                                                              BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/${itemsfilter![index * 2 + 1].typeMoney}.gif"), fit: BoxFit.fill)),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
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
                                                                ? ButtonCustom(
                                                                    onTap:
                                                                        () async {
                                                                      final data = await showDialog(
                                                                          context: context,
                                                                          builder: (context) => DetailItemView(
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
                                                                        UsersidItems.add(itemsfilter![index * 2 +
                                                                                1]
                                                                            .id);
                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                        height: 35,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                        child: Text(
                                                                          "Mua",
                                                                          style: TextStyle(fontFamily: 'Mitr',
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
                                                                            BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                        child: Text(
                                                                          "Đã Sỡ Hữu",
                                                                          style: TextStyle(fontFamily: 'Mitr',
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w800),
                                                                        ))
                                                                    : ButtonCustom(
                                                                        onTap:
                                                                            () async {
                                                                          final data = await showDialog(
                                                                              context: context,
                                                                              builder: (context) => DetailItemView(
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
                                                                            UsersidItems.add(itemsfilter![index * 2 + 1].id);
                                                                            setState(() {});
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                            height: 35,
                                                                            alignment: Alignment.center,
                                                                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/maingame/button.png"))),
                                                                            child: Text(
                                                                              "Mua",
                                                                              style: TextStyle(fontFamily: 'Mitr',color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
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
                                              ButtonCustom(
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
                                                            style: TextStyle(fontFamily: 'Mitr',
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
                                                          .map((e) => ButtonCustom(
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
                                                                    style: TextStyle(fontFamily: 'Mitr',
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
                          : Center(child: RobotLoading()),
                    ),
                  ),
                ])));
  }
}
