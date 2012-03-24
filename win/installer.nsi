!include MUI2.nsh

!define QT_PATH "C:\Qt\32bit-stable\bin"
!define LIBAV_PATH "C:\Users\Administrator\Development\libav\bin"

Name "Bluecherry Client"
OutFile "SetupBluecherryClient.exe"
InstallDir "$PROGRAMFILES\Bluecherry Client"
InstallDirRegKey HKLM "Software\Bluecherry Client" ""
RequestExecutionLevel admin
SetCompressor /FINAL /SOLID lzma
!define MUI_ICON "..\res\bluecherry.ico"
!define MUI_UNICON "..\res\bluecherry.ico"

!insertmacro MUI_PAGE_WELCOME
#!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN $INSTDIR\BluecherryClient.exe
!define MUI_FINISHPAGE_RUN_TEXT "Run Bluecherry Client"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

Section
        SetOutPath "$INSTDIR"
        SetShellVarContext all
        
        File "BluecherryClient.exe"
        File "..\gstreamer-bin\win\bin\*.*"
        File /r "..\gstreamer-bin\win\plugins"
        File "${QT_PATH}\QtCore4.dll"
        File "${QT_PATH}\QtGui4.dll"
        File "${QT_PATH}\QtNetwork4.dll"
        File "${QT_PATH}\QtWebkit4.dll"
        File "${QT_PATH}\QtOpenGL4.dll"
        File "${QT_PATH}\QtDeclarative4.dll"
        File "${QT_PATH}\QtScript4.dll"
        File "${QT_PATH}\QtSql4.dll" # required by QtDeclarative
        File "${QT_PATH}\QtXmlPatterns4.dll" # QtDeclarative
        File "${QT_PATH}\phonon4.dll"
        File "${QT_PATH}\ssleay32.dll"
        File "${QT_PATH}\libeay32.dll"
	File "${LIBAV_PATH}\avcodec-54.dll"
	File "${LIBAV_PATH}\avformat-54.dll"
	File "${LIBAV_PATH}\avutil-51.dll"
	File "${LIBAV_PATH}\swscale-2.dll"
        
        # MSVC 2010 CRT
        File "msvcp100.dll"
        File "msvcr100.dll"
        
        SetOutPath "$INSTDIR\imageformats"
        File "${QT_PATH}\..\plugins\imageformats\qjpeg4.dll"
        File "${QT_PATH}\..\plugins\imageformats\qgif4.dll"
        
        CreateDirectory "$SMPROGRAMS\Bluecherry"
        CreateShortCut "$SMPROGRAMS\Bluecherry\Bluecherry Client.lnk" "$INSTDIR\BluecherryClient.exe"
        
        WriteRegStr HKLM "Software\Bluecherry Client" "" $INSTDIR
        WriteUninstaller "$INSTDIR\Uninstall.exe"
        WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Bluecherry Client" \
                    "DisplayName" "Bluecherry DVR Client"
        WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Bluecherry Client" \
                    "UninstallString" "$\"$INSTDIR\Uninstall.exe$\""
        WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Bluecherry Client" \
                    "Publisher" "Bluecherry"
        WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Bluecherry Client" \
                    "HelpLink" "http://support.bluecherrydvr.com"
        WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Bluecherry Client" \
                    "URLInfoAbout" "http://www.bluecherrydvr.com"
SectionEnd

Section "Uninstall"
        SetShellVarContext all
        Delete "$INSTDIR\Uninstall.exe"
        RMDir /r "$INSTDIR"
        RMDir /r "$SMPROGRAMS\Bluecherry"
        DeleteRegKey HKLM "Software\Bluecherry Client"
        DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Bluecherry Client"
SectionEnd