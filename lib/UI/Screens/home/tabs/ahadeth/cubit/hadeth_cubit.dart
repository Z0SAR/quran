import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'hadeth_state.dart';

class HadethCubit extends HydratedCubit<HadethState> {
  HadethCubit() : super(HadethLoading());

  void loadHAdeth() async {
    if (state is HadethLoaded) {
      print("Already loaded from HydratedBloc");
      return;
    }

    emit(HadethLoading());
    List<Map<String, dynamic>> allHadeth = [];
    try {
      print("fristLoad form asset");
      for (int i = 1; i <= 50; i++) {
        String content = await rootBundle.loadString('assets/Hadeeth/h$i.txt');
        List<String> hadethcontent = content.split("\n");

        String hadethNumber = hadethcontent[0];
        String hadethNarator = hadethcontent.last;
        String hadethContent = hadethcontent
            .sublist(1, hadethcontent.length - 1)
            .join("\n");
        allHadeth.add({
          "hadithID": i,
          "hadethNumber": hadethNumber,
          "hadethNarator": hadethNarator,
          "hadethContent": hadethContent,
        });
      }
      emit(HadethLoaded(hadethlist: allHadeth));
    } on Exception catch (e) {
      emit(HadethError(errorMsg: e.toString()));
    }
  }

  @override
  HadethState? fromJson(Map<String, dynamic> json) {
    try {
      return HadethLoaded(
        hadethlist: List<Map<String, dynamic>>.from(json['hadethlist']),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HadethState state) {
    if (state is HadethLoaded) {
      print("is Loading Alrady");
      return {"hadethlist": state.hadethlist};
    }
    return null;
  }
}
