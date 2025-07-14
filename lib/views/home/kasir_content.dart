import 'package:first_app_flutter/models/item_model.dart';
import 'package:first_app_flutter/services/item_service.dart';
import 'package:first_app_flutter/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KasirContent extends StatelessWidget {
  const KasirContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final itemService = Provider.of<ItemService>(context);
    final transactionService = Provider.of<TransactionService>(context);
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return itemService.localItems.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daftar Barang",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: itemService.localItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = itemService.localItems[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.shopping_bag,
                                  color: Colors.deepPurple,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    currencyFormatter.format(item.subTotal),
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.scale, size: 18),
                                    const SizedBox(width: 6),
                                    Text('${item.weight} kg'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.monetization_on,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(currencyFormatter.format(item.price)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    // Pre-fill form
                                    itemService.name = item.name;
                                    itemService.weight = item.weight;
                                    itemService.price = item.price;

                                    showShadDialog(
                                      context: context,
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: ShadDialog(
                                          title: const Text('Edit Barang'),
                                          description: const Text(
                                            "Perbarui informasi barang",
                                          ),
                                          actions: [
                                            ShadButton(
                                              onPressed: () {
                                                itemService.localItems[index] =
                                                    Item(
                                                  name: itemService.name,
                                                  weight: itemService.weight,
                                                  price: itemService.price,
                                                  subTotal:
                                                      (itemService.weight *
                                                              itemService.price)
                                                          .toInt(),
                                                );
                                                itemService.reset();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Simpan'),
                                            ),
                                          ],
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 20),
                                              ShadInputFormField(
                                                label: const Text('Name'),
                                                initialValue: itemService.name,
                                                onChanged: itemService.setName,
                                              ),
                                              const SizedBox(height: 12),
                                              ShadInputFormField(
                                                label: const Text('Weight'),
                                                initialValue: itemService.weight
                                                    .toString(),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (val) =>
                                                    itemService.setWeight(
                                                  double.tryParse(val) ?? 0,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              ShadInputFormField(
                                                label: const Text('Price'),
                                                initialValue: itemService.price
                                                    .toString(),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (val) =>
                                                    itemService.setPrice(
                                                  int.tryParse(val) ?? 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                  label: const Text("Edit"),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    showShadDialog(
                                      context: context,
                                      builder: (context) => ShadDialog.alert(
                                        title: const Text("Hapus Barang?"),
                                        description: Text(
                                          "Yakin ingin menghapus '${item.name}' dari daftar?",
                                        ),
                                        actions: [
                                          ShadButton.secondary(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Batal"),
                                          ),
                                          ShadButton.destructive(
                                            onPressed: () {
                                              itemService.deleteLocal(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Hapus"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete, size: 18),
                                  label: const Text("Hapus"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(bottom: 80),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.accentForeground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.accent,
                            ),
                          ),
                          Text(
                            currencyFormatter.format(itemService.totalPrice),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ShadButton.secondary(
                          width: double.infinity,
                          onPressed: () async {
                            await transactionService.create(
                              itemService.localItems,
                            );

                            itemService.deleteAllITemsLocal();

                            if (context.mounted) {
                              ShadToaster.of(context).show(
                                const ShadToast(
                                  title: Text('Checkout Berhasil'),
                                  description: Text(
                                    'Selamat, barang berhasil di checkout',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text("Checkout"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text('Belum ada barang di keranjang'),
          );
  }
}
