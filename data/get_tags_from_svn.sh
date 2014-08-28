#!/bin/sh
for i in `cat svn_projects.txt`; do
	svn list svn://svn.code.sf.net/p/$i/code/tags > "$i"_release_history.txt
done


