import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/database_helper.dart';
import '../models/family_member.dart';
import '../theme/app_colors.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  List<FamilyMember> _familyMembers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    setState(() => _isLoading = true);
    final members = await DatabaseHelper.instance.getFamilyMembers();
    if (mounted) {
      setState(() {
        _familyMembers = members;
        _isLoading = false;
      });
    }
  }

  void _showAddEditDialog({FamilyMember? member}) {
    final isEditing = member != null;
    final nameController = TextEditingController(text: member?.name ?? '');
    final jobController = TextEditingController(text: member?.job ?? '');
    final imageController = TextEditingController(
      text: member?.image ?? 'assets/images/P.png',
    );
    final formKey = GlobalKey<FormState>();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                isEditing ? 'Modifier le membre' : 'Ajouter un membre',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nom complet',
                          prefixIcon: Icon(Icons.person, color: AppColors.primary),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Veuillez saisir un nom'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: jobController,
                        decoration: const InputDecoration(
                          labelText: 'Travail / Relation',
                          prefixIcon: Icon(Icons.work, color: AppColors.primary),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Veuillez saisir le travail'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: imageController,
                        decoration: const InputDecoration(
                          labelText: 'Photo (chemin ou URL)',
                          prefixIcon: Icon(Icons.image, color: AppColors.primary),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Veuillez renseigner une photo'
                            : null,
                        onChanged: (_) => setDialogState(() {}),
                      ),
                      const SizedBox(height: 14),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Suggestions d\'images :',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Père'),
                            selected: imageController.text == 'assets/images/P.png',
                            onSelected: (_) {
                              setDialogState(() {
                                imageController.text = 'assets/images/P.png';
                              });
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Mère'),
                            selected: imageController.text == 'assets/images/M.png',
                            onSelected: (_) {
                              setDialogState(() {
                                imageController.text = 'assets/images/M.png';
                              });
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Frère'),
                            selected: imageController.text == 'assets/images/G.jpg',
                            onSelected: (_) {
                              setDialogState(() {
                                imageController.text = 'assets/images/G.jpg';
                              });
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Autre'),
                            selected: imageController.text == 'assets/images/s.jpeg',
                            onSelected: (_) {
                              setDialogState(() {
                                imageController.text = 'assets/images/s.jpeg';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Annuler'),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final name = nameController.text.trim();
                      final job = jobController.text.trim();
                      final image = imageController.text.trim();

                      if (isEditing) {
                        final updated = member.copyWith(
                          name: name,
                          job: job,
                          image: image,
                        );
                        await DatabaseHelper.instance.updateFamilyMember(updated);
                      } else {
                        final newMember = FamilyMember(
                          name: name,
                          job: job,
                          image: image,
                        );
                        await DatabaseHelper.instance.insertFamilyMember(newMember);
                      }

                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                      }
                      _loadMembers();
                    }
                  },
                  child: Text(isEditing ? 'Enregistrer' : 'Ajouter'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteMember(FamilyMember member) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text('Voulez-vous vraiment supprimer ${member.name} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirm == true && member.id != null) {
      await DatabaseHelper.instance.deleteFamilyMember(member.id!);
      _loadMembers();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${member.name} supprimé'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  ImageProvider _getAvatarImageProvider(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith('assets/')) {
      return AssetImage(imagePath);
    } else {
      final file = File(imagePath);
      if (file.existsSync()) {
        return FileImage(file);
      }
      return const AssetImage('assets/images/P.png');
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ma Famille',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Bouton plus au coin supérieur droit
                IconButton(
                  tooltip: 'Ajouter un membre',
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppColors.primary,
                    size: 34,
                  ),
                  onPressed: () => _showAddEditDialog(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _familyMembers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.family_restroom,
                                size: 70,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Aucun membre dans la famille',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              FilledButton.icon(
                                onPressed: () => _showAddEditDialog(),
                                icon: const Icon(Icons.add),
                                label: const Text('Ajouter un membre'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _familyMembers.length,
                          itemBuilder: (context, index) {
                            final member = _familyMembers[index];
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
                                    backgroundImage: _getAvatarImageProvider(
                                      member.image,
                                    ),
                                    onBackgroundImageError: (_, __) {},
                                    child: member.image.isEmpty
                                        ? const Icon(
                                            Icons.person,
                                            color: AppColors.primary,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          member.job,
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Trois points sur le coin supérieur droit / à droite du card
                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: AppColors.textSecondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        _showAddEditDialog(member: member);
                                      } else if (value == 'delete') {
                                        _deleteMember(member);
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.blueAccent,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Modifier'),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Supprimer'),
                                          ],
                                        ),
                                      ),
                                    ],
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
