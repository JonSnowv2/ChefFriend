import 'package:flutter/material.dart';
import 'package:my_app/register_page.dart';
import 'package:my_app/log_in_page.dart';
import 'package:my_app/homepage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'dart:html' as html;

void main() => runApp(OverlaySupport(
  child:   MaterialApp(
  
    home: RegisterPage(),
  
  ),
));