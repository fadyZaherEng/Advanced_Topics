// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class AESScreen extends StatefulWidget {
  const AESScreen({super.key});

  @override
  State<AESScreen> createState() => _AESScreenState();
}

class Keys {
  List<List<String>> key;

  Keys(this.key);
}

class _AESScreenState extends State<AESScreen> {
  List<List<String>> _sBoxRes = [];
  List<List<String>> _shiftRowPlain = [];
  List<List<String>> _mixColPlain = [];
  List<List<String>> _finalRes = [];
  List<List<String>> _output = [];
  List<List<String>> _transposeMatrixRes = []; //new String[4, 4];
  final Map<String, String> _invBox = {};
  List<List<String>> _sBoxResInv = [];
  List<List<String>> _shiftRowPlainInv = [];
  // List<List<String>> _mixColPlainInv = [];
  List<List<String>> finalInv = [];
  List<List<String>> outputInv = [];
  final List<List<String>> _mixInv = [
    ["0e", "0b", "0d", "09"],
    ["09", "0e", "0b", "0d"],
    ["0d", "09", "0e", "0b"],
    ["0b", "0d", "09", "0e"]
  ];
  List<List<String>> sBox = [
    [
      "63",
      "7c",
      "77",
      "7b",
      "f2",
      "6b",
      "6f",
      "c5",
      "30",
      "01",
      "67",
      "2b",
      "fe",
      "d7",
      "ab",
      "76"
    ],
    [
      "ca",
      "82",
      "c9",
      "7d",
      "fa",
      "59",
      "47",
      "f0",
      "ad",
      "d4",
      "a2",
      "af",
      "9c",
      "a4",
      "72",
      "c0"
    ],
    [
      "b7",
      "fd",
      "93",
      "26",
      "36",
      "3f",
      "f7",
      "cc",
      "34",
      "a5",
      "e5",
      "f1",
      "71",
      "d8",
      "31",
      "15"
    ],
    [
      "04",
      "c7",
      "23",
      "c3",
      "18",
      "96",
      "05",
      "9a",
      "07",
      "12",
      "80",
      "e2",
      "eb",
      "27",
      "b2",
      "75"
    ],
    [
      "09",
      "83",
      "2c",
      "1a",
      "1b",
      "6e",
      "5a",
      "a0",
      "52",
      "3b",
      "d6",
      "b3",
      "29",
      "e3",
      "2f",
      "84"
    ],
    [
      "53",
      "d1",
      "00",
      "ed",
      "20",
      "fc",
      "b1",
      "5b",
      "6a",
      "cb",
      "be",
      "39",
      "4a",
      "4c",
      "58",
      "cf"
    ],
    [
      "d0",
      "ef",
      "aa",
      "fb",
      "43",
      "4d",
      "33",
      "85",
      "45",
      "f9",
      "02",
      "7f",
      "50",
      "3c",
      "9f",
      "a8"
    ],
    [
      "51",
      "a3",
      "40",
      "8f",
      "92",
      "9d",
      "38",
      "f5",
      "bc",
      "b6",
      "da",
      "21",
      "10",
      "ff",
      "f3",
      "d2"
    ],
    [
      "cd",
      "0c",
      "13",
      "ec",
      "5f",
      "97",
      "44",
      "17",
      "c4",
      "a7",
      "7e",
      "3d",
      "64",
      "5d",
      "19",
      "73"
    ],
    [
      "60",
      "81",
      "4f",
      "dc",
      "22",
      "2a",
      "90",
      "88",
      "46",
      "ee",
      "b8",
      "14",
      "de",
      "5e",
      "0b",
      "db"
    ],
    [
      "e0",
      "32",
      "3a",
      "0a",
      "49",
      "06",
      "24",
      "5c",
      "c2",
      "d3",
      "ac",
      "62",
      "91",
      "95",
      "e4",
      "79"
    ],
    [
      "e7",
      "c8",
      "37",
      "6d",
      "8d",
      "d5",
      "4e",
      "a9",
      "6c",
      "56",
      "f4",
      "ea",
      "65",
      "7a",
      "ae",
      "08"
    ],
    [
      "ba",
      "78",
      "25",
      "2e",
      "1c",
      "a6",
      "b4",
      "c6",
      "e8",
      "dd",
      "74",
      "1f",
      "4b",
      "bd",
      "8b",
      "8a"
    ],
    [
      "70",
      "3e",
      "b5",
      "66",
      "48",
      "03",
      "f6",
      "0e",
      "61",
      "35",
      "57",
      "b9",
      "86",
      "c1",
      "1d",
      "9e"
    ],
    [
      "e1",
      "f8",
      "98",
      "11",
      "69",
      "d9",
      "8e",
      "94",
      "9b",
      "1e",
      "87",
      "e9",
      "ce",
      "55",
      "28",
      "df"
    ],
    [
      "8c",
      "a1",
      "89",
      "0d",
      "bf",
      "e6",
      "42",
      "68",
      "41",
      "99",
      "2d",
      "0f",
      "b0",
      "54",
      "bb",
      "16"
    ]
  ];
  final List<List<String>> _rCON = [
    ["01", "02", "04", "08", "10", "20", "40", "80", "1b", "36"],
    ["00", "00", "00", "00", "00", "00", "00", "00", "00", "00"],
    ["00", "00", "00", "00", "00", "00", "00", "00", "00", "00"],
    ["00", "00", "00", "00", "00", "00", "00", "00", "00", "00"]
  ];
  final List<List<String>> _mix = [
    ["02", "03", "01", "01"],
    ["01", "02", "03", "01"],
    ["01", "01", "02", "03"],
    ["03", "01", "01", "02"]
  ];

  @override
  void initState() {
    super.initState();
    initializeSBoxInv();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void initializeSBoxInv() {
    _transposeMatrixRes =
        List.generate(4, (index) => List.generate(4, (_) => '')).toList();
    _invBox["00"] = "52";
    _invBox["10"] = "7c";
    _invBox["20"] = "54";
    _invBox["30"] = "08";
    _invBox["40"] = "72";
    _invBox["50"] = "6c";
    _invBox["60"] = "90";
    _invBox["70"] = "d0";
    _invBox["80"] = "3a";
    _invBox["90"] = "96";
    _invBox["a0"] = "47";
    _invBox["b0"] = "fc";
    _invBox["c0"] = "1f";
    _invBox["d0"] = "60";
    _invBox["e0"] = "a0";
    _invBox["f0"] = "17";

    _invBox["01"] = "09";
    _invBox["11"] = "e3";
    _invBox["21"] = "7b";
    _invBox["31"] = "2e";
    _invBox["41"] = "f8";
    _invBox["51"] = "70";
    _invBox["61"] = "d8";
    _invBox["71"] = "2c";
    _invBox["81"] = "91";
    _invBox["91"] = "ac";
    _invBox["a1"] = "f1";
    _invBox["b1"] = "56";
    _invBox["c1"] = "dd";
    _invBox["d1"] = "51";
    _invBox["e1"] = "e0";
    _invBox["f1"] = "2b";

    _invBox["02"] = "6a";
    _invBox["12"] = "39";
    _invBox["22"] = "94";
    _invBox["32"] = "a1";
    _invBox["42"] = "f6";
    _invBox["52"] = "48";
    _invBox["62"] = "ab";
    _invBox["72"] = "1e";
    _invBox["82"] = "11";
    _invBox["92"] = "74";
    _invBox["a2"] = "1a";
    _invBox["b2"] = "3e";
    _invBox["c2"] = "a8";
    _invBox["d2"] = "7f";
    _invBox["e2"] = "3b";
    _invBox["f2"] = "04";

    _invBox["03"] = "d5";
    _invBox["13"] = "82";
    _invBox["23"] = "32";
    _invBox["33"] = "66";
    _invBox["43"] = "64";
    _invBox["53"] = "50";
    _invBox["63"] = "00";
    _invBox["73"] = "8f";
    _invBox["83"] = "41";
    _invBox["93"] = "22";
    _invBox["a3"] = "71";
    _invBox["b3"] = "4b";
    _invBox["c3"] = "33";
    _invBox["d3"] = "a9";
    _invBox["e3"] = "4d";
    _invBox["f3"] = "7e";

    _invBox["04"] = "30";
    _invBox["14"] = "9b";
    _invBox["24"] = "a6";
    _invBox["34"] = "28";
    _invBox["44"] = "86";
    _invBox["54"] = "fd";
    _invBox["64"] = "8c";
    _invBox["74"] = "ca";
    _invBox["84"] = "4f";
    _invBox["94"] = "e7";
    _invBox["a4"] = "1d";
    _invBox["b4"] = "c6";
    _invBox["c4"] = "88";
    _invBox["d4"] = "19";
    _invBox["e4"] = "ae";
    _invBox["f4"] = "ba";

    _invBox["05"] = "36";
    _invBox["15"] = "2f";
    _invBox["25"] = "c2";
    _invBox["35"] = "d9";
    _invBox["45"] = "68";
    _invBox["55"] = "ed";
    _invBox["65"] = "bc";
    _invBox["75"] = "3f";
    _invBox["85"] = "67";
    _invBox["95"] = "ad";
    _invBox["a5"] = "29";
    _invBox["b5"] = "d2";
    _invBox["c5"] = "07";
    _invBox["d5"] = "b5";
    _invBox["e5"] = "2a";
    _invBox["f5"] = "77";

    _invBox["06"] = "a5";
    _invBox["16"] = "ff";
    _invBox["26"] = "23";
    _invBox["36"] = "24";
    _invBox["46"] = "98";
    _invBox["56"] = "b9";
    _invBox["66"] = "d3";
    _invBox["76"] = "0f";
    _invBox["86"] = "dc";
    _invBox["96"] = "35";
    _invBox["a6"] = "c5";
    _invBox["b6"] = "79";
    _invBox["c6"] = "c7";
    _invBox["d6"] = "4a";
    _invBox["e6"] = "f5";
    _invBox["f6"] = "d6";

    _invBox["07"] = "38";
    _invBox["17"] = "87";
    _invBox["27"] = "3d";
    _invBox["37"] = "b2";
    _invBox["47"] = "16";
    _invBox["57"] = "da";
    _invBox["67"] = "0a";
    _invBox["77"] = "02";
    _invBox["87"] = "ea";
    _invBox["97"] = "85";
    _invBox["a7"] = "89";
    _invBox["b7"] = "20";
    _invBox["c7"] = "31";
    _invBox["d7"] = "0d";
    _invBox["e7"] = "b0";
    _invBox["f7"] = "26";

    _invBox["08"] = "bf";
    _invBox["18"] = "34";
    _invBox["28"] = "ee";
    _invBox["38"] = "76";
    _invBox["48"] = "d4";
    _invBox["58"] = "5e";
    _invBox["68"] = "f7";
    _invBox["78"] = "c1";
    _invBox["88"] = "97";
    _invBox["98"] = "e2";
    _invBox["a8"] = "6f";
    _invBox["b8"] = "9a";
    _invBox["c8"] = "b1";
    _invBox["d8"] = "2d";
    _invBox["e8"] = "c8";
    _invBox["f8"] = "e1";

    _invBox["09"] = "40";
    _invBox["19"] = "8e";
    _invBox["29"] = "4c";
    _invBox["39"] = "5b";
    _invBox["49"] = "a4";
    _invBox["59"] = "15";
    _invBox["69"] = "e4";
    _invBox["79"] = "af";
    _invBox["89"] = "f2";
    _invBox["99"] = "f9";
    _invBox["a9"] = "b7";
    _invBox["b9"] = "db";
    _invBox["c9"] = "12";
    _invBox["d9"] = "e5";
    _invBox["e9"] = "eb";
    _invBox["f9"] = "69";

    _invBox["0a"] = "a3";
    _invBox["1a"] = "43";
    _invBox["2a"] = "95";
    _invBox["3a"] = "a2";
    _invBox["4a"] = "5c";
    _invBox["5a"] = "46";
    _invBox["6a"] = "58";
    _invBox["7a"] = "bd";
    _invBox["8a"] = "cf";
    _invBox["9a"] = "37";
    _invBox["aa"] = "62";
    _invBox["ba"] = "c0";
    _invBox["ca"] = "10";
    _invBox["da"] = "7a";
    _invBox["ea"] = "bb";
    _invBox["fa"] = "14";

    _invBox["0b"] = "9e";
    _invBox["1b"] = "44";
    _invBox["2b"] = "0b";
    _invBox["3b"] = "49";
    _invBox["4b"] = "cc";
    _invBox["5b"] = "57";
    _invBox["6b"] = "05";
    _invBox["7b"] = "03";
    _invBox["8b"] = "ce";
    _invBox["9b"] = "e8";
    _invBox["ab"] = "0e";
    _invBox["bb"] = "fe";
    _invBox["cb"] = "59";
    _invBox["db"] = "9f";
    _invBox["eb"] = "3c";
    _invBox["fb"] = "63";

    _invBox["0c"] = "81";
    _invBox["1c"] = "c4";
    _invBox["2c"] = "42";
    _invBox["3c"] = "6d";
    _invBox["4c"] = "5d";
    _invBox["5c"] = "a7";
    _invBox["6c"] = "b8";
    _invBox["7c"] = "01";
    _invBox["8c"] = "f0";
    _invBox["9c"] = "1c";
    _invBox["ac"] = "aa";
    _invBox["bc"] = "78";
    _invBox["cc"] = "27";
    _invBox["dc"] = "93";
    _invBox["ec"] = "83";
    _invBox["fc"] = "55";

    _invBox["0d"] = "f3";
    _invBox["1d"] = "de";
    _invBox["2d"] = "fa";
    _invBox["3d"] = "8b";
    _invBox["4d"] = "65";
    _invBox["5d"] = "8d";
    _invBox["6d"] = "b3";
    _invBox["7d"] = "13";
    _invBox["8d"] = "b4";
    _invBox["9d"] = "75";
    _invBox["ad"] = "18";
    _invBox["bd"] = "cd";
    _invBox["cd"] = "80";
    _invBox["dd"] = "c9";
    _invBox["ed"] = "53";
    _invBox["fd"] = "21";

    _invBox["0e"] = "d7";
    _invBox["1e"] = "e9";
    _invBox["2e"] = "c3";
    _invBox["3e"] = "d1";
    _invBox["4e"] = "b6";
    _invBox["5e"] = "9d";
    _invBox["6e"] = "45";
    _invBox["7e"] = "8a";
    _invBox["8e"] = "e6";
    _invBox["9e"] = "df";
    _invBox["ae"] = "be";
    _invBox["be"] = "5a";
    _invBox["ce"] = "ec";
    _invBox["de"] = "9c";
    _invBox["ee"] = "99";
    _invBox["fe"] = "0c";

    _invBox["0f"] = "fb";
    _invBox["1f"] = "cb";
    _invBox["2f"] = "4e";
    _invBox["3f"] = "25";
    _invBox["4f"] = "92";
    _invBox["5f"] = "84";
    _invBox["6f"] = "06";
    _invBox["7f"] = "6b";
    _invBox["8f"] = "73";
    _invBox["9f"] = "6e";
    _invBox["af"] = "1b";
    _invBox["bf"] = "f4";
    _invBox["cf"] = "5f";
    _invBox["df"] = "ef";
    _invBox["ef"] = "61";
    _invBox["ff"] = "7d";
  }

  String _decrypt(String cipherText, String key) {
    String mainCipher = cipherText;
    String mainKey = key;
    String plain = "0x";
    List<Keys> arr = [];
// Keys[] arr = new Keys[10];
    List<List<String>> o =
        List.generate(4, (index) => List.generate(4, (_) => ''));
// String[,] o = new String[4, 4];
    List<List<String>> keyMatrix =
        List.generate(4, (index) => List.generate(4, (_) => ''));
// String[,] KeyMatrix = new string[4, 4];
    int c = 2;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        keyMatrix[j][i] = "${mainKey[c]}${mainKey[c + 1]}";
        c += 2;
      }
    }

    List<List<String>> cipherMatrix =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    c = 2;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        cipherMatrix[j][i] = "${mainCipher[c]}${mainCipher[c + 1]}";
        c += 2;
      }
    }
    int count = 0;
    arr[count].key = _generateKey(keyMatrix, count);
    count++;
    while (count < 9) {
      arr[count].key = _generateKey2(arr[count - 1].key, count);
      count++;
    }
    arr[count].key = _generateKey2(arr[count - 1].key, count);

    count = 8;
    outputInv = _addRoundKeyInv(cipherMatrix, _trans(arr[9].key));
    while (count >= 0) {
      _shiftRowPlainInv = _shiftRowInv(outputInv);
      _sBoxResInv = _sBoxInv(_shiftRowPlainInv);
      finalInv = _addRoundKeyInv(_sBoxResInv, _trans(arr[count].key));
      outputInv = _invMixCol(finalInv);
      outputInv = _trans(outputInv);
      count--;
    }
    _shiftRowPlainInv = _shiftRowInv(outputInv);
    _sBoxResInv = _sBoxInv(_shiftRowPlainInv);

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        o[i][j] = _binaryToHex(_xOR(
            _hexToBinary(keyMatrix[i][j]), _hexToBinary(_sBoxResInv[i][j])));
      }
    }
    o = _trans(o);
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        plain += o[i][j];
      }
    }
    return plain.toLowerCase();
  }

  List<List<String>> _generateKey2(List<List<String>> ky, int round) {
    List<List<String>> ssss =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        ssss[j][i] = ky[i][j];
      }
    }
    List<List<String>> res =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    String row, col;
    for (int j = 0; j < 4; j++) {
      String arr = ssss[j][3].toUpperCase();
      row = arr[0];
      col = arr[1];
      if (arr[0] == 'A') row = "10";
      if (arr[0] == 'B') row = "11";
      if (arr[0] == 'C') row = "12";
      if (arr[0] == 'D') row = "13";
      if (arr[0] == 'E') row = "14";
      if (arr[0] == 'F') row = "15";
      if (arr[1] == 'A') col = "10";
      if (arr[1] == 'B') col = "11";
      if (arr[1] == 'C') col = "12";
      if (arr[1] == 'D') col = "13";
      if (arr[1] == 'E') col = "14";
      if (arr[1] == 'F') col = "15";

      res[j][0] = sBox[int.parse(row)][int.parse(col)];
    }
    String temp = res[0][0];
    for (int k = 0; k < 3; k++) {
      res[k][0] = res[k + 1][0];
    }
    res[3][0] = temp;
    for (int i = 0; i < 4; i++) {
      String a = _xOR(_hexToBinary(ssss[i][0]), _hexToBinary(_rCON[i][round]));
      String b = _xOR(a, _hexToBinary(res[i][0]));
      res[i][0] = _binaryToHex(b);
    }
    int xo1 = 0, xo2 = 1;
    for (int j = 0; j < 3; j++) {
      for (int i = 0; i < 4; i++) {
        String b = _xOR(_hexToBinary(ssss[i][xo2]), _hexToBinary(res[i][xo1]));
        res[i][xo2] = _binaryToHex(b);
      }
      xo2++;
      xo1++;
    }
    List<List<String>> output1 =
        List.generate(4, (_) => List.generate(4, (_) => ''));

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        output1[j][i] = res[i][j];
      }
    }
    print("key");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${res[i][j]}  ");
      }
    }
    return output1;
  }

  List<List<String>> _sBoxMethod(List<List<String>> plain) {
    print("sBox");

    List<List<String>> res =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    String row, col;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        String arr = plain[i][j].toUpperCase();
        row = arr[0];
        col = arr[1];
        if (arr[0] == 'A') row = "10";
        if (arr[0] == 'B') row = "11";
        if (arr[0] == 'C') row = "12";
        if (arr[0] == 'D') row = "13";
        if (arr[0] == 'E') row = "14";
        if (arr[0] == 'F') row = "15";
        if (arr[1] == 'A') col = "10";
        if (arr[1] == 'B') col = "11";
        if (arr[1] == 'C') col = "12";
        if (arr[1] == 'D') col = "13";
        if (arr[1] == 'E') col = "14";
        if (arr[1] == 'F') col = "15";

        res[i][j] = sBox[int.parse(row)][int.parse(col)];
        print("${res[i][j]}  ");
      }
    }
    return res;
  }

  List<List<String>> _shiftRow(List<List<String>> plain) {
    String temp = "";
    for (int i = 1; i < 4; i++) {
      for (int j = 0; j < i; j++) {
        temp = plain[i][0];
        for (int k = 0; k < 3; k++) {
          plain[i][k] = plain[i][k + 1];
        }
        plain[i][3] = temp;
      }
    }
    print("shift");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${plain[i][j]}  ");
      }
    }
    return plain;
  }

  List<List<String>> _mixColMethod(List<List<String>> plain) {
    List<List<String>> multiply =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    List<String> arr = List.generate(4, (_) => '');
    int v = 0;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        v = 0;
        for (int k = 0; k < 4; k++) {
          String bin = _hexToBinary(plain[k][i]);
          if (_mix[j][k] == ("01")) {
            arr[v] = _hexToBinary(plain[k][i]);
          }
          if (_mix[j][k] == ("02")) {
            if (bin[0] == '0') {
              arr[v] = "${bin.substring(1)}0";
            } else {
              arr[v] = _xOR(("${bin.substring(1)}0"), _hexToBinary("1B"));
            }
          }
          if (_mix[j][k] == ("03")) {
            if (bin[0] == '0') {
              arr[v] = _xOR(("${bin.substring(1)}0"), bin);
            } else {
              String z = _xOR(("${bin.substring(1)}0"), _hexToBinary("1B"));
              arr[v] = _xOR(z, bin);
            }
          }
          v++;
        }
        String res = _xOR(arr[0], arr[1]);
        String res1 = _xOR(arr[2], res);
        String res2 = _xOR(arr[3], res1);

        multiply[i][j] = _binaryToHex(res2);
      }
    }
    print("mul");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${multiply[j][i]}  ");
      }
    }
    return multiply;
  }

  List<List<String>> _generateKey(List<List<String>> key, int round) {
    List<List<String>> res =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    String row, col;
    for (int j = 0; j < 4; j++) {
      String arr = key[j][3].toUpperCase();
      row = arr[0];
      col = arr[1];
      if (arr[0] == 'A') row = "10";
      if (arr[0] == 'B') row = "11";
      if (arr[0] == 'C') row = "12";
      if (arr[0] == 'D') row = "13";
      if (arr[0] == 'E') row = "14";
      if (arr[0] == 'F') row = "15";
      if (arr[1] == 'A') col = "10";
      if (arr[1] == 'B') col = "11";
      if (arr[1] == 'C') col = "12";
      if (arr[1] == 'D') col = "13";
      if (arr[1] == 'E') col = "14";
      if (arr[1] == 'F') col = "15";

      res[j][0] = sBox[int.parse(row)][int.parse(col)];
    }
    String temp = res[0][0];
    for (int k = 0; k < 3; k++) {
      res[k][0] = res[k + 1][0];
    }
    res[3][0] = temp;
    for (int i = 0; i < 4; i++) {
      String a =
          _xOR(_hexToBinary(key[i][round]), _hexToBinary(_rCON[i][round]));
      String b = _xOR(a, _hexToBinary(res[i][0]));
      res[i][0] = _binaryToHex(b);
    }
    int xo1 = 0, xo2 = 1;
    for (int j = 0; j < 3; j++) {
      for (int i = 0; i < 4; i++) {
        String b = _xOR(_hexToBinary(key[i][xo2]), _hexToBinary(res[i][xo1]));
        res[i][xo2] = _binaryToHex(b);
      }
      xo2++;
      xo1++;
    }
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        _transposeMatrixRes[j][i] = res[i][j];
      }
    }
    print("key");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${_transposeMatrixRes[i][j]}  ");
      }
    }
    return _transposeMatrixRes;
  }

  List<List<String>> _addRoundKey(
      List<List<String>> plain, List<List<String>> key) {
    List<List<String>> output =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        String x = _xOR(_hexToBinary(plain[j][i]), _hexToBinary(key[j][i]));
        output[i][j] = _binaryToHex(x);
      }
    }
    print("out");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${output[i][j]}  ");
      }
    }
    return output;
  }

  String _hexToBinary(String hex) {
    String bin = "";
    int i = 0;
//Dictionary<Char, String> hexDic = new Dictionary<char, string>()
    Map<String, String> hexDic = {
      "0": "0000",
      "1": "0001",
      "2": "0010",
      "3": "0011",
      "4": "0100",
      "5": "0101",
      "6": "0110",
      "7": "0111",
      "8": "1000",
      "9": "1001",
      "A": "1010",
      "B": "1011",
      "C": "1100",
      "D": "1101",
      "E": "1110",
      "F": "1111"
    };
    while (i < hex.length) {
      bin += hexDic[hex.toUpperCase()[i]] ?? "";
      i++;
    }
    return bin;
  }

  String _binaryToHex(String bin) {
    String hex = "";
    Map<String, String> binDic = {
      "0000": "0",
      "0001": "1",
      "0010": "2",
      "0011": "3",
      "0100": "4",
      "0101": "5",
      "0110": "6",
      "0111": "7",
      "1000": "8",
      "1001": "9",
      "1010": "A",
      "1011": "B",
      "1100": "C",
      "1101": "D",
      "1110": "E",
      "1111": "F"
    };
    String temp = "";
    for (int i = 0; i < bin.length; i++) {
      temp += bin[i];
      if (temp.length % 4 == 0) {
        hex += binDic[temp] ?? "";
        temp = "";
      }
    }

    return hex;
  }

  String _xOR(String plain, String key) {
    String res = "";
    for (int i = 0; i < plain.length; i++) {
      if (plain[i] == key[i]) {
        res += "0";
      } else {
        res += "1";
      }
    }

    return res;
  }

  List<List<String>> _invMixCol(List<List<String>> state) {
    List<List<String>> multiply =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    List<String> arr = List.generate(4, (_) => '');
    int v = 0;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        v = 0;
        for (int k = 0; k < 4; k++) {
          String bin = _hexToBinary(state[k][i]);
          // String x = state[k][i];
          if (_mixInv[j][k] == ("09")) {
            arr[v] = _bin_9(bin);
          }
          if (_mixInv[j][k] == ("0b")) {
            arr[v] = _bin_11(bin);
          }
          if (_mixInv[j][k] == ("0d")) {
            arr[v] = _bin_13(bin);
          }
          if (_mixInv[j][k] == ("0e")) {
            arr[v] = _bin_14(bin);
          }
          v++;
        }
        String res = _xOR(arr[0], arr[1]);
        String res1 = _xOR(arr[2], res);
        String res2 = _xOR(arr[3], res1);
        multiply[i][j] = _binaryToHex(res2);
      }
    }
    print("mul");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${multiply[j][i]}  ");
      }
    }
    return multiply;
  }

  String _mix2(String bin) {
    if (bin[0] == '0') {
      return "${bin.substring(1)}0";
    } else {
      return _xOR(("${bin.substring(1)}0"), _hexToBinary("1B"));
    }
  }

  String _bin_9(String bin) => _xOR(_mix2(_mix2(_mix2(bin))), bin);

  String _bin_11(String bin) => _xOR(_mix2(_xOR(_mix2(_mix2(bin)), bin)), bin);

  String _bin_13(String bin) => _xOR(_mix2(_mix2(_xOR(_mix2(bin), bin))), bin);

  String _bin_14(String bin) => _mix2(_xOR(_mix2(_xOR(_mix2(bin), bin)), bin));

  List<List<String>> _sBoxInv(List<List<String>> c) {
    print("sBox");
    List<List<String>> res =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    // String row, col;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // String arr = c[i][j];
        // row = arr[0];
        // col = arr[1];
        res[i][j] = _invBox[c[i][j].toLowerCase()] ?? "";
        // String z = res[i][j];
        print("${res[i][j]}  ");
      }
    }
    return res;
  }

  List<List<String>> _shiftRowInv(List<List<String>> plain) {
    String temp = "";
    for (int i = 1; i < 4; i++) {
      for (int j = 0; j < i; j++) {
        temp = plain[i][3];
        for (int k = 2; k >= 0; k--) {
// String s = plain[i][ k + 1];
// String v = plain[i, k];
          plain[i][k + 1] = plain[i][k];
        }
        plain[i][0] = temp;
      }
    }
    print("shift");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${plain[i][j]}  ");
      }
    }
    return plain;
  }

  List<List<String>> _trans(List<List<String>> c) {
    List<List<String>> finalKey =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        finalKey[j][i] = c[i][j];
      }
    }
    return finalKey;
  }

  List<List<String>> _addRoundKeyInv(
      List<List<String>> plain, List<List<String>> key) {
    List<List<String>> output =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // String x1 = key[j][i];
        String x = _xOR(_hexToBinary(plain[j][i]), _hexToBinary(key[j][i]));
        output[j][i] = _binaryToHex(x);
      }
    }
    print("out");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print("${output[i][j]}  ");
      }
    }
    return output;
  }

  String _encrypt(String plainText, String key) {
    String mainPlain = plainText;
    String mainKey = key;
    String cipherText = "0x";
    List<List<String>> keyMatrix =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    int c = 2;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        keyMatrix[j][i] = "${mainKey[c]}${mainKey[c + 1]}";
        c += 2;
      }
    }

    List<List<String>> plainMatrix =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    c = 2;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        plainMatrix[j][i] = _binaryToHex(_xOR(
            _hexToBinary("${mainPlain[c]}${mainPlain[c + 1]}"),
            _hexToBinary("${mainKey[c]}${mainKey[c + 1]}")));
        c += 2;
      }
    }
    int count = 0;
//r1
    _sBoxRes = _sBoxMethod(plainMatrix);
    _shiftRowPlain = _shiftRow(_sBoxRes);
    _mixColPlain = _mixColMethod(_shiftRowPlain);
    _finalRes = _generateKey(keyMatrix, count);
    _output = _addRoundKey(_mixColPlain, _finalRes);
    count++;
    while (count < 9) {
      _sBoxRes = _sBoxMethod(_output);
      _shiftRowPlain = _shiftRow(_sBoxRes);
      _mixColPlain = _mixColMethod(_shiftRowPlain);
      _finalRes = _generateKey2(_finalRes, count);
      _output = _addRoundKey(_mixColPlain, _finalRes);
      count++;
    }
    _sBoxRes = _sBoxMethod(_output);
    _shiftRowPlain = _shiftRow(_sBoxRes);
    _finalRes = _generateKey2(_finalRes, count);
    List<List<String>> finalKey =
        List.generate(4, (_) => List.generate(4, (_) => ''));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        finalKey[j][i] = _finalRes[i][j];
      }
    }
    _output = _addRoundKey(_shiftRowPlain, finalKey);
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        cipherText += _output[i][j];
      }
    }
    return cipherText;
  }
}
