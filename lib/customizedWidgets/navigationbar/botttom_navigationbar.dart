import 'package:flutter/material.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';

int currentindex = 0;
Color botnavbarcolor1=primarycolor
//  Colors.transparent
 // Color.fromARGB(255, 110, 34, 163)
 ;
 Color botnavbarcolor2=
//   botnavbarcolor2
 Colors.transparent
 ;

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key, final screenwidth, final screenheight});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    final eachiconwidth = (screenWidth - 40 - (screenWidth * 0.1)) / 6;

    return Container(
      height: 50,
      width: screenWidth - 30,
      decoration:  BoxDecoration(
          color: botnavbarcolor1,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        AnimatedContainer(
          width: currentindex == 0 ? eachiconwidth : eachiconwidth,
          height: currentindex == 0 ? 60 : 80,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: currentindex == 0
                  ? botnavbarcolor2
                  :  botnavbarcolor1,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              currentindex == 0
                  ? Icons.person_2_rounded
                  : Icons.person_outline_outlined,
              color: Colors.white,
              size: currentindex == 0 ? 35 : 40,
            ),
            onPressed: () {
              setState(() {
                currentindex = 0;
              });
            },
          ),
        ),
        AnimatedContainer(
          width: currentindex == 1 ? eachiconwidth : eachiconwidth,
          height: currentindex == 1 ? 60 : 80,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: currentindex == 1
                  ? botnavbarcolor2
                  :  botnavbarcolor1,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              currentindex == 1 ? Icons.school : Icons.school_outlined,
              color: Colors.white,
              size: currentindex == 1 ? 30 : 40,
            ),
            onPressed: () {
              setState(() {
                currentindex = 1;
              });
            },
          ),
        ),
        AnimatedContainer(
          width: currentindex == 2 ? eachiconwidth : eachiconwidth,
          height: currentindex == 2 ? 60 : 80,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: currentindex == 2
                  ? botnavbarcolor2
                  : botnavbarcolor1,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              currentindex == 2
                  ? Icons.engineering
                  : Icons.engineering_outlined,
              color: Colors.white,
              size: currentindex == 2 ? 30 : 40,
            ),
            onPressed: () {
              setState(() {
                currentindex = 2;
              });
            },
          ),
        ),
        AnimatedContainer(
          width: currentindex == 3 ? eachiconwidth : eachiconwidth,
          height: currentindex == 3 ? 60 : 80,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: currentindex == 3
                  ? botnavbarcolor2
                  :  botnavbarcolor1,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              currentindex == 3
                  ? Icons.emoji_objects
                  : Icons.emoji_objects_outlined,
              color: Colors.white,
              size: currentindex == 3 ? 30 : 40,
            ),
            onPressed: () {
              setState(() {
                currentindex = 3;
              });
            },
          ),
        ),
        AnimatedContainer(
          width: currentindex == 4 ? eachiconwidth : eachiconwidth,
          height: currentindex == 4 ? 60 : 80,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: currentindex == 4
                  ? botnavbarcolor2
                  :  botnavbarcolor1,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              currentindex == 4 ? Icons.psychology : Icons.psychology_outlined,
              color: Colors.white,
              size: currentindex == 4 ? 30 : 40,
            ),
            onPressed: () {
              setState(() {
                currentindex = 4;
              });
            },
          ),
        ),
        AnimatedContainer(
          width: currentindex == 5 ? eachiconwidth : eachiconwidth,
          height: currentindex == 5 ? 60 : 80,
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
              color: currentindex == 5
                  ? botnavbarcolor2: 
                   botnavbarcolor1,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              currentindex == 5
                  ? Icons.account_circle_rounded
                  : Icons.account_circle_outlined,
              color: Colors.white,
              size: currentindex == 5 ? 30 : 40,
            ),
            onPressed: () {
              setState(() {
                currentindex = 5;
              });
            },
          ),
        ),
      ]),
    );
  }
}
