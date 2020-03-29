#!/bin/sh

flutter drive --target=test_driver/app_empty.dart --driver=test_driver/app_empty_test.dart
flutter drive --target=test_driver/app_network_error.dart --driver=test_driver/app_network_error_test.dart
flutter drive --target=test_driver/app.dart --driver=test_driver/home_news_test.dart
