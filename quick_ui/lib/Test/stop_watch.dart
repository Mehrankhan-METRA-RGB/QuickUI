import 'dart:async';

import 'package:flutter/material.dart';

///The _stopwatch variable is an instance of the Stopwatch class,
/// which is used to measure elapsed time.
///
/// _elapsedTime represents the current elapsed time, and _elapsedTimeString
/// is a formatted string for displaying the elapsed time in the user interface.
///
/// The timer is a periodic timer that updates the UI every 100 milliseconds
/// (to show the elapsed time).
class QuickStopWatch extends StatefulWidget {
  const QuickStopWatch({Key? key}) : super(key: key);

  @override
  State<QuickStopWatch> createState() => _QuickStopWatchState();
}

class _QuickStopWatchState extends State<QuickStopWatch> {
  final Stopwatch _stopwatch = Stopwatch();
  late Duration _elapsedTime;
  late String _elapsedTimeString;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _elapsedTime = Duration.zero;
    _elapsedTimeString = _formatElapsedTime(_elapsedTime);

    // Create a timer that runs a callback every 100 milliseconds to update UI
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        // Update elapsed time only if the stopwatch is running
        if (_stopwatch.isRunning) {
          _updateElapsedTime();
        }
      });
    });
  }

  // Start/Stop button callback
  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      // Start the stopwatch and update elapsed time
      _stopwatch.start();
      _updateElapsedTime();
    } else {
      // Stop the stopwatch
      _stopwatch.stop();
    }
  }

  // Reset button callback
  void _resetStopwatch() {
    // Reset the stopwatch to zero and update elapsed time
    _stopwatch.reset();
    _updateElapsedTime();
  }

  // Update elapsed time and formatted time string
  void _updateElapsedTime() {
    setState(() {
      _elapsedTime = _stopwatch.elapsed;
      _elapsedTimeString = _formatElapsedTime(_elapsedTime);
    });
  }

  // Format a Duration into a string (MM:SS.SS)
  String _formatElapsedTime(Duration time) {
    return '${time.inHours.remainder(60).toString().padLeft(2, '0')}:${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(time.inSeconds.remainder(60)).toString().padLeft(2, '0')}.${(time.inMilliseconds % 1000 ~/ 100).toString()}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 140,
      width: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          border: Border.all(
            color: theme.dividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
          color: theme.cardColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Display elapsed time
          Text(
            _elapsedTimeString,
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 5.0),
          // Start/Stop and Reset buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: _startStopwatch,
                child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
              ),
              const SizedBox(width: 20.0),
              TextButton(
                onPressed: _resetStopwatch,
                child: const Text(
                  'Reset',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
