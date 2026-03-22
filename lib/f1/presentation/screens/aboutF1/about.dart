import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/about_f1_model.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/aboutF1_widget.dart';
import '../../../../l10n/app_localizations.dart';

class aboutF1 extends StatelessWidget {
  const aboutF1({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    final l10n = AppLocalizations.of(context)!;

    List<AboutF1Model> aboutF1 = [
      AboutF1Model(title: l10n.aboutOriginsTitle,    body: l10n.aboutOriginsBody),
      AboutF1Model(title: l10n.aboutErasTitle,       body: l10n.aboutErasBody),
      AboutF1Model(title: l10n.aboutGrandPrixTitle,  body: l10n.aboutGrandPrixBody),
      AboutF1Model(title: l10n.aboutPointsTitle,     body: l10n.aboutPointsBody),
      AboutF1Model(title: l10n.aboutCarsTitle,       body: l10n.aboutCarsBody),
      AboutF1Model(title: l10n.aboutSafetyTitle,     body: l10n.aboutSafetyBody),
      AboutF1Model(title: l10n.aboutTeamsTitle,      body: l10n.aboutTeamsBody),
      AboutF1Model(title: l10n.aboutDriversTitle,    body: l10n.aboutDriversBody),
      AboutF1Model(title: l10n.aboutRecordsTitle,    body: l10n.aboutRecordsBody),
      AboutF1Model(title: l10n.aboutCircuitsTitle,   body: l10n.aboutCircuitsBody),
      AboutF1Model(title: l10n.aboutGlossaryTitle,   body: l10n.aboutGlossaryBody),
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: darkBg,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'About F1',
              style: TextStyle(
                fontFamily: "TitilliumWeb",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.sports_motorsports, color: Colors.white, size: 30),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: aboutF1.length,
        itemBuilder: (context, index) {
          return AboutF1Widget(model: aboutF1[index]);
        },
      ),
    );
  }
}
