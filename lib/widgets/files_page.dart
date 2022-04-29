import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: widget.files.length,
      itemBuilder: (context, index) {
        final file = widget.files[index];
        return buildFile(file);
      },
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    //TODO redo it as a listview.builder with an index, that will display a list of items from the task model
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
        child: Column(
          children: [
            InkWell(
              onTap: () => widget.onOpenedFile(file),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Center(
                        child: showExtension(extension),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                      width: 100,
                      child: Text(file.name, overflow: TextOverflow.ellipsis)),
                  Text(fileSize),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showExtension(String extension) {
  switch (extension) {
    case 'ai':
      return Image.asset('assets/images/pictures/ai.png');
    case 'android':
      return Image.asset('assets/images/pictures/android.png');
    case 'apk':
      return Image.asset('assets/images/pictures/apk.png');
    case 'css':
      return Image.asset('assets/images/pictures/css.png');
    case 'disc':
      return Image.asset('assets/images/pictures/disc.png');
    case 'doc':
      return Image.asset('assets/images/pictures/doc.png');
    case 'excel':
      return Image.asset('assets/images/pictures/excel.png');
    case 'otf':
      return Image.asset('assets/images/pictures/font.png');
    case 'iso':
      return Image.asset('assets/images/pictures/iso.png');
    case 'javascript':
      return Image.asset('assets/images/pictures/javascript.png');
    case 'jpg':
      return Image.asset('assets/images/pictures/jpg.png');
    case 'js':
      return Image.asset('assets/images/pictures/js.png');
    case 'mail':
      return Image.asset('assets/images/pictures/mail.png');
    case 'mp3':
      return Image.asset('assets/images/pictures/mp3.png');
    case 'mp4':
      return Image.asset('assets/images/pictures/mp4.png');
    case 'music':
      return Image.asset('assets/images/pictures/music.png');
    case 'pdf':
      return Image.asset('assets/images/pictures/pdf.png');
    case 'php':
      return Image.asset('assets/images/pictures/php.png');
    case 'play':
      return Image.asset('assets/images/pictures/play.png');
    case 'powerpoint':
      return Image.asset('assets/images/pictures/powerpoint.png');
    case 'ppt':
      return Image.asset('assets/images/pictures/ppt.png');
    case 'psd':
      return Image.asset('assets/images/pictures/psd.png');
    case 'record':
      return Image.asset('assets/images/pictures/record.png');
    case 'sql':
      return Image.asset('assets/images/pictures/sql.png');
    case 'svg':
      return Image.asset('assets/images/pictures/svg.png');
    case 'text':
      return Image.asset('assets/images/pictures/text.png');
    case 'ttf':
      return Image.asset('assets/images/pictures/font.png');
    case 'txt':
      return Image.asset('assets/images/pictures/txt.png');
    case 'vcf':
      return Image.asset('assets/images/pictures/vcf.png');
    case 'vector':
      return Image.asset('assets/images/pictures/vector.png');
    case 'video':
      return Image.asset('assets/images/pictures/video.png');
    case 'word':
      return Image.asset('assets/images/pictures/word.png');
    case 'xls':
      return Image.asset('assets/images/pictures/xls.png');
    case 'zip':
      return Image.asset('assets/images/pictures/zip.png');
    default:
  }
}
