import 'dart:ui';

const baseUrl =
    "https://c392-113-161-80-43.ngrok-free.app/api";
String? token;
String? uid;
const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter transparentscale = ColorFilter.matrix(<double>[
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
int expNeed(int level) {
  return level * 100;
}

double percentExp(double percent100, int level, int nowexp) {
  int expneed = expNeed(level);
  return (nowexp / expneed) * percent100;
}

String getStarLevel(int star) {
  if (star >= 0 && star <= 4) {
    return "intern";
  } else if (star >= 5 && star <= 10) {
    return "fresher";
  } else if (star >= 11 && star <= 15) {
    return "junior";
  } else if (star >= 16 && star <= 20) {
    return "mid-level";
  } else if (star >= 21) {
    return "senior";
  }
  return "null";
}

int getRemainingStars(int star) {
  int remainingStars = star;
  if (star >= 5 && star <= 10) {
    remainingStars = star - 5;
  } else if (star >= 11 && star <= 15) {
    remainingStars = star - 11;
  } else if (star >= 16 && star <= 20) {
    remainingStars = star - 16;
  } else if (star >= 21) {
    remainingStars = star - 21;
  }

  return remainingStars;
}

String formatMoney(int money) {
  if (money > 1000000) {
    return "Max";
  } else if (money >= 10000) {
    double convertedMoney = money / 1000;
    return "${convertedMoney.toStringAsFixed(1)}k";
  } else {
    return money.toString();
  }
}
