 class MyLogic{
  //Convert minutes to h:min
  static String getDuration(int mins) {
    double hour = mins / 60;
    int minutes = mins % 60;
    return '${hour.floor().toString()}h : ${minutes.toString()}min';
  }
 }