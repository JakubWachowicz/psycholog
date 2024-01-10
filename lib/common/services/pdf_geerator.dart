import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_document/open_document.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class PdfGeneratorService{
  Future<Uint8List> createLoginDataList() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!',style: pw.TextStyle(font: font)),
        ),
      ),
    );

    return pdf.save();
    //await file.writeAsBytes(await pdf.save());
  }

  Future<void> savePdf(String filename,Uint8List byteList) async{
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$filename.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);

  }
}