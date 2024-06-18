import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WikiFooter extends StatelessWidget {
  const WikiFooter({this.wikiName = '', super.key});

  final String wikiName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Color(0XFF520044)),
          padding: const EdgeInsets.only(top: 24, bottom: 18),
          width: double.infinity,
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse('https://fandom.com'));
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Fand',
                    style: TextStyle(
                      color: const Color(0XFFf9edd8),
                      fontFamily: GoogleFonts.russoOne().fontFamily,
                      fontSize: 28,
                    ),
                    children: const [
                      TextSpan(
                        text: 'o',
                        style: TextStyle(
                          color: Color(0xfffa005a),
                        ),
                      ),
                      TextSpan(text: 'm'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            wikiName != '' ? "$wikiName is a FANDOM Community." : 'Copyright 2024',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        )
      ],
    );
  }
}
