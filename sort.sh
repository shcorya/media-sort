#!/bin/sh
OUTFILE="/var/tmp/sort.log"
exec 1>>$OUTFILE 2>&1
echo "Checking torrent at '$TR_TORRENT_DIR/$TR_TORRENT_NAME'..."
for fname in $(find "$TR_TORRENT_DIR/$TR_TORRENT_NAME")
do
	# check for common music file extensions
	for music in '.aac' '.aiff' '.alac' '.flac' '.m4a' '.mp3' '.oga' '.ogg' '.wma'
	do
		if [ -z "${fname##*$music}" ]
		then
			echo "Found audio file in $TR_TORRENT_NAME."
			exec beet import -q "$TR_TORRENT_DIR/$TR_TORRENT_NAME"
			exit
		fi
	done

	# check for common video file extensions
	for video in '.avi' '.m2v' '.m4p' '.m4v' '.mkv' '.mov' '.mp2' '.mp4' '.mpe' '.mpeg' '.mpg' '.mpv' '.ogv'
	do
		if [ -z "${fname##*$video}" ]
		then
			# mnamer moves, not copies, so copy before
			echo "Found video file in $TR_TORRENT_NAME."
			exec cp -RP "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "/tmp/$TR_TORRENT_NAME"
			exec mnamer -rbv --no-guess --no-overwrite --no-style --config-path=/mnamer/mnamer-v2.json "/tmp/$TR_TORRENT_NAME"
			exit
		fi
	done
done
exit 0
