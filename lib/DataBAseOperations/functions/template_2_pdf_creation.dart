import 'dart:io';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';
import 'package:resume_maker/DataBAseOperations/functions/template1.dart/pdfcreation/pdf_creation_model1.dart';

int contentHeight = 0;

Future<pw.Document> pdfCreationTemplate_2(ResumeData resumeData) async {
  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
  Map<String, dynamic> processLanguageString(String language) {
    if (language.length > 1) {
      String lastChar = language[language.length - 1];
      if (RegExp(r'^[1-5]$').hasMatch(lastChar)) {
        String processedLanguage = language.substring(0, language.length - 2);
        return {'language': processedLanguage, 'rating': int.parse(lastChar)};
      }
    }
    return {'language': language, 'rating': null};
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          pw.Stack(
            children: [
              pw.Container(
                decoration: const pw.BoxDecoration(
                  color: PdfColorCmyk.fromRgb(.77, .77, .77, 1),
                ),
                height: 60,
                width: double.infinity,
                child: pw.Align(
                  alignment: pw.Alignment.bottomRight,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 8.0, bottom: 15),
                    child: pw.Text(
                      resumeData.personal.isNotEmpty
                          ? resumeData.personal[0] ?? ''
                          : '',
                      style: pw.TextStyle(
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              pw.Wrap(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 15, top: 35),
                  child: pw.SizedBox(
                    width: 220,
                    child: pw.Column(
                      children: [
                        resumeData.profileimage != null &&
                            resumeData.profileimage!.isNotEmpty?
                          pw.Container(
                            width: 120,
                            height: 120,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              image: pw.DecorationImage(
                                image: pw.MemoryImage(
                                    File(resumeData.profileimage!)
                                        .readAsBytesSync()),
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          ):pw.SizedBox(height: 100),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Phone',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          '${resumeData.personal.isNotEmpty ? resumeData.personal[1] ?? '' : ''},\n${resumeData.personal.isNotEmpty ? resumeData.personal[2] ?? '' : ''}',
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.normal),
                        ),
                        pw.SizedBox(height: 12),
                        if (resumeData.personal.isNotEmpty &&
                            resumeData.personal[9] != null)
                          pw.Text(
                            'Date Of Birth',
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.normal),
                          ),
                        if (resumeData.personal.isNotEmpty &&
                            resumeData.personal[9] != null)
                          pw.Text(
                            resumeData.personal[9] ?? '',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold),
                          ),
                        pw.SizedBox(height: 12),
                        pw.Text(
                          'Address',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.normal),
                        ),
                        pw.SizedBox(
                          width: 130,
                          child: pw.Text(
                            textAlign: pw.TextAlign.center,
                            '${resumeData.personal.isNotEmpty ? resumeData.personal[4] ?? '' : ''}  ${resumeData.personal.isNotEmpty ? resumeData.personal[5] ?? '' : ''}, ${resumeData.personal.isNotEmpty ? resumeData.personal[7] ?? '' : ''}, ${resumeData.personal.isNotEmpty ? resumeData.personal[6] ?? '' : ''}',
                            style: pw.TextStyle(
                                fontSize: 9, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.SizedBox(height: 12),
                        CustomDivider(value: 'CONTACT'),
                        pw.SizedBox(
                          height: 12,
                        ),
                        pw.Row(
                          children: [
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(right: 8.0, top: 4),
                              child: pw.Icon(const pw.IconData(0xe158),
                                  size: 12), // Using Material Icons
                            ),
                            pw.SizedBox(
                              width: 160,
                              child: pw.Text(
                                resumeData.personal.isNotEmpty
                                    ? resumeData.personal[3] ?? ''
                                    : '',
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 8),
                        if (resumeData.skillsandothers.isNotEmpty &&
                            resumeData.skillsandothers[0].containsKey(7))
                          if (resumeData.skillsandothers[0][7]!.isNotEmpty)
                            CustomDivider(value: 'OBJECTIVE'),
                        pw.SizedBox(height: 5),
                        if (resumeData.skillsandothers.isNotEmpty &&
                            resumeData.skillsandothers[0].containsKey(7))
                          ...resumeData.skillsandothers[0][7]!
                              .map((objective) => pw.SizedBox(
                                    width: 120,
                                    child: pw.Text(
                                      objective,
                                      textAlign: pw.TextAlign.left,
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  )),
                        pw.SizedBox(height: 5),
                        if (resumeData.skillsandothers.isNotEmpty &&
                            resumeData.skillsandothers[0].containsKey(5))
                          CustomDivider(value: 'LANGUAGE'),
                        pw.SizedBox(height: 5),
                        if (resumeData.skillsandothers.isNotEmpty &&
                            resumeData.skillsandothers[0].containsKey(5))
                          ...resumeData.skillsandothers[0][5]!.map((language) {
                            var processedLanguage =
                                processLanguageString(language);
                            String languageName = processedLanguage['language'];
                            int? rating = processedLanguage['rating'];
                            return pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 20),
                                child: pw.SizedBox(
                                  width: double.maxFinite - 30,
                                  child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        width: 65,
                                        child: pw.Text(
                                          languageName,
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                      ),
                                      pw.SizedBox(width: 4),
                                      if (rating != null) ...[
                                        ...List.generate(
                                          rating,
                                          (index) => pw.Icon(
                                            const pw.IconData(
                                                0xe838), // Unicode for filled star icon
                                            size: 10,
                                            color: const PdfColor.fromInt(
                                                0xFFE0B700), // Equivalent to Color.fromARGB(255, 224, 183, 0)
                                          ),
                                        ),
                                        ...List.generate(
                                          5 - rating,
                                          (index) => pw.Icon(
                                            const pw.IconData(
                                                0xe83a), // Unicode for outlined star icon
                                            size: 10,
                                            color: const PdfColor.fromInt(
                                                0xFFE0B700),
                                            // Equivalent to Color.fromARGB(255, 224, 183, 0)
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ));
                          }).toList(),
                        pw.SizedBox(height: 8),
                        if (resumeData.skillsandothers.isNotEmpty &&
                            resumeData.skillsandothers[0].containsKey(1))
                          if (resumeData.skillsandothers[0][1]!.isNotEmpty)
                            CustomDivider(value: 'SKILLS'),
                        pw.SizedBox(height: 8),
                        if (resumeData.skillsandothers.isNotEmpty &&
                            resumeData.skillsandothers[0].containsKey(1))
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 10),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: resumeData.skillsandothers[0][1]!
                                    .map(
                                      (skill) => pw.Padding(
                                        padding: const pw.EdgeInsets.only(
                                            bottom: 8.0),
                                        child: pw.SizedBox(
                                            width: double.maxFinite - 20,
                                            child: pw.Row(
                                              children: [
                                                pw.Icon(
                                                    const pw.IconData(0xe5e1),
                                                    size: 8),
                                                pw.Text(
                                                  '  $skill',
                                                  style: pw.TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          pw.FontWeight.normal),
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                                    .toList(),
                              )),
                      ],
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 35.0, left: 30),
                  child: pw.SizedBox(
                    width: 230,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 20.0, top: 100),
                      child: pw.ListView(
                        children: [
                          if (resumeData.experiance.isNotEmpty)
                            CustomDivider(value: 'WORK EXPERIENCE'),
                          if (resumeData.experiance.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: resumeData.experiance.map((exp) {
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      left: 10, top: 8),
                                  child: pw.Row(
                                    children: [
                                      pw.SizedBox(
                                        width: 50,
                                        child: pw.Text(
                                          '${exp[2]} -\n${exp[3]}',
                                          style:
                                              const pw.TextStyle(fontSize: 8),
                                        ),
                                      ),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                        children: [
                                          pw.SizedBox(
                                            width: 120,
                                            child: pw.Text(
                                              '${exp[1] != null ? exp[1]!.toUpperCase() : ''} ',
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 120,
                                            child: pw.Text(
                                              '${exp[0]} ',
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          pw.SizedBox(height: 8),
                          if (resumeData.education.isNotEmpty)
                            CustomDivider(value: 'EDUCATION'),
                          if (resumeData.education.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: resumeData.education.map((edu) {
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: pw.Row(
                                    children: [
                                      pw.SizedBox(
                                        width: 60,
                                        child: pw.Text(
                                          'Graduation: ${edu[1] != null ? edu[1]! : ''}',
                                          style:
                                              const pw.TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      pw.Column(
                                        children: [
                                          pw.SizedBox(
                                            width: 140,
                                            child: pw.Text(
                                              edu[0] ?? '',
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 140,
                                            child: pw.Text(
                                              'Course: ${edu[2] ?? ''}',
                                              style: const pw.TextStyle(
                                                  fontSize: 10),
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 140,
                                            child: pw.Text(
                                              'Marks: ${edu[3] != null && edu[3]!.isNotEmpty && double.tryParse(edu[3]!) != null ? double.parse(edu[3]!) < 100 ? '${edu[3]} %' : edu[3] : ''}',
                                              style: const pw.TextStyle(
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          if (resumeData.projects.isNotEmpty)
                            CustomDivider(value: 'PROJECTS'),
                          if (resumeData.projects.isNotEmpty)
                            pw.SizedBox(
                              width: 200,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: resumeData.projects.map((proj) {
                                  return pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.SizedBox(
                                        width: 60,
                                        child: pw.Text(
                                          '${proj[2] ?? ''}-\n${proj[3]}',
                                          style:
                                              const pw.TextStyle(fontSize: 9),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        width: 130,
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              proj[0] != null
                                                  ? proj[0]!.toUpperCase()
                                                  : '',
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            ),
                                            pw.Text(
                                              '${proj[1] ?? ''}\nTeam size: ${proj[5] ?? ''}\n Role:${proj[4]}',
                                              style: const pw.TextStyle(
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          pw.SizedBox(height: 8),
                          if (resumeData.skillsandothers.isNotEmpty &&
                              resumeData.skillsandothers[0].containsKey(2))
                            if (resumeData.skillsandothers[0][2]!.isNotEmpty)
                              CustomDivider(value: 'ACHIEVEMENTS'),
                          if (resumeData.skillsandothers.isNotEmpty &&
                              resumeData.skillsandothers[0].containsKey(2) &&
                              resumeData.skillsandothers[0][2]!.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: resumeData.skillsandothers[0][2]!
                                  .map((achievement) => pw.Padding(
                                        padding: const pw.EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: pw.SizedBox(
                                          width: 200,
                                          child: pw.Text(
                                            achievement,
                                            style: const pw.TextStyle(
                                                fontSize: 10),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          pw.SizedBox(height: 8),
                              if (resumeData.skillsandothers.isNotEmpty &&
                                  resumeData.skillsandothers[0].containsKey(3))
                                if (resumeData
                                    .skillsandothers[0][3]!.isNotEmpty)
                                   CustomDivider(value: 'INTRESTS'),
                              if (resumeData.skillsandothers.isNotEmpty &&
                                  resumeData.skillsandothers[0]
                                      .containsKey(3) &&
                                  resumeData.skillsandothers[0][3]!.isNotEmpty)
                                pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: resumeData.skillsandothers[0][3]!
                                      .map((achievement) => pw.Padding(
                                            padding: const pw. EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: pw.SizedBox(
                                              width: 200,
                                              child:pw. Text(
                                                achievement,
                                                style: const pw.TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                                pw.SizedBox(height: 8,),
                                  if (resumeData.skillsandothers.isNotEmpty &&
                                  resumeData.skillsandothers[0].containsKey(4))
                                if (resumeData
                                    .skillsandothers[0][4]!.isNotEmpty)
                                   CustomDivider(value: 'HOBBIES'),
                              if (resumeData.skillsandothers.isNotEmpty &&
                                  resumeData.skillsandothers[0]
                                      .containsKey(4) &&
                                  resumeData.skillsandothers[0][4]!.isNotEmpty)
                                pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: resumeData.skillsandothers[0][4]!
                                      .map((achievement) => pw.Padding(
                                            padding: const pw. EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: pw.SizedBox(
                                              width: 200,
                                              child: pw.Text(
                                                achievement,
                                                style: const pw.TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                               pw.SizedBox(height: 8),
                               if (resumeData.skillsandothers.isNotEmpty &&
                                  resumeData.skillsandothers[0].containsKey(6))
                                if (resumeData
                                    .skillsandothers[0][6]!.isNotEmpty)
                                   CustomDivider(value: 'STRENGTH'),
                              if (resumeData.skillsandothers.isNotEmpty &&
                                  resumeData.skillsandothers[0]
                                      .containsKey(6) &&
                                  resumeData.skillsandothers[0][6]!.isNotEmpty)
                                pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: resumeData.skillsandothers[0][6]!
                                      .map((achievement) =>pw. Padding(
                                            padding: const pw.EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: pw.SizedBox(
                                              width: 200,
                                              child: pw.Text(
                                                achievement,
                                                style: const pw.TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              pw. SizedBox(height: 8),
                          CustomDivider(value: 'DECLARATIONS'),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            'I hereby certify that the above information is true and correct to the best of my knowledge and belief.',
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(
                            width: 160,
                            child: pw.Text(
                              resumeData.personal.isNotEmpty
                                  ? resumeData.personal[0] ?? ''
                                  : '',
                              textAlign: pw.TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
              
            ],
          ),
        ];
      },
    ),
  );

  return pdf;
}

Future<File> pdfLocalSave(pw.Document pdf) async {
  final directory = await getExternalStorageDirectory();
  final file = File("${directory?.path}/resume.pdf");
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.toList());
  return file;
}

Future<File> downloadPdfFileToStorage(pw.Document pdf) async {
  final directory = await getExternalStorageDirectory();
  final file = File("${directory?.path}/resume.pdf");
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.toList());
  DocumentFileSavePlus().saveMultipleFiles(
    dataList: [
      pdfBytes,
    ],
    fileNameList: [
      "resume.pdf",
    ],
    mimeTypeList: [
      "application/pdf",
    ],
  );

  if (kDebugMode) {
    print('\n' 'the name of file is: $file ' '\n');
  }
  return file;
}


