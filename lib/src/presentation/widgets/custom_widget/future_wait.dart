// concurrency create different isolates in memory to implement parrallel code in once
// as Isolate.spawn so i think that future.wait use this way to implement parrallel code
// by create different isolate in memory to run futures
// but this using in device multi core?
void main() async {
  final stopwatch = Stopwatch()..start();
  // var x=  await delayedNumber();
  // var y= await delayedString();
  // var z=await delayedS();
  // print(x);
  // print(y);
  // print(z);
  var value = await Future.wait([delayedNumber(), delayedString(), delayedS()]);
  print(value); // [2, result]
  print('doSomething() executed in ${stopwatch.elapsed}');
}

Future<int> delayedNumber() async {
  await Future.delayed(const Duration(seconds: 20));
  return 2;
}

Future<String> delayedS() async {
  await Future.delayed(const Duration(seconds: 20));
  return 'result';
}

Future<String> delayedString() async {
  await Future.delayed(const Duration(seconds: 10));
  return 'result';
}
