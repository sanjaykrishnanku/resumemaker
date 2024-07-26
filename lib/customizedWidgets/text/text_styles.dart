import 'package:flutter/material.dart';

class HeadingTextstyle extends StatefulWidget {
  const  HeadingTextstyle({super.key, required this.content,this.fontsize,this.overflow});
  final String content;
  final double?fontsize;
  final TextOverflow? overflow;


  @override
  State<HeadingTextstyle> createState() => _HeadingTextstyleState();
}

class _HeadingTextstyleState extends State<HeadingTextstyle> {
  @override
  Widget build(BuildContext context) {
    return  Text(
      widget.content,
      style:  TextStyle(
        shadows: const [
          // Shadow(blurRadius: .1,color: Colors.black,offset: Offset(1,1))
        ],
        color: Colors.black,
        fontSize: widget.fontsize??35,
        fontWeight: FontWeight.w700,
        overflow:widget.overflow??TextOverflow.ellipsis
      ),
    );
  }
}

class Smalltext extends StatelessWidget {
  const Smalltext({super.key,required this.content});
final String content;
  @override
  Widget build(BuildContext context) {
    return  Text(
      content,
      style:const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
