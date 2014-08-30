#!/bin/sh
for project in `cat svn_projects.list`; do
	echo "==$project=="
	svn log "svn://svn.code.sf.net/p/$project/code" --quiet | grep '^r' | awk '{print $3}' | sort | uniq | wc -l
done
