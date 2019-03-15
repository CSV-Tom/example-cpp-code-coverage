
PROJECT_DIR=$(shell pwd)


all: clean build lcov-pre check lcov-post lcov-combine #genhtml

clean:
	$(RM) lcov.info
	$(RM) testprog
	$(RM) html
	$(RM) *.gcno
	$(RM) *.gcda
	$(RM) lcov-pre.info
	$(RM) lcov-post.info
	$(RM) total.info

build: 
	g++ main.cc --coverage -o testprog -g -O0

check:
	./testprog


lcov-pre:
	lcov --no-external --capture --initial --directory $(PROJECT_DIR) --output-file lcov-pre.info

lcov-post:
	lcov --no-external --capture --directory $(PROJECT_DIR) --output-file lcov-post.info

lcov-combine:
	lcov --add-tracefile lcov-pre.info \
	     --add-tracefile lcov-post.info \
	     --output-file total.info

genhtml:
	genhtml --prefix "/usr/local/src/libreoffice" \
                --ignore-errors \
                --legend \
		--title "commit SHA1" \
		--output-directory=html \
                source "lcov.info"
