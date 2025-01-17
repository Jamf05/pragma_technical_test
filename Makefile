# Makefile for Flutter project

coverage:
	fvm flutter test --coverage
	lcov --remove coverage/lcov.info 'lib/core/gen/*' 'lib/core/localization/*' 'lib/presentation/design/fundations*' 'lib/presentation/design/tokens*' -o coverage/lcov.info
	genhtml coverage/lcov.info -o coverage/html
.PHONY: coverage

build_runner:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
.PHONY: build_runner

pub_get:
	fvm flutter clean && fvm flutter pub get