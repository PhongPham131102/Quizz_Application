import "package:flutter/material.dart";

DialogMessage(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 360,
              height: 250,
            ),
            Positioned(
              top: 40,
              child: Container(
                width: 280,
                height: 200,
                padding: EdgeInsets.only(left: 30,right: 30),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/home/frame.png"), fit: BoxFit.fill)),
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 115, 87, 4)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 230,
                    height: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/home/logo.png"),
                            fit: BoxFit.fill)),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 35,
                right: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/home/closebutton.png"),
                      ),
                    ),
                  ),
                ),),
          ],
        ),
      );
    },
  );
}
