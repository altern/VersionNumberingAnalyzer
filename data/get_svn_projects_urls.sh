#!/bin/sh
for project in `cat svn_projects.list`; do
	echo "==$project=="
	svn log -r 1:HEAD --limit 1 "svn://svn.code.sf.net/p/$project/code"
done
