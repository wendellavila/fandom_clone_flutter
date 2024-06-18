import 'package:fandom_clone/config/theme_data.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:flutter/material.dart';
import 'package:fandom_clone/ui/screens/article/article_screen.dart';

class WikiBrowser extends StatefulWidget {
  const WikiBrowser({super.key});

  static List<WikiInfo> suggestions = [
    const WikiInfo(name: 'Fallout Wiki', prefix: 'fallout'),
    const WikiInfo(name: 'Japanese Music Wiki', prefix: 'jpop'),
    const WikiInfo(name: 'Wookiepedia', prefix: 'wookiepedia'),
  ];

  @override
  State<WikiBrowser> createState() => _WikiBrowserState();
}

class _WikiBrowserState extends State<WikiBrowser> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  late FocusNode _textFieldFocus;
  bool isButtonHovered = false;
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _textFieldFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.fandomPink,
              Theme.of(context).colorScheme.fandomPurple,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _textFieldFocus,
                      builder: (context, child) => TextFormField(
                        controller: _textFieldController,
                        initialValue: null,
                        focusNode: _textFieldFocus,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          if (value.isEmpty != isButtonDisabled) {
                            setState(() {
                              isButtonDisabled = value.isEmpty;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter a FANDOM wiki prefix',
                          hintStyle: TextStyle(
                            color: _textFieldFocus.hasFocus
                                ? const Color.fromARGB(
                                    255,
                                    150,
                                    150,
                                    150,
                                  )
                                : Colors.white,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.fandomPurple,
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 6),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          disabledBackgroundColor: const Color.fromARGB(100, 82, 0, 68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: isButtonDisabled
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final prefix = _textFieldController.text;
                                  debugPrint(prefix);
                                }
                              },
                        onHover: (isHovered) => setState(() {
                          isButtonHovered = isHovered;
                        }),
                        child: Text(
                          'GO',
                          style: TextStyle(
                            color: isButtonDisabled
                                ? const Color.fromARGB(
                                    160,
                                    250,
                                    0,
                                    92,
                                  )
                                : Theme.of(context).colorScheme.fandomPink,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 8),
                child: Text(
                  '...or view one of the suggestions below:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.fandomYellow,
                    fontSize: 14,
                  ),
                ),
              ),
              Wrap(
                children: [
                  for (var suggestion in WikiBrowser.suggestions)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage(
                              pagename: 'Main Page',
                              wikiName: suggestion.name,
                              wikiPrefix: suggestion.prefix,
                            ),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Theme.of(context).colorScheme.fandomYellow,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          suggestion.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.fandomYellow,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
