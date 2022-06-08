import 'package:adventure_app/models/story_brain.dart';
import 'package:adventure_app/reusables/background_image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StoryBrain storyBrain = StoryBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: backGroundImage(context),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              storyTile(
                question: storyBrain.getStory(),
              ),
              buttonWidget(
                  buttonColor: Colors.green,
                  buttonText: storyBrain.getChoice1(),
                  callback: () {
                    setState(() {
                      storyBrain.nextStory(1);
                    });
                  },
                  visible: false),
              const SizedBox(
                height: 20.0,
              ),
              buttonWidget(
                  buttonColor: Colors.red,
                  buttonText: storyBrain.getChoice2(),
                  callback: () {
                    setState(() {
                      storyBrain.nextStory(2);
                    });
                  },
                  visible: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget storyTile({required String question}) {
    return Expanded(
      flex: 12,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonWidget(
      {required Color buttonColor,
      required String buttonText,
      required VoidCallback callback,
      required bool visible}) {
    return (visible == true)
        ? Expanded(
            flex: 2,
            child: Visibility(
              visible: storyBrain.buttonShouldBeVisible(),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    buttonColor,
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: callback,
              ),
            ),
          )
        : Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttonColor,
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: callback,
            ),
          );
  }
}
