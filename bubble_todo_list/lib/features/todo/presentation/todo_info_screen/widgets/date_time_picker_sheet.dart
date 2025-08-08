import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:bubble_todo_list/core/utils/handle_conversion_tz_and_date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class DateTimePickerSheet extends ConsumerStatefulWidget {
  final String tid;
  final bool cmd;
  const DateTimePickerSheet({super.key, required this.tid, required this.cmd});

  @override
  ConsumerState<DateTimePickerSheet> createState() => _DateTimePickerSheetState();
}

class _DateTimePickerSheetState extends ConsumerState<DateTimePickerSheet> {
  DateTime? _pickedTime;
  TZDateTime? _tzPickedTime;

  @override
  Widget build(BuildContext context) {
    if(_pickedTime != null){
      _tzPickedTime = HandleConversionTzAndDateTime.dateTimeToTz(_pickedTime!);
    }
    
    final showTime = _pickedTime != null 
      ? (widget.cmd 
          ? DateFormat('yyyy-MM-dd').format(_pickedTime!)
          : DateFormat('yyyy-MM-dd HH:mm').format(_pickedTime!)
        )
      : '未选择';

    return Container(
      width: AppSizes.screenWidth,
      height: AppSizes.screenHeight * 0.3,
      padding: EdgeInsets.all(AppSizes.paddingRegular),
      child: Column(
        spacing: AppSizes.paddingSmall,
        children: [
          Text(
            '当前选择: $showTime,${tz.local.toString()}',
            style: Theme.of(context).textTheme.labelLarge
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: widget.cmd 
                ? CupertinoDatePickerMode.date 
                : CupertinoDatePickerMode.dateAndTime,
              initialDateTime: HandleConversionTzAndDateTime.dateTimeToTz(DateTime.now()),
              maximumDate: HandleConversionTzAndDateTime.dateTimeToTz(DateTime(2048)),
              minimumDate: HandleConversionTzAndDateTime.dateTimeToTz(DateTime.now()),
              onDateTimeChanged: (value) => setState(() => _pickedTime = value)
            )
          ),
          TextButton(
            onPressed: () => Navigator.pop(
              context, _tzPickedTime?.toUtc()
            ), 
            child: Text('确定', style: Theme.of(context).textTheme.labelLarge)
          )
        ],
      ),
    );
  }
}