PROJECT_DIR=$(shell pwd)


actions: clean lcov-action gcovr-action gcovr-action2 gcov-action


clean: gcovr-clean2 gcovr-clean lcov-clean gcov-clean common-clean 

# ---------------------------------------------------------------------------------------------------------
# Common tasks 
# ---------------------------------------------------------------------------------------------------------
common-clean:
	$(RM) *.gcno
	$(RM) *.gcda
	$(RM) testprog


build: 
	g++-5 -Wall --std=c++14 src/User.cpp main.cc --coverage -I. -o testprog -g -O0

check:
	./testprog



# ---------------------------------------------------------------------------------------------------------
# Separate task - Use lcov and genhtml
# ---------------------------------------------------------------------------------------------------------
LCOV_DIR=lcov/
LCOV_HTML_DIR=lcov/html/

lcov-action: clean build lcov-pre check lcov-post lcov-combine genhtml

lcov-dir: 
	$(shell mkdir -p $(LCOV_DIR))
	$(shell mkdir -p $(LCOV_HTML_DIR))

lcov-pre: lcov-dir
	lcov --no-external --capture --initial --directory "$(PROJECT_DIR)" --output-file "$(LCOV_DIR)/lcov-pre.info"

lcov-post: lcov-dir
	lcov --no-external --capture --directory "$(PROJECT_DIR)" --output-file "$(LCOV_DIR)/lcov-post.info"

lcov-combine: lcov-dir
	lcov --add-tracefile $(LCOV_DIR)/lcov-pre.info \
	     --add-tracefile $(LCOV_DIR)/lcov-post.info \
	     --output-file $(LCOV_DIR)/total.info

genhtml:
	$(shell mkdir -p $(LCOV_HTML_DIR))
	genhtml --prefix "$(PROJECT_DIR)" \
                --legend \
		--ignore-errors source "$(PROJECT_DIR)/$(LCOV_DIR)/total.info" \
		--title "$(shell git log | head)" \
		--output-directory="$(LCOV_HTML_DIR)"

lcov-clean: common-clean
	$(RM) -r $(LCOV_DIR)



# ---------------------------------------------------------------------------------------------------------
# Separate task - generate only gcov files (for sonar required)
# ---------------------------------------------------------------------------------------------------------
gcov-action: clean build check
	gcov-5 -b -l -p -c *.gcno # gcda and gcno have to already exists

gcov-clean: common-clean
	$(RM) *.gcov



# ---------------------------------------------------------------------------------------------------------
# Separate task - gcovr - Variante I - *.gcov Files are generated in the background by gcovr 
# ---------------------------------------------------------------------------------------------------------
# pip install --upgrade gcovr

GCOVR_HTML_DIR=gcovr/html/
GCOVR_XML_DIR=gcovr/xml/

gcovr-action: clean build check gcovr-generateHtmlReport gcovr-generateXmlReport

# html report
gcovr-generateHtmlReport:
	$(shell mkdir -p $(GCOVR_HTML_DIR))
	gcovr --gcov-executable="gcov-5" -k -r . --html-title="GCOVR - Variante I - $(shell git log | head)" --html --html-details -o $(GCOVR_HTML_DIR)/index.html 


# machine readable XML reports in Cobertura format
gcovr-generateXmlReport:
	$(shell mkdir -p $(GCOVR_XML_DIR))
	gcovr --gcov-executable="gcov-5" -k -r . --xml -o $(GCOVR_XML_DIR)/coverage.xml


gcovr-clean: common-clean
	$(RM) -r gcovr



# ---------------------------------------------------------------------------------------------------------
# Separate task - gcovr - Variante II - Already generated *.gcov Files used by gcovr 
# ---------------------------------------------------------------------------------------------------------
GCOVR_VARII_HTML_DIR=gcovr-varII/html/
GCOVR_VARII_XML_DIR=gcovr-varII/xml/

gcovr-action2: gcov-action
	$(shell mkdir -p $(GCOVR_VARII_HTML_DIR))
	gcovr -g -k -r . --html-title="GCOVR - Variante II - $(shell git log | head)" --html --html-details -o $(GCOVR_VARII_HTML_DIR)/index.html 
	$(shell mkdir -p $(GCOVR_VARII_XML_DIR))
	gcovr -g -k -r . --xml -o $(GCOVR_VARII_XML_DIR)/coverage.xml

gcovr-clean2: common-clean
	$(RM) -r gcovr-varII


firefoxy: 
	firefox lcov/html/index.html gcovr/html/index.html gcovr-varII/html/index.html
