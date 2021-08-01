
import 'package:auto_route/auto_route_annotations.dart';
import 'package:sorting_visualization/ui/views/onboarding_view.dart';
import 'package:sorting_visualization/ui/views/sorting_detailed_view.dart';
import 'package:sorting_visualization/ui/views/visualizer_view.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: OnBoardingView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: VisualizerView),
  MaterialRoute(page: SortingDetailedView),
])
class $Router {}