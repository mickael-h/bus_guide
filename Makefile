ftest:
	flutter test --coverage && lcov -l coverage/lcov.info

dupes:
	${HOME}/pmd-bin-6.28.0/bin/run.sh cpd --language dart --files lib/ --minimum-tokens 30 -failOnViolation false
