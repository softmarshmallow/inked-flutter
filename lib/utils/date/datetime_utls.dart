import 'package:intl/intl.dart';

String formatTimeHuman(DateTime time, TimeFormatType format){
  switch (format){
    case TimeFormatType.RECENT:
      return DateFormat().add_Md().format(time);
      break;
    case TimeFormatType.TODAY:
      return DateFormat().add_Hms().format(time);
      break;
    case TimeFormatType.THIS_MONTH:
      return DateFormat("M/d hh:mm:ss").format(time);
      break;
    case TimeFormatType.MAX:
      return DateFormat("y/M/d hh:mm:ss").format(time);
      break;
  }
}


enum TimeFormatType{
  RECENT,
  TODAY,
  THIS_MONTH,
  MAX
}