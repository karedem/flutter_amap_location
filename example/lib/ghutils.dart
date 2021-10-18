import 'package:amap_location/amap_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GHUtil {
  ///清除焦点
  static void clearFocus(ctx) {
    FocusScope.of(ctx).requestFocus(FocusNode());
  }

  ///秒转为倒计时
  static String formatLastTime(int allsecond) {
    if (allsecond <= 0) {
      return '${formatNumber(0)}:${formatNumber(0)}';
    }
    int hour = allsecond ~/ 3600;
    int minute = (allsecond % 3600) ~/ 60;
    int second = allsecond % 60;
    if (hour > 0) {
      return '${formatNumber(hour)}:${formatNumber(minute)}:${formatNumber(second)}';
    } else {
      return '${formatNumber(minute)}:${formatNumber(second)}';
    }
  }

  ///当前时间距离传入时间的秒数
  static int secFromDate(String dateTime) {
    if (dateTime == null) {
      return 0;
    }
    DateTime target = DateTime.parse(dateTime);
    return ((target.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch) ~/
        1000);
  }

  ///当前时间距离目标时间
  static String formatLastDateTime(String dateTime) {
    int sec = secFromDate(dateTime);
    return formatLastTime(sec);
  }

  static String formatNumber(int a) {
    return a < 10 ? '0$a' : '$a';
  }

  ///格式化时间戳
  static String formatDate(DateTime time, {String split, bool withT}) {
    int year = time.year;
    int month = time.month;
    int day = time.day;
    int hour = time.hour;
    int minute = time.minute;
    if (split == null) {
      split = '/';
    }
    String splitCenter = ' ';
    if (withT != null && withT) {
      splitCenter = 'T';
    }
    return '$year$split${month < 10 ? '0$month' : '$month'}$split${day < 10 ? '0$day' : '$day'}$splitCenter${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}';
  }

  ///格式化时间戳
  static String formatDateDMS2(DateTime time, {String split, bool withT}) {
    int second = time.second;
    return '${formatDate(time, split: split, withT: withT)}:${second < 10 ? '0$second' : '$second'}';
  }

  static bool matchMobile(String mobile) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

  static Future<AMapLocation> getLocation() async {
    AMapLocation location = await AMapLocationClient.getLocation(true);
    if (location.success) {
      return location;
    }
    return null;
  }

  ///获取地理信息
  static Map getLocationInfo() {}

  ///获取本机信息
  static Map getMobileInfo() {}

  ///判断App在前台
  static bool isAPPFront() {}
}
