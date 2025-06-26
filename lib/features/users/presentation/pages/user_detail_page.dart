import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/users_provider.dart';

class UserDetailPage extends ConsumerWidget {
  const UserDetailPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(selectedUserProvider);
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('User Details')),
        body: const Center(child: Text('No user selected')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(user.name), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            _buildInfoCard(context, 'Contact Information', [
              _buildInfoRow('Email', user.email, Icons.email),
              _buildInfoRow('Phone', user.phone, Icons.phone),
              if (user.username != null)
                _buildInfoRow('Username', user.username!, Icons.person),
              if (user.website != null)
                _buildInfoRow('Website', user.website!, Icons.web),
            ]),
            if (user.address != null) ...[
              const SizedBox(height: 16.0),
              _buildInfoCard(context, 'Address', [
                if (user.address!.street != null)
                  _buildInfoRow(
                    'Street',
                    user.address!.street!,
                    Icons.location_on,
                  ),
                if (user.address!.city != null)
                  _buildInfoRow(
                    'City',
                    user.address!.city!,
                    Icons.location_city,
                  ),
                if (user.address!.zipcode != null)
                  _buildInfoRow(
                    'Zip Code',
                    user.address!.zipcode!,
                    Icons.pin_drop,
                  ),
              ]),
            ],
            if (user.company != null) ...[
              const SizedBox(height: 16.0),
              _buildInfoCard(context, 'Company', [
                if (user.company!.name != null)
                  _buildInfoRow('Name', user.company!.name!, Icons.business),
                if (user.company!.catchPhrase != null)
                  _buildInfoRow(
                    'Catch Phrase',
                    user.company!.catchPhrase!,
                    Icons.tag,
                  ),
              ]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20.0, color: Colors.grey[600]),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
