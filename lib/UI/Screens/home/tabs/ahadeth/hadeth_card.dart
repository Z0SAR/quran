import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class BuildContainer extends StatelessWidget {
  final Map<String, dynamic> hadethcontent;
  const BuildContainer({super.key, required this.hadethcontent});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 280,

      margin: EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: AppColors.primary,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: .2,
              child: Image.asset(
                AssetsManager.mosqBlack,
                height: 200,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // bottom decoration
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(AssetsManager.mosq2, fit: BoxFit.fitWidth),
          ),

          // corners
          Positioned(
            top: 10,
            left: 10,
            child: Transform.flip(
              flipX: true,
              child: Image.asset(AssetsManager.hadethLeftCorner, width: 60),
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(AssetsManager.hadethLeftCorner, width: 60),
          ),

          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  hadethcontent["hadethNumber"] ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "JannaLT",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      "${hadethcontent["hadethContent"] ?? ""}\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "JannaLT",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  hadethcontent["hadethNarator"] ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "JannaLT",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
