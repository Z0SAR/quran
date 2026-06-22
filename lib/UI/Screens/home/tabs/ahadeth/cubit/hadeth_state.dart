part of 'hadeth_cubit.dart';

@immutable
sealed class HadethState {}

final class HadethLoading extends HadethState {

}
final class HadethLoaded extends HadethState {
 final  List<Map<String,dynamic>> hadethlist;

  HadethLoaded({required this.hadethlist});
}
final class HadethError extends HadethState {
  final String errorMsg;

  HadethError({required this.errorMsg});
}

