class MyLogic {
  //Convert minutes to h:min
  static String getTimeString(int mins) {
    double hour = mins / 60;
    int minutes = mins % 60;
    return '${hour.floor().toString()}h : ${minutes.toString()}min';
  }

  static String getDuration(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}hr : ${minutes.toString().padLeft(2, "0")}mins';
  }
}
