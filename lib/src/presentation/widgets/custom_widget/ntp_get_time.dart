// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class NTPGetTime extends StatelessWidget {
  const NTPGetTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NTP Get Time"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            DateTime startDate = DateTime.now().toLocal();
            int offset = await NTP.getNtpOffset(localTime: startDate);
            print(
              'NTP DateTime offset align: ${startDate.add(Duration(milliseconds: offset))}',
            );
            DateTime startDat = await NTP.now();
            print('NTP DateTime: $startDat');

            DateTime _myTime;
            DateTime _ntpTime;

            /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
            _myTime = DateTime.now();
            String lookupAddress = 'time.google.com';

            /// Or get NTP offset (in milliseconds) and add it yourself
            final int offse = await NTP.getNtpOffset(
                localTime: _myTime, lookUpAddress: lookupAddress);

            _ntpTime = _myTime.add(Duration(milliseconds: offse));

            print('\n==== $lookupAddress ====');
            print('My time: $_myTime');
            print('NTP time: $_ntpTime');
            print(
                'Difference: ${_myTime.difference(_ntpTime).inMilliseconds}ms');
          },
          child: const Text("NTP Get Time"),
        ),
      ),
    );
  }
}
