import 'package:flutter/material.dart';

class DraggbleShopScreen extends StatefulWidget {
  const DraggbleShopScreen({super.key});

  @override
  State<DraggbleShopScreen> createState() => _DraggbleShopScreenState();
}

class _DraggbleShopScreenState extends State<DraggbleShopScreen> {
  int cardNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffffc3ff),
                Color(0xff008811),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                //دا البحك فيه ال الجسم البحركه ولو حطيت صح بيرجع الداتا
                // في اون اكسبت والبلدر دا فيه كود التارجت اوبجكت
                child: DragTarget(
                  onAccept: (data) {
                    cardNumber += int.parse(data.toString());
                    setState(() {});
                  },
                  builder: (ctx, canditeData, rejectData) {
                    return Container(
                      margin: const EdgeInsets.all(30),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Center(
                            child: Text(
                          cardNumber.toString(),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (ctx, idx) {
                      return buildItem(ctx);
                    },
                    separatorBuilder: (ctx, idx) {
                      return const SizedBox(
                        height: 2,
                      );
                    },
                    itemCount: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //دي ببعت فيها الداتا وبتاخد فيدباك دا كود الجسم وهو بيتحرك وفيها اتشيلد دا الجسم قبل ما احركه
      child: Draggable(
        data: 1,
        feedback: Image.asset(
          "assets/images/shoes.jpg",
          width: 50,
          height: 50,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
              child: Image.asset(
            "assets/images/shoes.jpg",
            width: 100,
            height: 100,
          )),
        ),
        onDraggableCanceled: (velocity, offset) {},
      ),
    );
  }
}
