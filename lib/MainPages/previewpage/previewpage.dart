import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:resume_maker/DataBAseOperations/functions/template1.dart/resume_templete_1model.dart';
import 'package:resume_maker/DataBAseOperations/functions/template1.dart/resumemodel_1_height_calc.dart';
import 'package:resume_maker/DataBAseOperations/functions/template1.dart/pdfcreation/pdf_creation_model1.dart';
import 'package:resume_maker/DataBAseOperations/functions/template_2_pdf_creation.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Future<void> fetchData() async {
   await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(214, 255, 255, 255),
        appBar: AppBar(
          title: const Text(
            'Preview',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          backgroundColor: fourthcolor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget> [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: 580,
                  width: 350,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 194, 194, 194),
                  ),
                  child: ClipRect(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: 410, // Original width of the resume template
                        height: 700, // Original height of the resume template
                        child: currentRessume != null
                            ? FutureBuilder<void>(
                                future: fetchData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Stack(
                                      children: [
                                      
                                        ResumeModel1HeightCalculation(
                                            resumeData: currentRessume!),
                                              const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                                  } else {
                                    // return Placeholder();
                                    return ResumeModel1Preview(
                                        resumeData: currentRessume!);
                                  }
                                })
                            : const Stack(
                                alignment: Alignment.center,
                                children: [
                                    Icon(
                                      Icons.picture_as_pdf_outlined,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                    CircularProgressIndicator()
                                  ]), // Your resume template widget
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            if (currentRessume != null) {
                              //  dynamic pdf = await pdfCreationTemplate_1(currentRessume!);
                              dynamic pdf =
                                  await pdfCreationTemplate_1(currentRessume!);
                              pdf = await pdfLocalSave(pdf);
                              OpenFile.open(pdf.path);
                              if (kDebugMode) {
                                print('pressed  view pdf button');
                              }
                            }
                          } catch (e) {
                            print('Exception Caught :-$e');
                          }
                        },
                        child: const Text('View Pdf')),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            if (currentRessume != null) {
                              //  dynamic pdf = await pdfCreationTemplate_1(currentRessume!);

                              dynamic pdf =
                                  await pdfCreationTemplate_1(currentRessume!);
                              pdf = await downloadPdfFileToStorage(pdf);

                              OpenFile.open(pdf.path);
                              if (kDebugMode) {
                                print('pressed  download pdf button');
                              }
                            }
                          } catch (error) {
                            print('Exception Caught :-$error');
                          }
                        },
                        child: const Text('Download PDF'))
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
