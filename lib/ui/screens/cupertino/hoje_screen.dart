import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HojeScreen extends StatelessWidget {
  const HojeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar.search(
              largeTitle: Text("Hoje"),
              bottomMode: NavigationBarBottomMode.automatic,
              trailing: CupertinoButton(
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoPopupSurface(
                        child: FullScreenDialogPage(),
                      );
                    },
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Container(
                  height: 100,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Item $i',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                childCount: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenDialogPage extends StatelessWidget {
  const FullScreenDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 700,
      decoration: BoxDecoration(color: CupertinoColors.lightBackgroundGray),
      child: Center(child: Text("Full Screen Dialog.")),
    );
  }
}
