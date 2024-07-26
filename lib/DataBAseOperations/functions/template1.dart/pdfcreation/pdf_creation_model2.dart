import 'dart:io';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';

import 'package:pdf/widgets.dart' as pw;

Future <File>pdfCreationModel_1(ResumeData resumeData)async{
   final pdf = pw.Document(
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );




  
  final directory = await getExternalStorageDirectory();
  final file = File("${directory?.path}/resume.pdf");
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.toList());
  OpenFile.open(file.path);
  return file;
}