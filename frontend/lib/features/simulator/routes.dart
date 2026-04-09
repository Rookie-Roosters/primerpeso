import 'package:go_router/go_router.dart';

import 'presentation/cat_screen.dart';
import 'presentation/credit_screen.dart';
import 'presentation/paycheck_screen.dart';

List<GoRoute> simulatorRoutes() => [
  GoRoute(
    path: '/simulator/paycheck',
    builder: (context, state) => const PaycheckScreen(),
  ),
  GoRoute(
    path: '/simulator/credit',
    builder: (context, state) => const CreditScreen(),
  ),
  GoRoute(
    path: '/simulator/cat',
    builder: (context, state) => const CatScreen(),
  ),
];
