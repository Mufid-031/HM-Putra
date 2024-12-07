import 'package:flutter/material.dart';

// pemanggil class
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  // constuctor wajib
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Instagram",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: const [
            IconButton(
              onPressed: ButtonAction.new,
              icon: Icon(Icons.heart_broken_outlined),
              color: Colors.white,
            ),
            IconButton(
              onPressed: ButtonAction.new,
              icon: Icon(Icons.message),
              color: Colors.white,
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: ButtonAction.new,
                    icon: Icon(Icons.person),
                    color: Colors.white,
                    iconSize: 75,
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          CircleBorder(
                            side: BorderSide(color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: ButtonAction.new,
                            icon: Icon(Icons.person),
                            color: Colors.white,
                          ),
                          Text(
                            "Mufid Risqi",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: ButtonAction.new,
                    icon: Icon(Icons.keyboard_option_key),
                    color: Colors.white,
                  )
                ],
              ),
              Image(
                  image: NetworkImage(
                      'https://palcomtech.ac.id/wp-content/uploads/2023/10/60bb4a2e143f632da3e56aea_Flutter-app-development-2.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: ButtonAction.new,
                            icon: Icon(Icons.heart_broken),
                            color: Colors.white,
                          ),
                          Text(
                            "1.555",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: ButtonAction.new,
                            icon: Icon(Icons.comment_rounded),
                            color: Colors.white,
                          ),
                          Text(
                            "200",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: ButtonAction.new,
                            icon: Icon(Icons.share_rounded),
                            color: Colors.white,
                          ),
                          Text(
                            "168",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: ButtonAction.new,
                    icon: Icon(Icons.bookmark_border),
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: ButtonAction.new,
                  icon: Icon(Icons.home),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: ButtonAction.new,
                  icon: Icon(Icons.search),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: ButtonAction.new,
                  icon: Icon(Icons.add_box_outlined),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: ButtonAction.new,
                  icon: Icon(Icons.video_collection_outlined),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: ButtonAction.new,
                  icon: Icon(Icons.person),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonAction {
  void clicked() {
    print("Hello");
  }
}
