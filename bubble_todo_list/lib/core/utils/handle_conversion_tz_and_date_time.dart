import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart' show TZDateTime;

class HandleConversionTzAndDateTime{
  static TZDateTime dateTimeToTz(DateTime time) {
    return tz.TZDateTime(tz.local, 
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
      time.second,
      time.millisecond
    );   
  }

  static TZDateTime dateTimeToTzUtc(DateTime time) {
    return dateTimeToTz(time).toUtc();
  }

  static TZDateTime utcToTzLocal({required DateTime utc}){ //从 UTC 时间转换成 tzlocal
    return tz.TZDateTime.from(utc, tz.local); //tzlocal 
  }
}