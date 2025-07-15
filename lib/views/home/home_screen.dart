import 'package:first_app_flutter/services/item_service.dart';
import 'package:first_app_flutter/views/home/barang_content.dart';
import 'package:first_app_flutter/views/home/kasir_content.dart';
import 'package:first_app_flutter/views/home/profile_content.dart';
import 'package:first_app_flutter/views/home/riwayat_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: HomeContent(selectedIndex: _selectedIndex),
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
      floatingActionButton: MyFloatingActionButton(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: theme.colorScheme.accentForeground,
      title: Text(
        'HM Putra',
        style: TextStyle(
          fontSize: theme.textTheme.h3.fontSize,
          fontWeight: theme.textTheme.h3.fontWeight,
          color: theme.colorScheme.accent,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomeContent extends StatelessWidget {
  int selectedIndex;

  HomeContent({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (selectedIndex) {
      case 0:
        content = const KasirContent();
        break;

      case 1:
        content = const BarangContent();
        break;

      case 2:
        content = const RiwayatContent();
        break;

      case 3:
        content = const ProfileContent();
        break;

      default:
        content = Center(child: _navBarItems[selectedIndex].title);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
      ),
      child: content,
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

class MyFloatingActionButton extends StatefulWidget {
  int selectedIndex;
  MyFloatingActionButton({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButton();
}

class _MyFloatingActionButton extends State<MyFloatingActionButton> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  void _listenName(ItemService itemService) async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == "done" || val == "notListening") {
            setState(() => _isListening = false);
          }
        },
        onError: (val) => debugPrint('onError: $val'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'id_ID',
          onResult: (val) {
            itemService.setName(val.recognizedWords);
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemService = Provider.of<ItemService>(context);

    return widget.selectedIndex == 0
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
                          await itemService.save();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          itemService.reset();
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
                            initialValue: itemService.name,
                            // controller: itemService.textEditingController,
                            onChanged: (value) => itemService.setName(value),
                            // suffix: IconButton(
                            //   onPressed: () => _listenName(itemService),
                            //   icon: Icon(
                            //     _isListening ? Icons.mic_off : Icons.mic,
                            //   ),
                            // ),
                          ),
                          const SizedBox(height: 20),
                          ShadInputFormField(
                            label: const Text('Weight'),
                            placeholder: const Text('Masukkan berat barang'),
                            keyboardType: TextInputType.number,
                            initialValue: itemService.weight.toString(),
                            onChanged: (value) =>
                                itemService.setWeight(double.parse(value)),
                          ),
                          const SizedBox(height: 20),
                          ShadInputFormField(
                            label: const Text('Price'),
                            placeholder: const Text('Masukkan harga barang'),
                            keyboardType: TextInputType.number,
                            initialValue: itemService.price.toString(),
                            onChanged: (value) =>
                                itemService.setPrice(int.parse(value)),
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
        : const SizedBox.shrink();
  }
}