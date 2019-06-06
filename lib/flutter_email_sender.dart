import 'dart:async';

import 'package:flutter/services.dart';

class FlutterEmailSender {
  static const MethodChannel _channel = const MethodChannel('flutter_email_sender');

  static Future<EmailSendResult> send(Email mail) async {
    final String result = await _channel.invokeMethod('send', mail.toJson());
    return emailSendResult(result);
  }
}

EmailSendResult emailSendResult(String name) =>
    EmailSendResult.values.firstWhere((result) => "$result" == name, orElse: () => EmailSendResult.unknown);

enum EmailSendResult { cancelled, sent, unknown }

class Email {
  final String subject;
  final List<String> recipients;
  final List<String> cc;
  final List<String> bcc;
  final String body;
  final String attachmentPath;
  Email({
    this.subject = '',
    this.recipients = const [],
    this.cc = const [],
    this.bcc = const [],
    this.body = '',
    this.attachmentPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'body': body,
      'recipients': recipients,
      'cc': cc,
      'bcc': bcc,
      'attachment_path': attachmentPath
    };
  }
}
