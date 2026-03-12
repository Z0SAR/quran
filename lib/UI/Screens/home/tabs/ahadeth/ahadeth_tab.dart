import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/UI/Screens/home/tabs/ahadeth/Hadeth_Details.dart';
import 'package:quran/UI/Screens/home/tabs/ahadeth/cubit/hadeth_cubit.dart';
import 'package:quran/UI/Screens/home/tabs/ahadeth/hadeth_card.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AhadethView extends StatelessWidget {
  const AhadethView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadethCubit()..loadHAdeth(),
      child: const AhadethTab(),
    );
  }
}

class AhadethTab extends StatelessWidget {
  const AhadethTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.tagMahl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Image.asset(AssetsManager.ImgLogo, width: 250, height: 170),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<HadethCubit, HadethState>(
                builder: (context, state) {
                  if (state is HadethLoading) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return BuildContainer(hadethcontent: {});
                        },
                      ),
                    );
                  }
                  if (state is HadethLoaded) {
                    final List<Map<String, dynamic>> hadethList =
                        state.hadethlist;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hadethList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HadethDetails(hadeth: hadethList[index]),
                              ),
                            );
                          },
                          child: BuildContainer(
                            hadethcontent: hadethList[index],
                          ),
                        );
                      },
                    );
                  }
                  if (state is HadethError) {
                    return Text(state.errorMsg);
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
