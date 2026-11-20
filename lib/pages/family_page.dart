import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  static const List<Map<String, String>> familyMembers = [
    {
      'name': 'Elige M.',
      'relation': 'Père',
      'job': 'Commerçant',
      'image': 'assets/images/P.png',
    },
    {
      'name': 'Françoise R.',
      'relation': 'Mère',
      'job': 'Enseignante',
      'image': 'assets/images/M.png',
    },
    {
      'name': 'Israel B.',
      'relation': 'Frère',
      'job': 'Étudiant',
      'image': 'assets/images/G.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
              'Ma Famille',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  final member = familyMembers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.background,
                          backgroundImage: AssetImage(member['image']!),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${member['relation']} • ${member['job']}',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
