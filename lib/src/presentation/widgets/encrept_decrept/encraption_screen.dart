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
  List<List<String>> sboxRes = [];
  List<List<String>> ShiftRowPlain = [];
  List<List<String>> MixColPlain = [];
  List<List<String>> finalRes = [];
  List<List<String>> output = [];
  List<List<String>> transposMatrixRes = []; //new String[4, 4];
  Map<String, String> Inv_Box = {};
  List<List<String>> sboxResInv = [];
  List<List<String>> ShiftRowPlainInv = [];
  List<List<String>> MixColPlainInv = [];
  List<List<String>> finalInv = [];
  List<List<String>> outputInv = [];
  List<List<String>>  MiXInv =
  [
    [ "0e","0b","0d","09"],
    [ "09","0e","0b","0d"],
    [ "0d","09","0e","0b"],
    [ "0b","0d","09","0e"]
  ];
List<List<String>>  sBox =
  [
  [ "63", "7c", "77", "7b", "f2", "6b", "6f", "c5", "30", "01", "67", "2b", "fe", "d7", "ab", "76"],
  [ "ca", "82", "c9", "7d", "fa", "59", "47", "f0", "ad", "d4", "a2", "af", "9c", "a4", "72", "c0"],
  [ "b7", "fd", "93", "26", "36", "3f", "f7", "cc", "34", "a5", "e5", "f1", "71", "d8", "31", "15"],
  [ "04", "c7", "23", "c3", "18", "96", "05", "9a", "07", "12", "80", "e2", "eb", "27", "b2", "75"],
  [ "09", "83", "2c", "1a", "1b", "6e", "5a", "a0", "52", "3b", "d6", "b3", "29", "e3", "2f", "84"],
  [ "53", "d1", "00", "ed", "20", "fc", "b1", "5b", "6a", "cb", "be", "39", "4a", "4c", "58", "cf"],
  [ "d0", "ef", "aa", "fb", "43", "4d", "33", "85", "45", "f9", "02", "7f", "50", "3c", "9f", "a8"],
  [ "51", "a3", "40", "8f", "92", "9d", "38", "f5", "bc", "b6", "da", "21", "10", "ff", "f3", "d2"],
  [ "cd", "0c", "13", "ec", "5f", "97", "44", "17", "c4", "a7", "7e", "3d", "64", "5d", "19", "73"],
  [ "60", "81", "4f", "dc", "22", "2a", "90", "88", "46", "ee", "b8", "14", "de", "5e", "0b", "db"],
  [ "e0", "32", "3a", "0a", "49", "06", "24", "5c", "c2", "d3", "ac", "62", "91", "95", "e4", "79"],
  [ "e7", "c8", "37", "6d", "8d", "d5", "4e", "a9", "6c", "56", "f4", "ea", "65", "7a", "ae", "08"],
  [ "ba", "78", "25", "2e", "1c", "a6", "b4", "c6", "e8", "dd", "74", "1f", "4b", "bd", "8b", "8a"],
  [ "70", "3e", "b5", "66", "48", "03", "f6", "0e", "61", "35", "57", "b9", "86", "c1", "1d", "9e"],
  [ "e1", "f8", "98", "11", "69", "d9", "8e", "94", "9b", "1e", "87", "e9", "ce", "55", "28", "df"],
  [ "8c", "a1", "89", "0d", "bf", "e6", "42", "68", "41", "99", "2d", "0f", "b0", "54", "bb", "16"]
  ];

List<List<String>> Rcon =
[
[ "01","02","04","08","10","20","40","80","1b","36"],
[ "00","00","00","00","00","00","00","00","00","00"],
[ "00","00","00","00","00","00","00","00","00","00"],
[ "00","00","00","00","00","00","00","00","00","00"]
];
List<List<String>> MiX =
[
[ "02","03","01","01"],
[ "01","02","03","01"],
[ "01","01","02","03"],
[ "03","01","01","02"]
];
  @override
  void initState() {
    super.initState();
    transposMatrixRes = List.generate(4, (index) => List.generate(4, (_) => '')).toList();
    initializeSBoxInv();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void initializeSBoxInv() {
    Inv_Box["00"]= "52";
    Inv_Box["10"]= "7c";
    Inv_Box["20"]= "54";
    Inv_Box["30"]= "08";
    Inv_Box["40"]= "72";
    Inv_Box["50"]= "6c";
    Inv_Box["60"]= "90";
    Inv_Box["70"]= "d0";
    Inv_Box["80"]= "3a";
    Inv_Box["90"]= "96";
    Inv_Box["a0"]= "47";
    Inv_Box["b0"]= "fc";
    Inv_Box["c0"]= "1f";
    Inv_Box["d0"]= "60";
    Inv_Box["e0"]= "a0";
    Inv_Box["f0"]= "17";


    Inv_Box["01"]= "09";
    Inv_Box["11"]= "e3";
    Inv_Box["21"]= "7b";
    Inv_Box["31"]= "2e";
    Inv_Box["41"]= "f8";
    Inv_Box["51"]= "70";
    Inv_Box["61"]= "d8";
    Inv_Box["71"]= "2c";
    Inv_Box["81"]= "91";
    Inv_Box["91"]= "ac";
    Inv_Box["a1"]= "f1";
    Inv_Box["b1"]= "56";
    Inv_Box["c1"]= "dd";
    Inv_Box["d1"]= "51";
    Inv_Box["e1"]= "e0";
    Inv_Box["f1"]= "2b";

    Inv_Box["02"]= "6a";
    Inv_Box["12"]= "39";
    Inv_Box["22"]= "94";
    Inv_Box["32"]= "a1";
    Inv_Box["42"]= "f6";
    Inv_Box["52"]= "48";
    Inv_Box["62"]= "ab";
    Inv_Box["72"]= "1e";
    Inv_Box["82"]= "11";
    Inv_Box["92"]= "74";
    Inv_Box["a2"]= "1a";
    Inv_Box["b2"]= "3e";
    Inv_Box["c2"]= "a8";
    Inv_Box["d2"]= "7f";
    Inv_Box["e2"]= "3b";
    Inv_Box["f2"]= "04";

    Inv_Box["03"]= "d5";
    Inv_Box["13"]= "82";
    Inv_Box["23"]= "32";
    Inv_Box["33"]= "66";
    Inv_Box["43"]= "64";
    Inv_Box["53"]= "50";
    Inv_Box["63"]= "00";
    Inv_Box["73"]= "8f";
    Inv_Box["83"]= "41";
    Inv_Box["93"]= "22";
    Inv_Box["a3"]= "71";
    Inv_Box["b3"]= "4b";
    Inv_Box["c3"]= "33";
    Inv_Box["d3"]= "a9";
    Inv_Box["e3"]= "4d";
    Inv_Box["f3"]= "7e";

    Inv_Box["04"]= "30";
    Inv_Box["14"]= "9b";
    Inv_Box["24"]= "a6";
    Inv_Box["34"]= "28";
    Inv_Box["44"]= "86";
    Inv_Box["54"]= "fd";
    Inv_Box["64"]= "8c";
    Inv_Box["74"]= "ca";
    Inv_Box["84"]= "4f";
    Inv_Box["94"]= "e7";
    Inv_Box["a4"]= "1d";
    Inv_Box["b4"]= "c6";
    Inv_Box["c4"]= "88";
    Inv_Box["d4"]= "19";
    Inv_Box["e4"]= "ae";
    Inv_Box["f4"]= "ba";

    Inv_Box["05"]= "36";
    Inv_Box["15"]= "2f";
    Inv_Box["25"]= "c2";
    Inv_Box["35"]= "d9";
    Inv_Box["45"]= "68";
    Inv_Box["55"]= "ed";
    Inv_Box["65"]= "bc";
    Inv_Box["75"]= "3f";
    Inv_Box["85"]= "67";
    Inv_Box["95"]= "ad";
    Inv_Box["a5"]= "29";
    Inv_Box["b5"]= "d2";
    Inv_Box["c5"]= "07";
    Inv_Box["d5"]= "b5";
    Inv_Box["e5"]= "2a";
    Inv_Box["f5"]= "77";

    Inv_Box["06"]= "a5";
    Inv_Box["16"]= "ff";
    Inv_Box["26"]= "23";
    Inv_Box["36"]= "24";
    Inv_Box["46"]= "98";
    Inv_Box["56"]= "b9";
    Inv_Box["66"]= "d3";
    Inv_Box["76"]= "0f";
    Inv_Box["86"]= "dc";
    Inv_Box["96"]= "35";
    Inv_Box["a6"]= "c5";
    Inv_Box["b6"]= "79";
    Inv_Box["c6"]= "c7";
    Inv_Box["d6"]= "4a";
    Inv_Box["e6"]= "f5";
    Inv_Box["f6"]= "d6";

    Inv_Box["07"]= "38";
    Inv_Box["17"]= "87";
    Inv_Box["27"]= "3d";
    Inv_Box["37"]= "b2";
    Inv_Box["47"]= "16";
    Inv_Box["57"]= "da";
    Inv_Box["67"]= "0a";
    Inv_Box["77"]= "02";
    Inv_Box["87"]= "ea";
    Inv_Box["97"]= "85";
    Inv_Box["a7"]= "89";
    Inv_Box["b7"]= "20";
    Inv_Box["c7"]= "31";
    Inv_Box["d7"]= "0d";
    Inv_Box["e7"]= "b0";
    Inv_Box["f7"]= "26";

    Inv_Box["08"]= "bf";
    Inv_Box["18"]= "34";
    Inv_Box["28"]= "ee";
    Inv_Box["38"]= "76";
    Inv_Box["48"]= "d4";
    Inv_Box["58"]= "5e";
    Inv_Box["68"]= "f7";
    Inv_Box["78"]= "c1";
    Inv_Box["88"]= "97";
    Inv_Box["98"]= "e2";
    Inv_Box["a8"]= "6f";
    Inv_Box["b8"]= "9a";
    Inv_Box["c8"]= "b1";
    Inv_Box["d8"]= "2d";
    Inv_Box["e8"]= "c8";
    Inv_Box["f8"]= "e1";

    Inv_Box["09"]= "40";
    Inv_Box["19"]= "8e";
    Inv_Box["29"]= "4c";
    Inv_Box["39"]= "5b";
    Inv_Box["49"]= "a4";
    Inv_Box["59"]= "15";
    Inv_Box["69"]= "e4";
    Inv_Box["79"]= "af";
    Inv_Box["89"]= "f2";
    Inv_Box["99"]= "f9";
    Inv_Box["a9"]= "b7";
    Inv_Box["b9"]= "db";
    Inv_Box["c9"]= "12";
    Inv_Box["d9"]= "e5";
    Inv_Box["e9"]= "eb";
    Inv_Box["f9"]= "69";

    Inv_Box["0a"]= "a3";
    Inv_Box["1a"]= "43";
    Inv_Box["2a"]= "95";
    Inv_Box["3a"]= "a2";
    Inv_Box["4a"]= "5c";
    Inv_Box["5a"]= "46";
    Inv_Box["6a"]= "58";
    Inv_Box["7a"]= "bd";
    Inv_Box["8a"]= "cf";
    Inv_Box["9a"]= "37";
    Inv_Box["aa"]= "62";
    Inv_Box["ba"]= "c0";
    Inv_Box["ca"]= "10";
    Inv_Box["da"]= "7a";
    Inv_Box["ea"]= "bb";
    Inv_Box["fa"]= "14";

    Inv_Box["0b"]= "9e";
    Inv_Box["1b"]= "44";
    Inv_Box["2b"]= "0b";
    Inv_Box["3b"]= "49";
    Inv_Box["4b"]= "cc";
    Inv_Box["5b"]= "57";
    Inv_Box["6b"]= "05";
    Inv_Box["7b"]= "03";
    Inv_Box["8b"]= "ce";
    Inv_Box["9b"]= "e8";
    Inv_Box["ab"]= "0e";
    Inv_Box["bb"]= "fe";
    Inv_Box["cb"]= "59";
    Inv_Box["db"]= "9f";
    Inv_Box["eb"]= "3c";
    Inv_Box["fb"]= "63";

    Inv_Box["0c"]= "81";
    Inv_Box["1c"]= "c4";
    Inv_Box["2c"]= "42";
    Inv_Box["3c"]= "6d";
    Inv_Box["4c"]= "5d";
    Inv_Box["5c"]= "a7";
    Inv_Box["6c"]= "b8";
    Inv_Box["7c"]= "01";
    Inv_Box["8c"]= "f0";
    Inv_Box["9c"]= "1c";
    Inv_Box["ac"]= "aa";
    Inv_Box["bc"]= "78";
    Inv_Box["cc"]= "27";
    Inv_Box["dc"]= "93";
    Inv_Box["ec"]= "83";
    Inv_Box["fc"]= "55";

    Inv_Box["0d"]= "f3";
    Inv_Box["1d"]= "de";
    Inv_Box["2d"]= "fa";
    Inv_Box["3d"]= "8b";
    Inv_Box["4d"]= "65";
    Inv_Box["5d"]= "8d";
    Inv_Box["6d"]= "b3";
    Inv_Box["7d"]= "13";
    Inv_Box["8d"]= "b4";
    Inv_Box["9d"]= "75";
    Inv_Box["ad"]= "18";
    Inv_Box["bd"]= "cd";
    Inv_Box["cd"]= "80";
    Inv_Box["dd"]= "c9";
    Inv_Box["ed"]= "53";
    Inv_Box["fd"]= "21";

    Inv_Box["0e"]= "d7";
    Inv_Box["1e"]= "e9";
    Inv_Box["2e"]= "c3";
    Inv_Box["3e"]= "d1";
    Inv_Box["4e"]= "b6";
    Inv_Box["5e"]= "9d";
    Inv_Box["6e"]= "45";
    Inv_Box["7e"]= "8a";
    Inv_Box["8e"]= "e6";
    Inv_Box["9e"]= "df";
    Inv_Box["ae"]= "be";
    Inv_Box["be"]= "5a";
    Inv_Box["ce"]= "ec";
    Inv_Box["de"]= "9c";
    Inv_Box["ee"]= "99";
    Inv_Box["fe"]= "0c";

    Inv_Box["0f"]= "fb";
    Inv_Box["1f"]= "cb";
    Inv_Box["2f"]= "4e";
    Inv_Box["3f"]= "25";
    Inv_Box["4f"]= "92";
    Inv_Box["5f"]= "84";
    Inv_Box["6f"]= "06";
    Inv_Box["7f"]= "6b";
    Inv_Box["8f"]= "73";
    Inv_Box["9f"]= "6e";
    Inv_Box["af"]= "1b";
    Inv_Box["bf"]= "f4";
    Inv_Box["cf"]= "5f";
    Inv_Box["df"]= "ef";
    Inv_Box["ef"]= "61";
    Inv_Box["ff"]= "7d";
  }


String Decrypt(String cipherText, String key)
{
String mainCipher = cipherText;
String mainKey = key;
String Plain = "0x";
List<Keys>arr=[];
// Keys[] arr = new Keys[10];
  List<List<String>>o=List.generate(4, (index) => List.generate(4, (_) => ''));
// String[,] o = new String[4, 4];
  List<List<String>>KeyMatrix=List.generate(4, (index) => List.generate(4, (_) => ''));
// String[,] KeyMatrix = new string[4, 4];
int c = 2;
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
KeyMatrix[j][ i] = "${mainKey[c]}${mainKey[c+1]}";
c += 2;
}
}

List<List<String>> CipherMatrix = List.generate(4, (_) =>List.generate(4,(_)=>''));
c = 2;
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
CipherMatrix[j][i] = "${mainCipher[c]}${mainCipher[c+1]}";
c += 2;
}
}
int count = 0;
arr[count].key = GenerateKey(KeyMatrix, count);
count++;
while (count < 9)
{
arr[count].key = GenerateKey2(arr[count - 1].key, count);
count++;
}
arr[count].key = GenerateKey2(arr[count - 1].key, count);

count = 8;
outputInv = AddRoundKeyInv(CipherMatrix, trans(arr[9].key));
while (count >= 0)
{
ShiftRowPlainInv = ShiftRowInv(outputInv);
sboxResInv = sBoxInv(ShiftRowPlainInv);
finalInv = AddRoundKeyInv(sboxResInv, trans(arr[count].key));
outputInv = InvMixCol(finalInv);
outputInv = trans(outputInv);
count--;
}
ShiftRowPlainInv = ShiftRowInv(outputInv);
sboxResInv = sBoxInv(ShiftRowPlainInv);

for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
o[i][ j] = BinaryToHex(XOR(HexToBinary(KeyMatrix[i][ j]), HexToBinary(sboxResInv[i][ j])));
}
}
o = trans(o);
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 4; j++) {
  Plain += o[i][ j];
}
}
return Plain.toLowerCase();
}
 List<List<String>> GenerateKey2(List<List<String>> ky, int round)
{
List<List<String>> ssss = List.generate(4, (_) =>List.generate(4,(_)=>''));
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 4; j++) {
  ssss[j][i] = ky[i][ j];
}
}
List<List<String>> res =  List.generate(4, (_) =>List.generate(4,(_)=>''));
String row, col;
for (int j = 0; j < 4; j++)
{
String arr = ssss[j][ 3].toUpperCase();
row = arr[0]; col = arr[1];
if (arr[0] == 'A') row = "10"; if (arr[0] == 'B') row = "11"; if (arr[0] == 'C') row = "12"; if (arr[0] == 'D') row = "13"; if (arr[0] == 'E') row = "14"; if (arr[0] == 'F') row = "15";
if (arr[1] == 'A') col = "10"; if (arr[1] == 'B') col = "11"; if (arr[1] == 'C') col = "12"; if (arr[1] == 'D') col = "13"; if (arr[1] == 'E') col = "14"; if (arr[1] == 'F') col = "15";

res[j][ 0] = sBox[int.parse(row)][ int.parse(col)];
}
String temp = res[0][0];
for (int k = 0; k < 3; k++)
{
res[k][ 0] = res[k + 1][ 0];
}
res[3][ 0] = temp;
for (int i = 0; i < 4; i++)
{
String a = XOR(HexToBinary(ssss[i][ 0]), HexToBinary(Rcon[i][round]));
String b = XOR(a, HexToBinary(res[i][ 0]));
res[i][ 0] = BinaryToHex(b);
}
int xo1 = 0, xo2 = 1;
for (int j = 0; j < 3; j++)
{
for (int i = 0; i < 4; i++)
{
String b = XOR(HexToBinary(ssss[i][ xo2]), HexToBinary(res[i][xo1]));
res[i][ xo2] = BinaryToHex(b);
}
xo2++; xo1++;
}
List<List<String>> output1 =  List.generate(4, (_) =>List.generate(4,(_)=>''));

for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 4; j++) {
  output1[j][i] = res[i][ j];
}
}
print("key");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
print("${res[i][ j]}  ");
}
}
return output1;
}
List<List<String>> sBoxMethod(List<List<String>> plain)
{
print("sbox");

List<List<String>> res = List.generate(4, (_) =>List.generate(4,(_)=>''));
String row, col;
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
String arr = plain[i][ j].toUpperCase();
row = arr[0]; col = arr[1];
if (arr[0] == 'A') row = "10"; if (arr[0] == 'B') row = "11"; if (arr[0] == 'C') row = "12"; if (arr[0] == 'D') row = "13"; if (arr[0] == 'E') row = "14"; if (arr[0] == 'F') row = "15";
if (arr[1] == 'A') col = "10"; if (arr[1] == 'B') col = "11"; if (arr[1] == 'C') col = "12"; if (arr[1] == 'D') col = "13"; if (arr[1] == 'E') col = "14"; if (arr[1] == 'F') col = "15";

res[i][j] = sBox[int.parse(row)][ int.parse(col)];
String z = res[i][ j];
print("${res[i][ j]}  ");

}
}
return res;
}
 List<List<String>> ShiftRow(List<List<String>> plain)
{
String temp = "";
for (int i = 1; i < 4; i++)
{
for (int j = 0; j < i; j++)
{
temp = plain[i][ 0];
for (int k = 0; k < 3; k++)
{
plain[i][ k] = plain[i][ k + 1];
}
plain[i][ 3] = temp;
}
}
print("shift");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
print("${plain[i][ j]}  ");
}
}
return plain;
}
 List<List<String>> MixColMethod(List<List<String>> plain)
{
List<List<String>> Multiply = List.generate(4, (_) =>List.generate(4,(_)=>''));
List<String> arr = List.generate(4, (_) =>'');
int v = 0;
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
v = 0;
for (int k = 0; k < 4; k++)
{
String bin = HexToBinary(plain[k][ i]);
if (MiX[j][ k]==("01"))
{
arr[v] = HexToBinary(plain[k][ i]);
}
if (MiX[j][ k]==("02"))
{
String x = plain[k][ i];
if (bin[0] == '0')
{
arr[v] = bin.Remove(0, 1) + "0";
}
else
{
arr[v] = XOR((bin.Remove(0, 1) + "0"), HexToBinary("1B"));
}
}
if (MiX[j][k]==("03"))
{
if (bin[0] == '0') {
  arr[v] = XOR((bin.Remove(0, 1) + "0"), bin);
} else
{
String z = XOR((bin.Remove(0, 1) + "0"), HexToBinary("1B"));
arr[v] = XOR(z, bin);
}
}
v++;
}
String res = XOR(arr[0], arr[1]);
String res1 = XOR(arr[2], res);
String res2 = XOR(arr[3], res1);

Multiply[i][ j] = BinaryToHex(res2);
}
}
print("mul");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
print("${Multiply[j][i]}  ");
}
}
return Multiply;
}
  List<List<String>> GenerateKey(List<List<String>> key, int round)
{
List<List<String>> res = List.generate(4, (_) =>List.generate(4,(_)=>''));
String row, col;
for (int j = 0; j < 4; j++)
{
String arr = key[j][3].toUpperCase();
row = arr[0]; col = arr[1];
if (arr[0] == 'A') row = "10"; if (arr[0] == 'B') row = "11"; if (arr[0] == 'C') row = "12"; if (arr[0] == 'D') row = "13"; if (arr[0] == 'E') row = "14"; if (arr[0] == 'F') row = "15";
if (arr[1] == 'A') col = "10"; if (arr[1] == 'B') col = "11"; if (arr[1] == 'C') col = "12"; if (arr[1] == 'D') col = "13"; if (arr[1] == 'E') col = "14"; if (arr[1] == 'F') col = "15";

res[j][ 0] = sBox[int.parse(row)][ int.parse(col)];
}
String temp = res[0][ 0];
for (int k = 0; k < 3; k++)
{
res[k][ 0] = res[k + 1][ 0];
}
res[3][ 0] = temp;
for (int i = 0; i < 4; i++)
{
String a = XOR(HexToBinary(key[i][ round]), HexToBinary(Rcon[i][round]));
String b = XOR(a, HexToBinary(res[i][0]));
res[i][ 0] = BinaryToHex(b);
}
int xo1 = 0, xo2 = 1;
for (int j = 0; j < 3; j++)
{
for (int i = 0; i < 4; i++)
{
String b = XOR(HexToBinary(key[i][ xo2]), HexToBinary(res[i][ xo1]));
res[i][ xo2] = BinaryToHex(b);
}
xo2++; xo1++;
}
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 4; j++) {
  transposMatrixRes[j][ i] = res[i][ j];
}
}
print("key");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
print("${transposMatrixRes[i][ j]}  ");
}
}
return transposMatrixRes;
}
 List<List<String>> AddRoundKey(List<List<String>> plain, List<List<String>> key)
{
List<List<String>> output = List.generate(4, (_) =>List.generate(4,(_)=>''));
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
String x1 = key[j][ i];
String x = XOR(HexToBinary(plain[j][ i]), HexToBinary(key[j][ i]));
output[i][ j] = BinaryToHex(x);
}
}
print("out");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
print(output[i][ j] + "  ");
}
}
return output;
}
static String HexToBinary(String hex)
{
String bin = "";
int i = 0;
Dictionary<Char, String> hexDic = new Dictionary<char, string>()
{
{'0',"0000" }, {'1',"0001" }, {'2',"0010" }, {'3',"0011" },
{'4',"0100" }, {'5',"0101" }, {'6',"0110" }, {'7',"0111" },
{'8',"1000" }, {'9',"1001" }, {'A',"1010" }, {'B',"1011" },
{'C',"1100" }, {'D',"1101" }, {'E',"1110" }, {'F',"1111" }
};
while (i < hex.Length)
{
bin += hexDic[hex.ToUpper()[i]];
i++;
}
return bin;
}
static String BinaryToHex(String bin)
{
String hex = "";
Dictionary<String, String> binDic = new Dictionary<String, string>()
{
{"0000","0" }, {"0001","1" }, {"0010","2" }, {"0011","3" },
{"0100","4" }, {"0101","5" }, {"0110","6" }, {"0111","7" },
{"1000","8" }, {"1001","9" }, {"1010","A" }, {"1011","B" },
{"1100","C" }, {"1101","D" }, {"1110","E" }, {"1111","F" }
};
String temp = "";
for (int i = 0; i < bin.Length; i++)
{
temp += bin[i];
if (temp.Length % 4 == 0)
{
hex += binDic[temp];
temp = "";
}
}

return hex;
}
static String XOR(String plain, String Key)
{
String res = "";
for (int i = 0; i < plain.Length; i++)
{
if (plain[i] == Key[i]) {
  res += "0";
} else {
  res += "1";
}
}

return res;
}
static List<List<String>> InvMixCol(List<List<String>> State)
{
List<List<String>> Multiply = new string[4, 4];
String[] arr = new string[4];
int v = 0;
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
v = 0;
for (int k = 0; k < 4; k++)
{
String bin = HexToBinary(State[k, i]);
String x = State[k, i];
if (MiXInv[j, k].Equals("09"))
{
arr[v] = bin_9(bin);
}
if (MiXInv[j, k].Equals("0b"))
{

arr[v] = bin_11(bin);
}
if (MiXInv[j, k].Equals("0d"))
{

arr[v] = bin_13(bin);
}
if (MiXInv[j, k].Equals("0e"))
{

arr[v] = bin_14(bin);
}
v++;
}
String res = XOR(arr[0], arr[1]);
String res1 = XOR(arr[2], res);
String res2 = XOR(arr[3], res1);
Multiply[i, j] = BinaryToHex(res2);
}
}
Console.WriteLine("mul");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
Console.Write(Multiply[j, i] + "  ");
}
Console.WriteLine();
}
return Multiply;
}
static String mix2(String bin)
{
if (bin[0] == '0')
{
String s = bin.Remove(0, 1) + "0";
return bin.Remove(0, 1) + "0";
}
else
{
String s = XOR((bin.Remove(0, 1) + "0"), HexToBinary("1B"));
return XOR((bin.Remove(0, 1) + "0"), HexToBinary("1B"));
}
}
static String bin_9(String bin)
{
String res = XOR(mix2(mix2(mix2(bin))), bin);
return res;
}
static String bin_11(String bin)
{
String res = XOR(mix2(XOR(mix2(mix2(bin)), bin)), bin);
return res;
}
static String bin_13(String bin)
{
String res = XOR(mix2(mix2(XOR(mix2(bin), bin))), bin);
return res;

}
static String bin_14(String bin)
{
String res = mix2(XOR(mix2(XOR(mix2(bin), bin)), bin));
return res;

}
static List<List<String>> sBoxInv(List<List<String>> c)
{
Console.WriteLine("sbox");
List<List<String>> res = new string[4, 4];
String row, col;
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
String arr = c[i, j];
row = arr[0]; col = arr[1];
res[i, j] = Inv_Box[c[i, j].ToLower()];
String z = res[i, j];
Console.Write(res[i, j] + "  ");

}
Console.WriteLine();
}
return res;
}
static List<List<String>> ShiftRowInv(List<List<String>> plain)
{
String temp = "";
for (int i = 1; i < 4; i++)
{
for (int j = 0; j < i; j++)
{
temp = plain[i, 3];
for (int k = 2; k >= 0; k--)
{
String s = plain[i, k + 1];
String v = plain[i, k];
plain[i, k + 1] = plain[i, k];
}
plain[i, 0] = temp;
}
}
Console.WriteLine("shift");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
Console.Write(plain[i, j] + "  ");
}
Console.WriteLine();
}
return plain;
}
static List<List<String>> trans(List<List<String>> c)
{
List<List<String>> finalKey = new String[4, 4];
for (int i = 0; i < 4; i++)
for (int j = 0; j < 4; j++) {
  finalKey[j, i] = c[i, j];
}
return finalKey;
}
static List<List<String>> AddRoundKeyInv(List<List<String>> plain, List<List<String>> key)
{
List<List<String>> output = new String[4, 4];
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
String x1 = key[j, i];
String x = XOR(HexToBinary(plain[j, i]), HexToBinary(key[j, i]));
output[j, i] = BinaryToHex(x);
}
}
Console.WriteLine("out");
for (int i = 0; i < 4; i++)
{
for (int j = 0; j < 4; j++)
{
Console.Write(output[i, j] + "  ");
}
Console.WriteLine();
}
return output;
}
// public override string Encrypt(string plainText, string key)
// {
// string mainPlain = plainText;
// string mainKey = key;
// string cipherText = "0x";
// List<List<String>> KeyMatrix = new string[4, 4];
// int c = 2;
// for (int i = 0; i < 4; i++)
// {
// for (int j = 0; j < 4; j++)
// {
// KeyMatrix[j, i] = mainKey.ElementAt(c) + "" + mainKey.ElementAt(c + 1) + "";
// c += 2;
// }
// }
//
// String[,] PlainMatrix = new string[4, 4];
// c = 2;
// for (int i = 0; i < 4; i++)
// {
// for (int j = 0; j < 4; j++)
// {
// PlainMatrix[j, i] = BinaryToHex(XOR(HexToBinary(mainPlain.ElementAt(c) + "" + mainPlain.ElementAt(c + 1)), HexToBinary(mainKey.ElementAt(c) + "" + mainKey.ElementAt(c + 1))));
// c += 2;
// }
// }
// int count = 0;
// //r1
// sboxRes = sBoxMethod(PlainMatrix);
// ShiftRowPlain = ShiftRow(sboxRes);
// MixColPlain = MixColMethod(ShiftRowPlain);
// final = GenerateKey(KeyMatrix, count);
// output = AddRoundKey(MixColPlain, final);
// count++;
// while (count < 9)
// {
// sboxRes = sBoxMethod(output);
// ShiftRowPlain = ShiftRow(sboxRes);
// MixColPlain = MixColMethod(ShiftRowPlain);
// final = GenerateKey2(final, count);
// output = AddRoundKey(MixColPlain, final);
// count++;
// }
// sboxRes = sBoxMethod(output);
// ShiftRowPlain = ShiftRow(sboxRes);
// final = GenerateKey2(final, count);
// String[,] finalKey = new String[4, 4];
// for (int i = 0; i < 4; i++)
// for (int j = 0; j < 4; j++)
// finalKey[j, i] = final[i, j];
// output = AddRoundKey(ShiftRowPlain, finalKey);
// for (int i = 0; i < 4; i++)
// for (int j = 0; j < 4; j++)
// cipherText += output[i, j];
// return cipherText;
// }
//  }
}
