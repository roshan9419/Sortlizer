
import 'package:auto_route/auto_route_annotations.dart';
import 'package:sorting_visualization/ui/views/visualizer_view.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: HomeView),
  MaterialRoute(page: VisualizerView)
])
class $Router {}