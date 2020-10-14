import 'package:flutter/material.dart';
import 'package:TXPlayer/shared/shared_manager.dart';
import 'package:TXPlayer/shared/languages.dart';

class PreferredLanguagesDialog extends StatefulWidget {
  final languages = LanguageList.langs;

  @override
  _PreferredLanguagesDialogState createState() =>
      _PreferredLanguagesDialogState();
}

class _PreferredLanguagesDialogState extends State<PreferredLanguagesDialog> {
  String subtitleSourceLanguage;
  String subtitleTargetLanguage;

  @override
  void initState() {
    if (!SharedManager.preferences.containsKey("subtitleSourceLanguage")) {
      SharedManager.preferences
          .setString("subtitleSourceLanguage", widget.languages["auto"]);
    }
    subtitleSourceLanguage =
        SharedManager.preferences.getString("subtitleSourceLanguage");

    if (!SharedManager.preferences.containsKey("subtitleTargetLanguage")) {
      SharedManager.preferences
          .setString("subtitleTargetLanguage", widget.languages["en"]);
    }
    subtitleTargetLanguage =
        SharedManager.preferences.getString("subtitleTargetLanguage");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: Color.fromRGBO(28, 41, 57, 1),
      title: Text(
        "Subtitle Settings",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1.copyWith(
              fontWeight: FontWeight.normal,
            ),
      ),
      content: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: deviceHeight * 0.025),
            Text(
              "Source Language",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            DropdownButton(
              value: subtitleSourceLanguage,
              items: widget.languages.values
                  .map(
                    (language) => DropdownMenuItem(
                      child: Text(
                        language,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      value: language,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  subtitleSourceLanguage = value;
                });
              },
            ),
            SizedBox(height: deviceHeight * 0.025),
            Text(
              "Target Language",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            DropdownButton(
              value: subtitleTargetLanguage,
              items: widget.languages.values
                  .map(
                    (language) => DropdownMenuItem(
                      child: Text(
                        language,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      value: language,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  subtitleTargetLanguage = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            SharedManager.preferences.setString(
              "subtitleSourceLanguage",
              subtitleSourceLanguage,
            );
            SharedManager.preferences.setString(
              "subtitleTargetLanguage",
              subtitleTargetLanguage,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
