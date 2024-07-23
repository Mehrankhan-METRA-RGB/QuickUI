import 'package:example/cropper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quick_ui/Utils/Extensions/responsive_extention.dart';
import 'package:quick_ui/quick_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryManager().initialize(context,designHeight: 896,designWidth: 386,statusBarHeight: 0);
    return MaterialApp(
      title: 'QUICK UI',
      theme: ThemeData(
        cardColor: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        useMaterial3: true,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> listOfChip = ['String ', 'int', 'bool', 'dynamic', 'function'];

  int activeIndex = 0;
  Offset offset = const Offset(50, 100);

  @override
  Widget build(BuildContext context) {

    print(MediaQueryManager.instance.designHeight);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
             SizedBox(
              height: 130.h,
            ),
            const InputChip(label: Text("Hello")),
            Wrap(
              children: listOfChip.map((e) {
                return QuickChip(
                  borderColor: Colors.grey,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  deleteIcon: const Icon(
                    Icons.ac_unit_sharp,
                    color: Colors.black,
                    size: 10,
                  ),
                  label: e,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 50,
            ),
            InputFields(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required Filed';
                }
                return null;
              },

              unFocusedColor: Colors.grey.withOpacity(0.3),
              focusedColor: Colors.black87,
              borderColor: (val) => val!,
              label: const Text('label'),
            //  focusNode: focusNode,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Email',
              suffixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.red,
              ),
              prefixIcon: "assets/icon.svg",
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            QuickRichText(
              textSpans: [
                TextSpan(
                  text: 'Hello ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    print('Hello tapped');
                  },
                ),
                TextSpan(
                  text: 'World',
                  style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    print('World tapped');
                  },
                ),
              ],
              textAlign: TextAlign.center,
              maxLines: 2,
            ),

            QuickButton(onTap: (){},text: "Quick Button",boxShape: BoxShape.rectangle,),

            ElevatedButton(
                onPressed: () {
                  QuickToast.of(context).show(
                      title: "title 2 wsd",
                      position: 1.sh-1.stB,
                      radius: BorderRadius.circular(
                          MediaQuery.sizeOf(context).width),
                      width: MediaQuery.sizeOf(context).width - 10);
                },
                child: const Center(child: Text('Tab'))),
            const SizedBox(
              height: 50,
            ),
            const QuickFloat(
              initialOffsets: Offset(0, 1),
              child:SizedBox(
                  height: 100,
                  width: 100,
                  child: FlutterLogo()),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(width: 200, child: QuickStopWatch()),
          ],
        ),
      ),
      bottomNavigationBar: SimpleBottomBar(
        items: [
          BarItem(
            icon: Icons.crop,
            activeIcon: Icons.crop,
            index: 0,
            selectedIndex: 0,
            onTap: (int index) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cropper()));
            },
          ),
          BarItem(
            icon: Icons.ac_unit,
            activeIcon: Icons.access_time_filled,
            index: 0,
            selectedIndex: 0,
            onTap: (int index) {},
          ),
          BarItem(
            icon: Icons.add_chart,
            activeIcon: Icons.add_chart,
            index: 0,
            selectedIndex: 0,
            onTap: (int index) {},
          ),
        ],
        onChange: (int index) {},
      ),
    );
  }
}
