set TEAM=%1
set TEAMN=%2

call add_capture.bat "チーズバーガー vs %TEAMN%" movie/%TEAM%-cheese.mp4 01.mp4
call add_capture.bat "てりやきバーガー vs %TEAMN%" movie/%TEAM%-teriyaki.mp4 02.mp4
call add_capture.bat "クラブハウス vs %TEAMN%" movie/%TEAM%-clubhouse.mp4 03.mp4

ffmpeg -safe 0 -f concat -i movies.txt -c:v copy -c:a copy -c:s copy -map 0:v %TEAM%.mp4

del 01.mp4
del 02.mp4
del 03.mp4