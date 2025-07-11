import 'package:first_app_flutter/constants/colors.dart';
import 'package:first_app_flutter/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ["Kasir", "Tambah Item", "Riwayat"];
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(
            "First App Flutter",
            style: TextStyle(color: AppColors.primary),
          ),
          backgroundColor: AppColors.background,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textGrey,
              indicatorColor: AppColors.primary,
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
          actions: const <Widget>[
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.person,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: homeViewModel.items.length,
                itemBuilder: (context, index) {
                  final item = homeViewModel.items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                          "Berat: ${item.weight} kg, Harga: Rp ${item.price}"),
                      trailing: PopupMenuOption(
                        index: index,
                      ),
                    ),
                  );
                },
              ),
              ListView(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.background),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Nama Item",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan nama item",
                            hintStyle: TextStyle(color: AppColors.white),
                          ),
                          onChanged: (value) => homeViewModel.setName(value),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.background),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Berat Item",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan berat item",
                            hintStyle: TextStyle(color: AppColors.white),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              homeViewModel.setWeight(int.parse(value)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.background),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Harga Item",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan harga item",
                            hintStyle: TextStyle(color: AppColors.white),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              homeViewModel.setPrice(int.parse(value)),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await homeViewModel.save();
                    },
                    child: const Text("Simpan"),
                  )
                ],
              ),
              const Center(
                child: Text("Tab 3"),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.shopping_cart,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class PopupMenuOption extends StatefulWidget {
  final int index;

  const PopupMenuOption({super.key, required this.index});

  @override
  State<PopupMenuOption> createState() => _PopupMenuOptionState();
}

enum ItemOption { edit, delete }

class _PopupMenuOptionState extends State<PopupMenuOption> {
  ItemOption? selectedItem;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return PopupMenuButton<ItemOption>(
      initialValue: selectedItem,
      onSelected: (ItemOption item) {
        setState(() {
          selectedItem = item;
        });

        if (item == ItemOption.delete) {
          homeViewModel.delete(widget.index);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ItemOption>>[
        const PopupMenuItem<ItemOption>(
          value: ItemOption.edit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.edit),
              Text("Edit"),
            ],
          ),
        ),
        const PopupMenuItem<ItemOption>(
          value: ItemOption.delete,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.delete),
              Text("Delete"),
            ],
          ),
        ),
      ],
    );
  }
}
