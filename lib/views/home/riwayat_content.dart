import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RiwayatContent extends StatelessWidget {
  const RiwayatContent({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionService transactionService = TransactionService();
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return FutureBuilder(
      future: transactionService.getTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('❌ Error: ${snapshot.error}'));
        }

        final docs = snapshot.data ?? [];

        if (docs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'Belum ada transaksi',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Riwayat Transaksi",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final timestamp = data['date'] as Timestamp;
                    final date = timestamp.toDate();
                    final total = data['total'] ?? 0;
                    final items = data['items'] as List<dynamic>? ?? [];
                    final itemCount = items.length;

                    return ShadCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currencyFormatter.format(total),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM yyyy, HH:mm', 'id_ID')
                                    .format(date),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.shopping_cart,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$itemCount item',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              ShadBadge(
                                backgroundColor: Colors.green.shade50,
                                child: const Text(
                                  "Success",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShadTooltip(
                                builder: (context) => const Text(
                                  "Detail Transaksi",
                                ),
                                child: ShadButton.outline(
                                  size: ShadButtonSize.sm,
                                  icon: const Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 18),
                                  onPressed: () {
                                    // TODO: tampilkan detail transaksi
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              ShadTooltip(
                                builder: (context) => const Text(
                                  "Hapus Transaksi",
                                ),
                                child: ShadButton.destructive(
                                  size: ShadButtonSize.sm,
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18),
                                  onPressed: () {
                                    // TODO: hapus transaksi
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
