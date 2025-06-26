import 'package:go_router/go_router.dart';
import '../features/users/presentation/pages/home_page.dart';
import '../features/users/presentation/pages/user_detail_page.dart';
import '../features/users/presentation/pages/add_user_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'user-detail',
          builder: (context, state) => const UserDetailPage(),
        ),
        GoRoute(
          path: 'add-user',
          builder: (context, state) => const AddUserPage(),
        ),
      ],
    ),
  ],
);
