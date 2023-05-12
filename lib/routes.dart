import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:musa3dk/screens/auth/auth_page.dart';
import 'package:musa3dk/screens/auth/login.dart';
import 'package:musa3dk/screens/auth/routerPage.dart';
import 'package:musa3dk/screens/auth/singup.dart';
import 'package:musa3dk/userMode/screens/google_maps.dart';
import 'package:musa3dk/screens/messages/chat_Scteen.dart';
import 'package:musa3dk/screens/messages/evaluation.dart';
import 'package:musa3dk/userMode/screens/orderDetails.dart';
import 'package:musa3dk/userMode/screens/PageAccount.dart';
import 'package:musa3dk/userMode/screens/summary.dart';
import 'package:musa3dk/workerMode/screens/PageAccountWorker.dart';
import 'package:musa3dk/screens/worker/jobRequest.dart';
import 'package:musa3dk/screens/worker/orderDetailsWorker.dart';
import 'package:musa3dk/screens/worker/tousermode.dart';

List<GetPage<dynamic>> routes = [
        GetPage(name: '/', page: () => const AuthPage()),
        GetPage(name: '/Singup', page: () => const Singup()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/GoogleMaps', page: () => GoogleMaps_()),
        GetPage(name: '/Summary', page: () => Summary()),
        GetPage(name: '/OrderDetails', page: () => OrderDetails()),
        GetPage(name: '/PageAccount', page: () => PageAccount()),
        GetPage(name: '/JobRequest', page: () => const JobRequest()),
        GetPage(name: '/PageAccountWorker', page: () => PageAccountWorker()),
        GetPage(name: '/RouterPage', page: () => const RouterPage()),
        GetPage(
            name: '/SwitchToUserMode', page: () => const SwitchToUserMode()),
        GetPage(name: '/OrderDetailsWorker', page: () => OrderDetailsWorker()),
        GetPage(name: '/ChatScreen', page: () => ChatScreen()),
        GetPage(name: '/Evaluation', page: () => Evaluation()),
];
