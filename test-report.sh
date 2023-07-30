#!/bin/bash
./generate_coverage_helper_test_file.sh weather_app&& \
flutter test --coverage ./lib && \
./generate-report.sh