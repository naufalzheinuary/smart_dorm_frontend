import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AdminLogsPage extends StatefulWidget {
  const AdminLogsPage({super.key});

  @override
  State<AdminLogsPage> createState() =>
      _AdminLogsPageState();
}

class _AdminLogsPageState
    extends State<AdminLogsPage> {

  String search = '';

  String selectedFilter = 'ALL';

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
          'Access Logs',
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
                    'Cari nama user...',

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

          // ================= FILTER =================

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            child: Row(

              children: [

                _buildFilterButton(
                  title: 'ALL',
                ),

                const SizedBox(width: 8),

                _buildFilterButton(
                  title: 'GRANTED',
                ),

                const SizedBox(width: 8),

                _buildFilterButton(
                  title: 'DENIED',
                ),

              ],
            ),
          ),

          const SizedBox(height: 12),

          // ================= LOG LIST =================

          Expanded(

            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore
                  .instance
                  .collection('access_logs')
                  .orderBy(
                    'timestamp',
                    descending: true,
                  )
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
                      'Belum ada access logs',
                    ),

                  );
                }

                final logs =
                    snapshot.data!.docs;

                // ================= FILTER =================

                final filteredLogs =
                    logs.where((doc) {

                  final data =
                      doc.data()
                          as Map<String, dynamic>;

                  final userName =
                      (data['user_name'] ??
                              '')
                          .toString()
                          .toLowerCase();

                  final status =
                      (data['status'] ?? '')
                          .toString();

                  // SEARCH
                  final matchesSearch =
                      userName.contains(
                          search);

                  // FILTER
                  final matchesFilter =
                      selectedFilter ==
                              'ALL'
                          ? true
                          : status ==
                              selectedFilter;

                  return matchesSearch &&
                      matchesFilter;

                }).toList();

                // ================= LIST =================

                return ListView.builder(

                  itemCount:
                      filteredLogs.length,

                  itemBuilder:
                      (context, index) {

                    final log =
                        filteredLogs[index];

                    final data =
                        log.data()
                            as Map<String,
                                dynamic>;

                    final userName =
                        data['user_name'] ??
                            'UNKNOWN';

                    final method =
                        data['method'] ??
                            '-';

                    final status =
                        data['status'] ??
                            '-';

                    final detail =
                        data['detail'] ??
                            '';

                    final timestamp =
                        data['timestamp']
                            as Timestamp?;

                    String formattedTime =
                        '-';

                    if (timestamp != null) {

                      formattedTime =
                          DateFormat(
                        'dd MMM yyyy - HH:mm',
                      ).format(
                        timestamp.toDate(),
                      );

                    }

                    final isGranted =
                        status == 'GRANTED';

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

                          // ================= USER =================

                          Text(

                            userName,

                            style:
                                const TextStyle(

                              fontSize: 20,

                              fontWeight:
                                  FontWeight.bold,

                            ),
                          ),

                          const SizedBox(
                              height: 8),

                          // ================= METHOD =================

                          Text(
                            'Method : $method',
                          ),

                          const SizedBox(
                              height: 4),

                          // ================= STATUS =================

                          Row(

                            children: [

                              Container(

                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color: isGranted
                                      ? Colors
                                          .green
                                      : Colors
                                          .red,

                                  borderRadius:
                                      BorderRadius.circular(
                                          30),

                                ),

                                child: Text(

                                  status,

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors
                                            .white,

                                    fontWeight:
                                        FontWeight
                                            .bold,

                                  ),
                                ),
                              ),

                              const SizedBox(
                                  width: 12),

                              Text(
                                formattedTime,
                              ),

                            ],
                          ),

                          // ================= DETAIL =================

                          if (detail
                              .toString()
                              .isNotEmpty)

                            Padding(

                              padding:
                                  const EdgeInsets.only(
                                top: 8,
                              ),

                              child: Text(
                                'Detail : $detail',
                              ),

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

  // ===================================================
  // ================= FILTER BUTTON ===================
  // ===================================================

  Widget _buildFilterButton({

    required String title,

  }) {

    final isSelected =
        selectedFilter == title;

    return Expanded(

      child: GestureDetector(

        onTap: () {

          setState(() {

            selectedFilter =
                title;

          });

        },

        child: Container(

          padding:
              const EdgeInsets.symmetric(
            vertical: 12,
          ),

          decoration: BoxDecoration(

            color: isSelected
                ? const Color(0xFF1565C0)
                : Colors.grey.shade300,

            borderRadius:
                BorderRadius.circular(12),

          ),

          child: Center(

            child: Text(

              title,

              style: TextStyle(

                color: isSelected
                    ? Colors.white
                    : Colors.black,

                fontWeight:
                    FontWeight.bold,

              ),
            ),
          ),
        ),
      ),
    );
  }
}