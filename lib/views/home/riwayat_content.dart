import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/services/transaction_service.dart';
import 'package:flutter/material.dart';

class RiwayatContent extends StatelessWidget {
  const RiwayatContent({super.key});

  @override

  Widget build(BuildContext context) {
    final TransactionService transactionService = TransactionService();

    return FutureBuilder(
      future: transactionService.getTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final docs = snapshot.data ?? [];

        if (docs.isEmpty) {
          return const Center(child: Text('Belum ada transaksi'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final timestamp = data['date'] as Timestamp;
                    final date = timestamp.toDate();

                    return Card(
                      child: ListTile(
                        title: Text(data['total'].toString()),
                        subtitle: Text(date.toString()),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
