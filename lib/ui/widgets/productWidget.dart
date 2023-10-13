import 'package:flutter/material.dart';

Widget productsss(
    {required String code, required String title, required String desc}) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 110,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          blurRadius: 10,
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3)
    ], borderRadius: BorderRadius.circular(25), color: Colors.white),
    child: Container(
      padding: const EdgeInsets.all(1),
      child: Row(
        children: [
          Text(
            code,

          ),
          const  SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:const TextStyle(),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                desc,
                style:const TextStyle(),
              ),
            ],
          )
        ],
      ),
    ),
  );
}