import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d’ouvrir ce lien.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildContactTile(
              icon: Icons.phone,
              title: 'Téléphone',
              subtitle: '+243 975 237 607',
              onTap: () => _launchUrl(context, 'tel:+243975237607'),
            ),
            _buildContactTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'marthegloria545@gmail.com',
              onTap: () =>
                  _launchUrl(context, 'mailto:marthegloria545@gmail.com'),
            ),
            _buildContactTile(
              icon: Icons.location_on,
              title: 'Adresse',
              subtitle: 'Goma, RDC',
              onTap: () =>
                  _launchUrl(context, 'https://maps.google.com/?q=Goma,RDC'),
            ),
            _buildContactTile(
              icon: Icons.cake,
              title: 'Date de naissance',
              subtitle: '01/02/2006',
            ),
            _buildContactTile(
              icon: Icons.flag,
              title: 'Nationalité',
              subtitle: 'Congolaise',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
