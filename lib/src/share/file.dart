import 'dart:typed_data';

import 'package:share_options/share_options.dart';
import 'package:share_options/src/activity_info.dart';

import '../share_option.dart';

class FileShare extends ShareOption {
  FileShare(String name, Uint8List icon, ActivityInfo activityInfo)
      : super(name, icon, activityInfo);

  static String action, mimeType;
  static List<String> paths;

  factory FileShare.fromMap(Map<String, dynamic> map) {
    return FileShare(
      map['name'] as String,
      map['icon'] as Uint8List,
      ActivityInfo.fromMap(Map<String, String>.from(map['activityInfo'])),
    );
  }

  @override
  Future<void> share() async {
    print(mimeType);
    await channel.invokeMethod('shareFiles', {
      'action': action,
      'mimeType': mimeType,
      'paths': paths,
      'text': ShareOption.text,
      'subject': ShareOption.subject,
      ...activityInfo.toMap,
    });
  }
}