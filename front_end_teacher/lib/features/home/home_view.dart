// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:front_end_teacher/features/home/home_contract.dart';
import 'package:front_end_teacher/features/home/home_presenter.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_view.dart';
import 'package:front_end_teacher/models/Test.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeContract {
  late HomePresenter _presenter;
  bool isloading = true;
  List<Test> tests = [];
  _HomeViewState() {
    _presenter = HomePresenter(this);
  }
  @override
  void initState() {
    _presenter.GetListTest();
    super.initState();
  }

  @override
  SetIsLoading(bool _isloading) {
    isloading = _isloading;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  SetListTest(List<Test> _tests) {
    tests = _tests;
    print(tests.length);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh Sách Bộ Câu Hỏi"),
        backgroundColor: Color.fromARGB(255, 79, 148, 1),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Image.asset(
              "assets/img/logo.gif",
              fit: BoxFit.scaleDown,
            )),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text('Đăng Xuất'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : tests.length == 0
                ? Center(
                    child: Text(
                      "Bạn chưa tạo bài kiểm tra nào...",
                      style: TextStyle(
                          fontFamily: 'Mitr',
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int index = 0; index < tests.length; index++)
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 254, 254, 254),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7,
                                            child: Text(
                                              tests[index].heading,
                                              style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    161, 141, 141, 141)),
                                            child: Text(
                                              "${tests[index].listQuestions.length} Câu",
                                              style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              KahootView(test:tests[index] ,),
                                                        ));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                    ),
                                                    child: Text(
                                                      "Bắt Đầu",
                                                      style: TextStyle(
                                                          fontFamily: 'Mitr',
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0),
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
      ),
    );
  }
}
