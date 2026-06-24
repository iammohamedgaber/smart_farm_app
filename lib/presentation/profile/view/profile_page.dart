import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm_app/animations/app_colors.dart';
import 'package:smart_farm_app/animations/widgets/loading_widgets.dart';
import 'package:smart_farm_app/presentation/auth/view/login_page.dart';
import 'package:smart_farm_app/presentation/profile/cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: AppLoading(
              text: 'Loading profile...',
              color: AppColors.green500,
            ),
          );
        }

        if (state is ProfileError) {
          return Scaffold(
            body: ErrorState(
              message: 'Failed to load profile',
              subMessage: state.message,
              onRetry: () {
                context.read<ProfileCubit>().loadUser();
              },
            ),
          );
        }

        if (state is ProfileLoaded) {
          return Scaffold(
            backgroundColor: AppColors.selectCropBackground,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(state),
                  const SizedBox(height: 20),
                  _buildInfoCard(state),
                  const Spacer(),
                  _buildLogoutButton(context),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHeader(ProfileLoaded state) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sensorBackground, AppColors.sensorBackground],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const CircleAvatar(
            radius: 44,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 44,
              color: AppColors.sensorBackground,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            state.username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            state.email,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ProfileLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            _InfoTile(
              icon: Icons.person,
              title: 'Username',
              subtitle: state.username,
            ),
            const Divider(height: 0),
            _InfoTile(icon: Icons.email, title: 'Email', subtitle: state.email),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: LoadingButton(
          isLoading: false,
          onPressed: () async {
            await context.read<ProfileCubit>().logout();
            if (!context.mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          },
          text: 'Logout',
          color: AppColors.green900,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.green500),
      title: Text(title, style: const TextStyle(color: AppColors.textDark)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
