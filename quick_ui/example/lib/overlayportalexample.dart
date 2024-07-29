import 'package:flutter/material.dart';
import 'package:quick_ui/Widgets/Portal/quick_portal.dart';
import 'package:quick_ui/Widgets/Text/quick_rich_text.dart';

class QuickPortalExample extends StatefulWidget {
  const QuickPortalExample({super.key});

  @override
  State<QuickPortalExample> createState() => _QuickPortalExampleState();
}

class _QuickPortalExampleState extends State<QuickPortalExample> {
  OverlayPortalController controller = OverlayPortalController();
  List<String> fruits = [
    "Apple", "Apricot", "Avocado", "Banana", "Blackberry", "Blueberry", "Boysenberry", "Cantaloupe", "Cherry", "Clementine",
    "Coconut", "Cranberry", "Cucumber", "Currant", "Date", "Dragonfruit", "Durian", "Elderberry", "Feijoa", "Fig",
    "Gooseberry", "Grape", "Grapefruit", "Guava", "Honeydew", "Huckleberry", "Jackfruit", "Jambul", "Jujube", "Kiwi",
    "Kumquat", "Lemon", "Lime", "Lychee", "Mango", "Mangosteen", "Mulberry", "Nectarine", "Orange", "Papaya",
    "Passionfruit", "Peach", "Pear", "Persimmon", "Pineapple", "Plum", "Pomegranate", "Pomelo", "Quince", "Raspberry",
    "Redcurrant", "Salak", "Satsuma", "Starfruit", "Strawberry", "Tamarillo", "Tamarind", "Tangerine", "Tomato", "Ugli fruit",
    "Watermelon", "Yuzu", "Acerola", "Ackee", "African cucumber", "American persimmon", "Atemoya", "Babaco", "Bael", "Barbadine",
    "Barberry", "Bilberry", "Biriba", "Black sapote", "Blood orange", "Breadfruit", "Buddha's hand", "Cactus pear", "Calamansi",];
  @override
  Widget build(BuildContext context) {
    return QuickPortal(
      animationType: AnimationType.fade,
      overlayChild: Container(
        padding: const EdgeInsets.all(0),
        color: Colors.black,
        child:ListView.separated(itemBuilder: (context,index){
    
          return  QuickRichText( textSpans: [
    
            const TextSpan(
                text: 'Fruits >'
    
            ),
            TextSpan(
              text: fruits[index],
            )
          ],);
        },
          separatorBuilder: (context,index){
    
            return const Divider(color: Colors.blue,);
    
          },
          itemCount: fruits.length,),
      ),
      controller: controller,
      offset: const Offset(0, 50),
      alignment: Alignment.topLeft,
    
      overlayHeight: 500,
      overlayWidth: 120,
      child: ElevatedButton(
        onPressed: () {

        //  controller.toggle();
          //controller.show();
        },
        child: const Text('Show Overlay'),
      ),
    );
  }
}
