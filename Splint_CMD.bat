subst m: "D:\Test\ASUS_TSUMV_20170217_1530\Project\OSD\Dynamic Font"
subst n: "D:\Test\ASUS_TSUMV_20170217_1530\Project\OSD\Splendid Demo OSD"
splint -f splint_8051.rc ./UI/AOC/Keypad.c > splintout.txt 2>&1
splint -f splint_8051.rc ./UI/AOC/msOSD.c > temp.txt 2>&1
copy splintout.txt + temp.txt splintout.txt
splint -f splint_8051.rc ./UI/AOC/menu.c > temp.txt 2>&1
copy splintout.txt + temp.txt splintout.txt

subst m: /d
subst n: /d
