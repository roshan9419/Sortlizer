// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../datamodels/algo_history_track.dart';
import '../datamodels/algorithmType.dart';
import '../ui/views/home_view.dart';
import '../ui/views/onboarding_view.dart';
import '../ui/views/settings_view.dart';
import '../ui/views/sorting_detailed_view.dart';
import '../ui/views/visualizer_view.dart';

class Routes {
  static const String onBoardingView = '/';
  static const String homeView = '/home-view';
  static const String visualizerView = '/visualizer-view';
  static const String sortingDetailedView = '/sorting-detailed-view';
  static const String settingsView = '/settings-view';
  static const all = <String>{
    onBoardingView,
    homeView,
    visualizerView,
    sortingDetailedView,
    settingsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.onBoardingView, page: OnBoardingView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.visualizerView, page: VisualizerView),
    RouteDef(Routes.sortingDetailedView, page: SortingDetailedView),
    RouteDef(Routes.settingsView, page: SettingsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    OnBoardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    VisualizerView: (data) {
      var args = data.getArgs<VisualizerViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VisualizerView(
          algorithmType: args.algorithmType,
          key: args.key,
        ),
        settings: data,
      );
    },
    SortingDetailedView: (data) {
      var args = data.getArgs<SortingDetailedViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SortingDetailedView(
          key: args.key,
          algoTracks: args.algoTracks,
        ),
        settings: data,
      );
    },
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SettingsView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// VisualizerView arguments holder class
class VisualizerViewArguments {
  final AlgorithmType algorithmType;
  final Key? key;
  VisualizerViewArguments({required this.algorithmType, this.key});
}

/// SortingDetailedView arguments holder class
class SortingDetailedViewArguments {
  final Key? key;
  final List<AlgoHistoryTrack> algoTracks;
  SortingDetailedViewArguments({this.key, required this.algoTracks});
}
