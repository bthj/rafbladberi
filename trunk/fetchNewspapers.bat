echo on 

SET MOGGINN_NOTANDANAFN=
SET MOGGINN_LYKILORD=


@REM DATE/T skilar dagsetningu eins og lau. 23.02.2008 - dagsetning lesin inn � vi�eigandi breytur:
FOR /F "TOKENS=1* DELIMS=. " %%i IN ('DATE/T') DO SET CDATE=%%j
FOR /F "TOKENS=1 DELIMS=. " %%i IN ('echo %CDATE%') DO SET DAGS=%%i
FOR /F "TOKENS=2 DELIMS=. " %%i IN ('echo %CDATE%') DO SET MAN=%%i
FOR /F "TOKENS=3 DELIMS=. " %%i IN ('echo %CDATE%') DO SET AR=%%i
SET AR_SHORT=%AR:~2%


SET WGET_COMMAND="C:\Program Files\GnuWin32\bin\wget.exe" --tries=12 --waitretry=300

SET BASE_FOLDER=C:\blod\
IF NOT EXIST %BASE_FOLDER% MD %BASE_FOLDER%

IF %MOGGINN_NOTANDANAFN%'==' IF %MOGGINN_LYKILORD%'==' (GOTO FRETTABLADID) ELSE (GOTO MOGGINN)

:MOGGINN
SET MBL_FOLDER=%BASE_FOLDER%mogginn\
IF NOT EXIST %MBL_FOLDER% MD %MBL_FOLDER%

SET MBL_BASE_URL=http://www.mbl.is/mm/mogginn/blad_dagsins/pdf//%AR%-%MAN%-%DAGS%/
SET MBL_TODAYS_FILE_A=A%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_B=B%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_C=C%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_D=D%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_E=E%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_F=F%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_G=G%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_H=H%AR%-%MAN%-%DAGS%.pdf
SET MBL_TODAYS_FILE_I=I%AR%-%MAN%-%DAGS%.pdf

CD %MBL_FOLDER%

SET MBL_COOKIE_OPTIONS=--cookies=on --keep-session-cookies --save-cookies=%MBL_FOLDER%mblcookies.txt
SET MBL_COOKIE_DNL_OPTIONS=%MBL_COOKIE_OPTIONS% --load-cookies=%MBL_FOLDER%mblcookies.txt --referer=http://www.mbl.is/mm/mogginn/blad_dagsins/vikan_pdf.html

%WGET_COMMAND% %MBL_COOKIE_OPTIONS% --post-data="act=login&referer=%2Fmm%2Fmogginn%2Fblad_dagsins%2Fvikan_pdf.html&identifier=%MOGGINN_NOTANDANAFN%&password=%MOGGINN_LYKILORD%" --output-document - http://www.mbl.is/mm/mogginn/blad_dagsins/askr_login.html > NUL

%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_A%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_B%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_C%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_D%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_E%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_F%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_G%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_H%
%WGET_COMMAND% %MBL_COOKIE_DNL_OPTIONS% %MBL_BASE_URL%%MBL_TODAYS_FILE_I%

IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_A% START %MBL_FOLDER%%MBL_TODAYS_FILE_A%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_B% START %MBL_FOLDER%%MBL_TODAYS_FILE_B%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_C% START %MBL_FOLDER%%MBL_TODAYS_FILE_C%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_D% START %MBL_FOLDER%%MBL_TODAYS_FILE_D%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_E% START %MBL_FOLDER%%MBL_TODAYS_FILE_E%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_F% START %MBL_FOLDER%%MBL_TODAYS_FILE_F%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_G% START %MBL_FOLDER%%MBL_TODAYS_FILE_G%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_H% START %MBL_FOLDER%%MBL_TODAYS_FILE_H%
IF EXIST %MBL_FOLDER%%MBL_TODAYS_FILE_I% START %MBL_FOLDER%%MBL_TODAYS_FILE_I%
:END

:FRETTABLADID
SET FRETTABLADID_FOLDER=%BASE_FOLDER%frettabladid\
IF NOT EXIST %FRETTABLADID_FOLDER% MD %FRETTABLADID_FOLDER%
SET FRETTABLADID_BASE_URL=http://www.visir.is/ExternalData/pdf/fbl/
SET FRETTABLADID_TODAYS_FILE=%AR_SHORT%%MAN%%DAGS%.pdf

CD %FRETTABLADID_FOLDER%
%WGET_COMMAND% %FRETTABLADID_BASE_URL%%FRETTABLADID_TODAYS_FILE%

IF EXIST %FRETTABLADID_FOLDER%%FRETTABLADID_TODAYS_FILE% START %FRETTABLADID_FOLDER%%FRETTABLADID_TODAYS_FILE%
:END
