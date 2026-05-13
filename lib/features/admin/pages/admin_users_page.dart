import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() =>
      _AdminUsersPageState();
}

class _AdminUsersPageState
    extends State<AdminUsersPage> {

  String search = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ================= APPBAR =================

      appBar: AppBar(

        leading: IconButton(

          onPressed: () {

            context.go('/admin');

          },
          icon: const Icon(
            Icons.arrow_back,
          ),

        ),

        title: const Text(
          'List User',
        ),

      ),

      // ================= BODY =================

      body: Column(

        children: [

          // ================= SEARCH =================

          Padding(

            padding:
                const EdgeInsets.all(16),

            child: TextField(

              decoration: InputDecoration(

                hintText:
                    'Cari nama / NIM / Email',

                prefixIcon:
                    const Icon(Icons.search),

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(16),

                ),

              ),

              onChanged: (value) {

                setState(() {

                  search =
                      value.toLowerCase();

                });

              },

            ),
          ),

          // ================= USER LIST =================

          Expanded(

            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore
                  .instance
                  .collection('users')
                  .snapshots(),

              builder: (context, snapshot) {

                // ================= LOADING =================

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                // ================= EMPTY =================

                if (!snapshot.hasData ||
                    snapshot.data!.docs
                        .isEmpty) {

                  return const Center(
                    child: Text(
                      'Belum ada user',
                    ),
                  );
                }

                final users =
                    snapshot.data!.docs;

                // ================= FILTER =================

                final filteredUsers =
                    users.where((doc) {

                  final data =
                      doc.data()
                          as Map<String, dynamic>;

                  final name =
                      (data['name'] ?? '')
                          .toString()
                          .toLowerCase();

                  final nim =
                      (data['nim'] ?? '')
                          .toString()
                          .toLowerCase();

                  final email =
                      (data['email'] ?? '')
                          .toString()
                          .toLowerCase();

                  return name.contains(search)
                      ||
                      nim.contains(search)
                      ||
                      email.contains(search);

                }).toList();

                // ================= LIST =================

                return ListView.builder(

                  itemCount:
                      filteredUsers.length,

                  itemBuilder:
                      (context, index) {

                    final user =
                        filteredUsers[index];

                    final data =
                        user.data()
                            as Map<String,
                                dynamic>;

                    final docId =
                        user.id;

                    final name =
                        data['name'] ??
                            '-';

                    final nim =
                        data['nim'] ??
                            '-';

                    final email =
                        data['email'] ??
                            '-';

                    final building =
                        data['building'] ??
                            '-';

                    final room =
                        data['room'] ??
                            '-';

                    final role =
                        data['role'] ??
                            '-';

                    final isActive =
                        data['is_active'] ??
                            false;

                    return Container(

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      padding:
                          const EdgeInsets.all(16),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black
                                .withOpacity(
                                    0.05),

                            blurRadius: 10,

                            offset:
                                const Offset(0, 4),

                          ),

                        ],
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          // ================= NAME =================

                          Text(

                            name,

                            style:
                                const TextStyle(

                              fontSize: 20,

                              fontWeight:
                                  FontWeight.bold,

                            ),
                          ),

                          const SizedBox(
                              height: 8),

                          // ================= EMAIL =================

                          Text(
                            email,
                          ),

                          const SizedBox(
                              height: 4),

                          // ================= NIM =================

                          Text(
                            'NIM : $nim',
                          ),

                          const SizedBox(
                              height: 4),

                          // ================= ROOM =================

                          Text(
                            'Gedung $building - Kamar $room',
                          ),

                          const SizedBox(
                              height: 4),

                          // ================= ROLE =================

                          Text(
                            'Role : $role',
                          ),

                          const SizedBox(
                              height: 4),

                          // ================= STATUS =================

                          Text(
                            isActive
                                ? 'ACCESS : ACTIVE'
                                : 'ACCESS : INACTIVE',
                          ),

                          const SizedBox(
                              height: 16),

                          Row(

                            children: [

                              const Spacer(),

                              // ================= EDIT =================

                              IconButton(

                                onPressed: () {

                                  showDialog(

                                    context: context,

                                    builder:
                                        (context) {

                                      return EditUserDialog(

                                        docId: docId,

                                        currentData:
                                            data,

                                      );

                                    },

                                  );

                                },

                                icon: const Icon(
                                  Icons.edit,
                                ),

                              ),

                              // ================= DELETE =================

                              IconButton(

                                onPressed: () async {

                                  final confirm =
                                      await showDialog(

                                    context: context,

                                    builder:
                                        (context) {

                                      return AlertDialog(

                                        title:
                                            const Text(
                                          'Delete User',
                                        ),

                                        content:
                                            const Text(
                                          'Yakin hapus user?',
                                        ),

                                        actions: [

                                          TextButton(

                                            onPressed:
                                                () {

                                              Navigator.pop(
                                                context,
                                                false,
                                              );

                                            },

                                            child:
                                                const Text(
                                              'Batal',
                                            ),

                                          ),

                                          ElevatedButton(

                                            onPressed:
                                                () {

                                              Navigator.pop(
                                                context,
                                                true,
                                              );

                                            },

                                            child:
                                                const Text(
                                              'Hapus',
                                            ),

                                          ),

                                        ],
                                      );

                                    },

                                  );

                                  if (confirm ==
                                      true) {

                                    await FirebaseFirestore
                                        .instance
                                        .collection(
                                            'users')
                                        .doc(docId)
                                        .delete();

                                  }

                                },

                                icon: const Icon(

                                  Icons.delete,

                                  color: Colors.red,

                                ),

                              ),

                            ],
                          ),

                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

// =====================================================
// ================= EDIT USER DIALOG ==================
// =====================================================

class EditUserDialog extends StatefulWidget {

  final String docId;

  final Map<String, dynamic>
      currentData;

  const EditUserDialog({

    super.key,

    required this.docId,

    required this.currentData,

  });

  @override
  State<EditUserDialog> createState() =>
      _EditUserDialogState();
}

class _EditUserDialogState
    extends State<EditUserDialog> {

  late TextEditingController
      nameController;

  late TextEditingController
      emailController;

  late TextEditingController
      nimController;

  late TextEditingController
      buildingController;

  late TextEditingController
      roomController;

  late TextEditingController
      roleController;

  @override
  void initState() {

    super.initState();

    nameController =
        TextEditingController(
      text:
          widget.currentData['name'],
    );

    emailController =
        TextEditingController(
      text:
          widget.currentData['email'],
    );

    nimController =
        TextEditingController(
      text:
          widget.currentData['nim'],
    );

    buildingController =
        TextEditingController(
      text:
          widget.currentData['building'],
    );

    roomController =
        TextEditingController(
      text:
          widget.currentData['room'],
    );

    roleController =
        TextEditingController(
      text:
          widget.currentData['role'],
    );

  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text(
        'Edit User',
      ),

      content: SingleChildScrollView(

        child: Column(

          mainAxisSize:
              MainAxisSize.min,

          children: [

            TextField(
              controller:
                  nameController,
              decoration:
                  const InputDecoration(
                labelText: 'Nama',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  emailController,
              decoration:
                  const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  nimController,
              decoration:
                  const InputDecoration(
                labelText: 'NIM',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  buildingController,
              decoration:
                  const InputDecoration(
                labelText: 'Gedung',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  roomController,
              decoration:
                  const InputDecoration(
                labelText: 'Kamar',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  roleController,
              decoration:
                  const InputDecoration(
                labelText: 'Role',
              ),
            ),

          ],
        ),
      ),

      actions: [

        TextButton(

          onPressed: () {

            Navigator.pop(context);

          },

          child: const Text(
            'Batal',
          ),

        ),

        ElevatedButton(

          onPressed: () async {

            await FirebaseFirestore
                .instance
                .collection('users')
                .doc(widget.docId)
                .update({

              'name':
                  nameController.text,

              'email':
                  emailController.text,

              'nim':
                  nimController.text,

              'building':
                  buildingController.text,

              'room':
                  roomController.text,

              'role':
                  roleController.text,

            });

            if (context.mounted) {

              Navigator.pop(context);

            }

          },

          child: const Text(
            'Simpan',
          ),

        ),

      ],
    );
  }
}