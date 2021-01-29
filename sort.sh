#!/bin/sh

for fname in $(find $TR_TORRENT_DIR)
do
	# check for common music file extensions
	for music in '.aac' '.aiff' '.alac' '.flac' '.m4a' '.mp3' '.oga' '.ogg' '.wma'
	do
		if [ -z "${fname##*$music}" ]
		then
			exec beet import -q $TR_TORRENT_DIR
			exit
		fi
	done

	# check for common video file extensions
	for video in '.avi' '.m2v' '.m4p' '.m4v' '.mkv' '.mov' '.mp2' '.mp4' '.mpe' '.mpeg' '.mpg' '.mpv' '.ogv'
	do
		if [ -z "${fname##*$video}" ]
		then
			# mnamer moves, not copies, so copy before
			exec cp -RP $TR_TORRENT_DIR /tmp$TR_TORRENT_DIR
			exec mnamer -rb --no-guess --no-overwrite --config-path=/mnamer /tmp$TR_TORRENT_DIR
			exit
		fi
	done
done
exit 0
