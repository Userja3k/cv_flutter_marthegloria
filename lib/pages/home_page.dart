import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary,
                    backgroundImage: AssetImage('assets/images/s.jpeg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ALIKA MUBARHUZI',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Mathe-Gloria',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Communication',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Profil Professionnel'),
            const Text(
              'Dynamique et engagée, passionnée par la représentation féminine, '
              'le leadership et les actions sociales. Ambitieuse, confiante et '
              'consciente des responsabilités liées à l’image publique, je '
              'souhaite mettre mes qualités humaines, mon intelligence et ma '
              'créativité au service de la promotion des valeurs sociales, '
              'culturelles et éducatives auprès de la jeunesse.',
              style: TextStyle(height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Parcours Professionnel'),
            _buildTimelineItem(
              title: 'Responsable de projet et programme provinciale',
              subtitle:
                  'Fondation des femmes sublimées - Goma - CDD\n'
                  'Gestion et suivi des projets, respectant les délais et les '
                  'budgets alloués.',
              date: '05/2026 - 07/2026',
            ),
            _buildTimelineItem(
              title: 'Vente',
              subtitle:
                  'Moi même - Goma - Contrat d’apprentissage\n'
                  'Conception d’objets en perles et vente à mon compte.',
              date: '06/2022 - 08/2024',
            ),
            _buildTimelineItem(
              title: 'Soin',
              subtitle:
                  'Moi même - Goma\n'
                  'Maquillage, pédicure et manucure à mon compte.',
              date: '06/2023 - 08/2024',
            ),
            _buildTimelineItem(
              title: 'Serveuse',
              subtitle:
                  'Antoinette - Bukavu, RDC - CDD\n'
                  'Service en salle, accueil chaleureux et encaissement.',
              date: '07/2023 - 08/2023',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Formation'),
            _buildTimelineItem(
              title:
                  'Licence 2 : Informatique appliqué à la gestion des '
                  'entreprises',
              subtitle:
                  'Institut Supérieur d’Informatique et de Gestion - '
                  'ISIG Goma\nMention: Bien',
              date: '10/2025 - 07/2026',
            ),
            _buildTimelineItem(
              title: 'Baccalauréat : Pédagogie Générale',
              subtitle: 'Lycée Cirezi - Bukavu\nMention: Bien',
              date: '09/2017 - 06/2024',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Compétences'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [
                        'Communication',
                        'Leadership',
                        'Confiance en soi',
                        'Organisation',
                        'Gestion de projet',
                        'Rédaction',
                        'MS Office',
                        'Esprit critique',
                      ]
                      .map(
                        (skill) => Chip(
                          label: Text(
                            skill,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFFFE0B2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Langues'),
            const Text(
              'Français • Anglais • Swahili',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Centres d’intérêt'),
            const Text(
              'Mode • Écologie • Lecture • Activités associatives • '
              'Représentation féminine',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            color: AppColors.primary,
            margin: const EdgeInsets.only(right: 8),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
