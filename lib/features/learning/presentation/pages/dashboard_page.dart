import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';
import 'package:onthi_gplx_pro/dependencies_container.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  // will add more later
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), toolbarHeight: 60),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Dashboard!'),
            SizedBox(height: 20),
            StyledButton(
              title: 'LogOut',
              onPressed: () {
                sl<AuthBloc>().add(AuthLoggedOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
