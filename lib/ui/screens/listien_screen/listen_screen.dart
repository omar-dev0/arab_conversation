import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/screens/course_ccontent/play_list_bottomSheet.dart';
import 'package:arab_conversation/ui/screens/listien_screen/controllers.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_cubit.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_state.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class ListenScreen extends StatefulWidget {
  static const String route = "listenScreen";
  final CourseItem? chapter;
  final String? name;
  final List<CourseItem>? chapters;
  final int? index;
   bool clicked = false;
   ListenScreen({super.key, this.chapter, this.name, this.chapters, this.index});

  @override
  State<ListenScreen> createState() => _ListenScreenState();
}

HomeViewModel homeCubit = getIt.get<HomeViewModel>();
Stream<PositionData> get _PositionStream => Rx.combineLatest3(
    homeCubit.audioPlayer.positionStream,
    homeCubit.audioPlayer.bufferedPositionStream,
    homeCubit.audioPlayer.durationStream,
    (position, buffer, duration) =>
        PositionData(position, buffer, duration ?? Duration.zero));

class _ListenScreenState extends State<ListenScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    homeCubit = getIt.get<HomeViewModel>();
    homeCubit.getUrl(widget.chapter ?? CourseItem());
    homeCubit.chapterIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SuccessPlay) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/listen_bg.png'),
                      fit: BoxFit.cover)),
              child: Scaffold(
                key: _key,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  title: Text(
                    state.courseItemName,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 20.sp),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          top: 29.h, bottom: 48.h, start: 16.w, end: 31.w),
                      width: double.infinity,
                      height: 227.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          StreamBuilder<PositionData>(
                            stream: _PositionStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return ProgressBar(
                                barHeight: 4.h,
                                baseBarColor: const Color(0xFF1E1E1E),
                                bufferedBarColor: Colors.transparent,
                                progressBarColor: const Color(0xFF5C9797),
                                thumbColor: Colors.transparent,
                                timeLabelTextStyle: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 12.sp),
                                progress:
                                    positionData?.position ?? Duration.zero,
                                buffered: positionData?.buffer ?? Duration.zero,
                                total: positionData?.duration ?? Duration.zero,
                                onSeek: homeCubit.audioPlayer.seek,
                              );
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (!widget.clicked) {
                                    await homeCubit.audioPlayer
                                        .setLoopMode(LoopMode.all);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: SizedBox(
                                                height: 20.h,
                                                child: Text(
                                                  'loop mode on',
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                )
                                            ),
                                      duration: const Duration(milliseconds: 500),
                                    )
                                    );
                                    widget.clicked = true;
                                  } else {
                                    await homeCubit.audioPlayer
                                        .setLoopMode(LoopMode.off);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: const Duration(milliseconds: 500),
                                            content: Text(
                                      'loop mode off',
                                      style: TextStyle(fontSize: 15.sp),
                                    )
                                    )
                                    );
                                    widget.clicked = false;
                                  }
                                },
                                child: const ImageIcon(
                                  AssetImage('assets/icons/rep.png'),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              InkWell(
                                onTap: () async {
                                  // if (homeCubit.chapterIndex - 1 <= -1) {
                                  //   homeCubit.chapterIndex =
                                  //       widget.chapters!.length - 1;
                                  //   await homeCubit.getUrl(widget.chapters?[
                                  //           homeCubit.chapterIndex] ??
                                  //       CourseItem());
                                  // } else {
                                  //   homeCubit.chapterIndex =
                                  //       homeCubit.chapterIndex - 1;
                                  //   await homeCubit.getUrl(widget.chapters?[
                                  //           homeCubit.chapterIndex] ??
                                  //       CourseItem());
                                  // }
                                  Duration currentDuration = homeCubit.audioPlayer.position;
                                  currentDuration-= const Duration(seconds: 5);
                                  homeCubit.audioPlayer.seek(currentDuration);
                                },
                                child: const ImageIcon(
                                  AssetImage('assets/icons/back.png'),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              Controllers(audioPlayer: homeCubit.audioPlayer),
                              SizedBox(
                                width: 40.w,
                              ),
                              InkWell(
                                onTap: () async {
                                  // if (homeCubit.chapterIndex + 1 ==
                                  //     widget.chapters?.length) {
                                  //   homeCubit.chapterIndex = 0;
                                  //   await homeCubit.getUrl(widget.chapters?[
                                  //           homeCubit.chapterIndex] ??
                                  //       CourseItem());
                                  // } else {
                                  //   homeCubit.chapterIndex =
                                  //       homeCubit.chapterIndex! + 1;
                                  //   await homeCubit.getUrl(widget.chapters?[
                                  //           homeCubit.chapterIndex] ??
                                  //       CourseItem());
                                  // }

                                  Duration currentPosition = homeCubit.audioPlayer.position;
                                  currentPosition+= const Duration(seconds: 5);
                                  homeCubit.audioPlayer.seek(currentPosition);
                                },
                                child: const ImageIcon(
                                  AssetImage('assets/icons/nex.png'),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              InkWell(
                                onTap: () {
                                  _key.currentState?.showBottomSheet(
                                      (context) => PlayListBottomSheet(
                                            courseName: widget.name ?? "",
                                            courseItem: widget.chapters,
                                          ));
                                },
                                child: const ImageIcon(
                                  AssetImage('assets/icons/list.png'),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }

  @override
  void dispose() {
    homeCubit.audioPlayer.dispose();
    homeCubit.audioPlayer = AudioPlayer();
    super.dispose();
  }
}

class PositionData {
  final Duration position;
  final Duration buffer;
  final Duration duration;
  const PositionData(this.position, this.buffer, this.duration);
}
