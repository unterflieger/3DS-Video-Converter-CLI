@echo off
echo

if not exist ffmpeg-master-latest-win64-gpl.zip goto downloadffmpeg
goto start

:downloadffmpeg
echo FFmpeg was not found. Download it automatically? If not, the program is not going to work as expected.
set /p ffmpegdown="[yes;no]"
echo Downloading FFmpeg...
curl -L --remote-name --url https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip
echo Done!
echo Unpacking FFmpeg...
tar -x -f ffmpeg-master-latest-win64-gpl.zip
echo Done!
break

:start
set /p srcfile="Drag and Drop Source file into this Window: "
set /p desfile="Please enter the destination location: "
set /p opt="Which cameras do you want to extract the videos from? [left;right;both]: "

if "%opt%"=="left" goto left
if "%opt%"=="right" goto right
if "%opt%"=="both" goto both

goto error

:left
%cd%\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -i %srcfile% -map 0:0 -map 0:1 -vcodec copy -acodec copy left%desfile%
goto done

:right
%cd%\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -i %srcfile% -map 0:2 -vcodec copy -acodec copy -an right%desfile%
goto done

:both
%cd%\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -i %srcfile% -map 0:0 -map 0:1 -vcodec copy -acodec copy left%desfile%
%cd%\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe -i %srcfile% -map 0:2 -vcodec copy -acodec copy -an right%desfile%
goto done

:error
echo Wrong input. Please try again.
goto start




:done
echo Video(s) have been extracted.
pause