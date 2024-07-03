import 'dart:convert';

import 'package:fandom_clone/model/wiki_statistics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fandom_clone/config/theme_data.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/ui/screens/fandom_home/wiki_suggestions.dart';
import 'package:fandom_clone/ui/screens/wiki_home/wiki_home_screen.dart';

class WikiBrowser extends StatefulWidget {
  const WikiBrowser({super.key});

  @override
  State<WikiBrowser> createState() => _WikiBrowserState();
}

class _WikiBrowserState extends State<WikiBrowser> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  late FocusNode _textFieldFocus;
  bool isButtonHovered = false;
  bool isButtonDisabled = true;
  final List<WikiInfo> suggestions = [];

  @override
  void initState() {
    super.initState();
    _textFieldFocus = FocusNode();
    _loadSuggestionsInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldFocus.dispose();
  }

  void _loadSuggestionsInfo() async {
    List<String> suggestionPrefixes = ['batman', 'fallout', 'jpop', 'starwars'];
    for (final prefix in suggestionPrefixes) {
      final suggestion = await _getWikiInfo(prefix: prefix);
      if (suggestion != null) {
        suggestions.add(suggestion);
      }
    }
    setState(() {
      suggestions.sort();
    });
  }

  Future<WikiInfo?> _getWikiInfo({required String prefix}) async {
    String wikiUrl = "$prefix.fandom.com";
    try {
      final url = Uri.https(wikiUrl, "/api.php", {
        "action": "query",
        "meta": "siteinfo",
        "siprop": "statistics|general",
        "format": "json",
        "origin": "*",
      });
      final response = await http.get(url);
      if (response.statusCode >= 400) return null;
      final jsonMap = jsonDecode(response.body) as Map;
      final name = jsonMap['query']['general']['sitename'] as String;
      final logo = jsonMap['query']['general']['logo'] as String;
      final statistics = jsonMap['query']['statistics'] as Map<String, dynamic>;

      final pageCount = statistics['pages'] as int;
      final articleCount = statistics['articles'] as int;
      final editCount = statistics['edits'] as int;
      final imageCount = statistics['images'] as int;
      final userCount = statistics['users'] as int;
      final activeUserCount = statistics['activeusers'] as int;

      return WikiInfo(
        name: name,
        prefix: prefix,
        logo: logo,
        statistics: WikiStatistics(
          pageCount: pageCount,
          articleCount: articleCount,
          editCount: editCount,
          imageCount: imageCount,
          userCount: userCount,
          activeUserCount: activeUserCount,
        ),
      );
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final prefix = _textFieldController.text;
                            _getWikiInfo(prefix: prefix).then((value) {
                              if (value != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WikiHomeScreen(
                                      wikiInfo: value,
                                    ),
                                  ),
                                );
                              } else {
                                //
                              }
                            });
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
        WikiSuggestions(
          suggestions: suggestions,
        ),
      ],
    );
  }
}
