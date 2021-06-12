// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../datamodels/algorithmType.dart';
import '../ui/views/home_view.dart';
import '../ui/views/visualizer_view.dart';

class Routes {
  static const String homeView = '/home-view';
  static const String visualizerView = '/visualizer-view';
  static const all = <String>{
    homeView,
    visualizerView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.visualizerView, page: VisualizerView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    VisualizerView: (data) {
      final args = data.getArgs<VisualizerViewArguments>(
        orElse: () => VisualizerViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => VisualizerView(
          algorithmType: args.algorithmType,
          key: args.key,
        ),
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
  final Key key;
  VisualizerViewArguments({this.algorithmType, this.key});
}
