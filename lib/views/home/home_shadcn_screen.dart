import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/snippets/firestore.dart';
import 'package:first_app_flutter/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeShadcnScreen extends StatefulWidget {
  const HomeShadcnScreen({super.key});

  @override
  State<HomeShadcnScreen> createState() => _HomeShadcnScreenState();
}

class _HomeShadcnScreenState extends State<HomeShadcnScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.accentForeground,
        title: Text(
          'HM Putra',
          style: TextStyle(
            fontSize: theme.textTheme.h3.fontSize,
            fontWeight: theme.textTheme.h3.fontWeight,
            color: theme.colorScheme.accent,
          ),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: ShadAvatar(
              'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124599?v=4',
              placeholder: Text('HM'),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(
            color: theme.colorScheme.muted,
            height: 1,
          ),
        ),
      ),
      body: ItemTableShad(selectedIndex: _selectedIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                showShadDialog(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShadDialog(
                      title: const Text('Tambah Barang'),
                      description:
                          const Text("Tambahkan barang baru ke kasir HM Putra"),
                      actions: [
                        ShadButton(
                          onPressed: () async {
                            await homeViewModel.save();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tambah'),
                        ),
                      ],
                      child: Container(
                        width: 375,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ShadInputFormField(
                              label: const Text('Name'),
                              placeholder: const Text('Masukkan nama barang'),
                              initialValue: homeViewModel.name,
                              onChanged: (value) =>
                                  homeViewModel.setName(value),
                            ),
                            const SizedBox(height: 20),
                            ShadInputFormField(
                              label: const Text('Weight'),
                              placeholder: const Text('Masukkan berat barang'),
                              keyboardType: TextInputType.number,
                              initialValue: homeViewModel.weight.toString(),
                              onChanged: (value) =>
                                  homeViewModel.setWeight(int.parse(value)),
                            ),
                            const SizedBox(height: 20),
                            ShadInputFormField(
                              label: const Text('Price'),
                              placeholder: const Text('Masukkan harga barang'),
                              keyboardType: TextInputType.number,
                              initialValue: homeViewModel.price.toString(),
                              onChanged: (value) =>
                                  homeViewModel.setPrice(int.parse(value)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(LucideIcons.shoppingCart),
    title: const Text("Kasir"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.inventory),
    title: const Text("Barang"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(LucideIcons.history),
    title: const Text("Riwayat"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];

class ItemTableShad extends StatelessWidget {
  int selectedIndex;

  ItemTableShad({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final FirestoreSnippets firestoreSnippets =
        FirestoreSnippets(FirebaseFirestore.instance);

    Widget content;

    switch (selectedIndex) {
      case 0:
        content = homeViewModel.items.isNotEmpty
            ? ShadTable.list(
                header: const [
                  ShadTableCell.header(child: Text('Name')),
                  ShadTableCell.header(child: Text('Weight')),
                  ShadTableCell.header(child: Text('Price')),
                  ShadTableCell.header(
                      alignment: Alignment.center, child: Text('Action')),
                ],
                footer: [
                  const ShadTableCell.footer(child: Text('Total')),
                  const ShadTableCell.footer(child: Text('')),
                  const ShadTableCell.footer(child: Text('')),
                  ShadTableCell.footer(
                    alignment: Alignment.centerRight,
                    child: Text('Rp ${homeViewModel.totalPrice}'),
                  ),
                ],
                columnSpanExtent: (index) => const FixedTableSpanExtent(100),
                children: homeViewModel.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return [
                    ShadTableCell(child: Text(item.name)),
                    ShadTableCell(child: Text('${item.weight}/kg')),
                    ShadTableCell(
                      alignment: Alignment.centerRight,
                      child: Text('Rp ${item.price}'),
                    ),
                    ShadTableCell(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => homeViewModel.delete(index),
                      ),
                    ),
                  ];
                }),
              )
            : const Center(child: Text('Belum ada barang di kasir'));
        break;

      case 1:
        content = FutureBuilder<List<Map<String, dynamic>>>(
          future: firestoreSnippets.readUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data user'));
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user['name'] ?? 'No name'),
                    subtitle: Text(user['email'] ?? 'No email'),
                    leading: const Icon(Icons.person),
                  );
                },
              );
            }
          },
        );
        break;

      case 2:
        content = const Center(child: Text('Belum ada riwayat'));
        break;

      case 3:
        content = const Center(child: Text('Profil pengguna'));
        break;

      default:
        content = Center(child: _navBarItems[selectedIndex].title);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        child: content,
      ),
    );
  }
}
