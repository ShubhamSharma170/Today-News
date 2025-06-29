// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:today_news/constant/colors.dart';

Widget loadingIndicator({Color? color}) =>
    Center(child: CircularProgressIndicator(color: color ?? AllColors.black));
