#!/bin/sh
for project in `cat git_projects.list`; do
	if [ -a "$project"_release_history.txt ]; then
		git mv "$project"_release_history.txt "${project}_release_history(git).txt"
	fi
done
for project in `cat svn_projects.list`; do
	if [ -a "$project"_release_history.txt ]; then
		git mv "$project"_release_history.txt "${project}_release_history(svn).txt"
	fi
done
for project in `cat release_notes_projects.list`; do
	if [ -a "$project"_release_history.txt ]; then
		git mv "$project"_release_history.txt "${project}_release_history(release_notes).txt"
	fi
done
