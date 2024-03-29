#!/bin/bash

. delete_test_archive.sh

set -x verbose
./insert -v --exclude 'rdiff-backup-data' --exclude '\.hg.*' test_archive test_source1
ls -1 test_archive/store > test_archive/sav/filelist1_test
diff test_archive/sav/filelist1_test test_archive/sav/filelist1_expected
diff test_archive/tax/sources\;0 test_archive/sav/taxonomy1_expected

./insert --list_insert test_archive test_source1

./insert -v --list_insert test_archive test_source2
ls -1 test_archive/store > test_archive/sav/filelist2_test
diff test_archive/sav/filelist2_test test_archive/sav/filelist2_expected
diff test_archive/tax/sources\;0 test_archive/sav/taxonomy2_expected

# check the integrity of the archive
#

diff -q  test_source1/tmp/q test_archive/store/1
diff -q  test_source2/tmp/q test_archive/store/1

diff -q  test_source1/log test_archive/store/2
diff -q  test_source2/log test_archive/store/2

diff -q  test_source1/tmp/r test_archive/store/3
diff -q  test_source2/tmp/r test_archive/store/3
diff -q  test_source1/tmp/s test_archive/store/3
diff -q  test_source2/tmp/s test_archive/store/3

diff -q  test_source2/a test_archive/store/4
diff -q  test_source1/d test_archive/store/4
diff -q  test_source1/a test_archive/store/4

diff -q  test_source2/temp test_archive/store/5
diff -q  test_source1/temp test_archive/store/5

diff -q  test_source1/tmp/rdiff-backup-data/file1-rdbu test_archive/store/6

diff -q  test_source1/tmp/rdiff-backup-data/file2-rdiff test_archive/store/7

diff -q  test_source1/tmp/.hg/f1_merc test_archive/store/8

diff -q  test_source1/tmp/.hg/f2_merc test_archive/store/9

diff -q  test_source1/tmp/.hgignore test_archive/store/10

diff -q  test_source2/tmp/list test_archive/store/11

diff -q  test_source2/d test_archive/store/12
