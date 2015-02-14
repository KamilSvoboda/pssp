;TODO: 
;p�idat do screensaveru druhou ikonu pro web site link
;zjistit pro� nefunguje spou�t�n� konfigurace spo�i�e z vytvo�en�ho linku

;--------------------------------
;Includes
	!include "MUI2.nsh"
	!include "Library.nsh"
	
;--------------------------------
; The name of the installer
Name "Photo Screensaver Plus"
Caption $(instCaption)
Icon "pssp.ico"

UninstallText $(uninstCaption)
UninstallIcon "pssp.ico"

; The file to write
OutFile "PhotoScreensaverPlusSetup.exe"

; The default installation directory
InstallDir '$PROGRAMFILES\Photo Screensaver Plus'

; Request application privileges for Windows Vista - admin is required, because of writing system log source to registry (see below)
RequestExecutionLevel admin

;--------------------------------
;Interface Settings
  !define MUI_ABORTWARNING

  ;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL
  
;--------------------------------
;Pages
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES	
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages
  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Czech"

 ;Strings - must be defined after "!insertmacro MUI_LANGUAGE" lines.
 LangString selectLangCaption ${LANG_ENGLISH} "Installer Language"
 LangString selectLangCaption ${LANG_CZECH} "Jazyk instalace"
 LangString selectLangQuestion ${LANG_ENGLISH} "Please select a language."
 LangString selectLangQuestion ${LANG_CZECH} "Vyberte si pros�m jazyk:"
 LangString instCaption ${LANG_ENGLISH} "Installation of Photo Screensaver Plus"
 LangString instCaption ${LANG_CZECH} "Instalace spo�i�e Photo Screensaver Plus"
 LangString uninstCaption ${LANG_ENGLISH} "This will uninstall Photo Screensaver Plus. Hit Uninstall to continue."
 LangString uninstCaption ${LANG_CZECH} "Odinstalace Photo Screensaver Plus. Klikn�te na Odinstalovat."
 LangString sec1Title ${LANG_ENGLISH} "Photo Screensaver Plus (required)"
 LangString sec1Title ${LANG_CZECH} "Photo Screensaver Plus (vy�adov�no)"
 LangString sec2Title ${LANG_ENGLISH} "Start Menu Shortcuts"
 LangString sec2Title ${LANG_CZECH} "P�idat do nab�dky Start"
 LangString sec3Title ${LANG_ENGLISH} "Desktop Shortcut"
 LangString sec3Title ${LANG_CZECH} "P�idat odkaz na plochu"
 LangString sec4Title ${LANG_ENGLISH} "Add Folder Context Menu Command"
 LangString sec4Title ${LANG_CZECH} "P�idat p��kaz do kontextov� nab�dky adres��e"
 LangString sec1Desc ${LANG_ENGLISH} "Installs screensaver to windows system directory (typically c:\windows\system32\"
 LangString sec1Desc ${LANG_CZECH} "Nainstaluje spo�i� do syst�mov�ho adres��e windows (typicky c:\windows\system32\"
 LangString sec2Desc ${LANG_ENGLISH} "Creates start menu shortcuts to screensaver, web site etc. for all PC users"
 LangString sec2Desc ${LANG_CZECH} "Vytvo�� pro v�echny u�ivatele po��ta�e polo�ku v nab�dce Start a p�id� do n� odkazy na spu�t�n� spo�i�e, na jeho domovskou str�nku atd."	
 LangString sec3Desc ${LANG_ENGLISH} "Creates desktop shortcut to run screensaver for all PC users"
 LangString sec3Desc ${LANG_CZECH} "Vytvo�� pro v�echny u�ivatele po��ta�e odkaz na plo�e pro spu�t�n� spo�i�e"
 LangString sec4Desc ${LANG_ENGLISH} "Adds a context menu command in the directory that starts a slideshow of pictures within the directory"
 LangString sec4Desc ${LANG_CZECH} "P�id� p��kaz do kontextov� nab�dky adres��e, kter� spust� prezentaci obr�zk� uvnit� adres��e"
 LangString folderCommand ${LANG_ENGLISH} "Slide show with Photo Screensaver Plus"
 LangString folderCommand ${LANG_CZECH} "Prezentace obr�zk� s Photo Screensaver Plus"
 LangString shortcutDesc1 ${LANG_ENGLISH} "Uninstall screensaver"
 LangString shortcutDesc1 ${LANG_CZECH} "Odinstaluje spo�i�"
 LangString shortcutDesc2 ${LANG_ENGLISH} "Run screensaver manually"
 LangString shortcutDesc2 ${LANG_CZECH} "Spust� ru�n� spo�i�"
 LangString shortcutDesc3 ${LANG_ENGLISH}  "Configuration of the screensaver"
 LangString shortcutDesc3 ${LANG_CZECH} "Spust� konfiguraci spo�i�e" 
 LangString shortcutDesc4 ${LANG_ENGLISH}  "Link to screensaver web site"
 LangString shortcutDesc4 ${LANG_CZECH} "Odkaz na webovou str�nku spo�i�e" 
 LangString setAsDefaultQuestion ${LANG_ENGLISH} "Do you wish set the screensaver as your default and run its configuration?"
 LangString setAsDefaultQuestion ${LANG_CZECH} "P�ejete si nastavit Photo Screensaver Plus jako aktu�ln� spo�i� a otev��t jeho nastaven�?"
	
;--------------------------------
;Initialization of installlation
Function .onInit
	!insertmacro MUI_DEFAULT MUI_LANGDLL_WINDOWTITLE $(selectLangCaption)
	!insertmacro MUI_DEFAULT MUI_LANGDLL_INFO $(selectLangQuestion)
	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;--------------------------------
; The stuff to install
Section $(sec1Title) "Pssp"

  SectionIn RO
  
  ;Set output path to the system directory (windows\system32)
  SetOutPath $SYSDIR 
  ;Put file there
  File "PhotoScreensaverPlus.scr"
      
  ;Set output path to the installation directory.
  SetOutPath $INSTDIR
  ;Put files there
  File "website.url"  
  File "NLog.dll"
  File "PsspInstallUtils.exe"
  
  ;register DLLs
  nsExec::Exec '"$INSTDIR\PsspInstallUtils.exe" i "$INSTDIR"'
        
  CreateShortCut "$INSTDIR\Photo Screensaver Plus.lnk" "$SYSDIR\PhotoScreensaverPlus.scr" "" "$SYSDIR\PhotoScreensaverPlus.scr" 0
  
  ;delete previous event log source
  DeleteRegKey HKLM "SYSTEM\CurrentControlSet\Services\EventLog\Application\Photo Screensaver Plus"
    
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus" "DisplayName" "Photo Screensaver Plus"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus" "Publisher" "Kamil Svoboda"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus" "DisplayIcon" "$SYSDIR\PhotoScreensaverPlus.scr,0"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section $(sec2Title) StartMenuSchortcuts
  
  ;sets the shortcuts are for all users - must be in every section
  SetShellVarContext All
  CreateDirectory "$SMPROGRAMS\Photo Screensaver Plus"
  CreateShortCut "$SMPROGRAMS\Photo Screensaver Plus\Uninstall Photo Screensaver Plus.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0 "" "" $(shortcutDesc1)
  CreateShortCut "$SMPROGRAMS\Photo Screensaver Plus\Photo Screensaver Plus.lnk" "$SYSDIR\PhotoScreensaverPlus.scr" "" "$SYSDIR\PhotoScreensaverPlus.scr" 0 "" "" $(shortcutDesc2)
  ;CreateShortCut "$SMPROGRAMS\Photo Screensaver Plus\Photo Screensaver Plus Configuration.lnk" "$SYSDIR\PhotoScreensaverPlus.scr" "/c" "$SYSDIR\PhotoScreensaverPlus.scr" 0 "" "" $(shortcutDesc3)
  CreateShortCut "$SMPROGRAMS\Photo Screensaver Plus\Photo Screensaver Plus Web Site.lnk" "$INSTDIR\website.url" "" "$PROGRAMFILES\Internet Explorer\iexplore.exe" 0 "" "" $(shortcutDesc4)
  
SectionEnd

; Optional section (can be disabled by the user)
Section $(sec3Title) DescktopShortcut
  ;sets the shortcuts are for all users - must be in every section
  SetShellVarContext All
  CreateShortCut "$DESKTOP\Photo Screensaver Plus.lnk" "$SYSDIR\PhotoScreensaverPlus.scr"
  
SectionEnd

; Optional section (can be disabled by the user)
Section $(sec4Title) FolderContextMenuCommand
  ;adds command to the directory context menu (mouse right click)
  SetShellVarContext All
  WriteRegStr HKCR "Directory\shell\PhotoScreensaverPlus" "" $(folderCommand)
  WriteRegStr HKCR "Directory\shell\PhotoScreensaverPlus\command" "" '"$SYSDIR\PhotoScreensaverPlus.scr" /f "%1"'
SectionEnd

Section -LogSourceInstaller ;zavol� vytvo�en� log source v registrech windows
	;write registry entry for system log source - needed for screensaver logging
	;WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Services\EventLog\Application\Photo Screensaver Plus" "EventMessageFile" "$SYSDIR\PhotoScreensaverPlus.scr"
  
	nsexec::exectolog '"$SYSDIR\PhotoScreensaverPlus.scr" /l'
SectionEnd

Section -SetAsUserDefault ;kdy� m� sekce p�ed identifik�torem "-" tak se spust� a� po dokon�en� v�ech p�edchoz�ch (nakop�rov�n� soubor�)
  MessageBox MB_YESNO $(setAsDefaultQuestion) IDYES Configure IDNO End
  Configure: 
	GetFullPathName /SHORT $R9 "$SYSDIR\PhotoScreensaverPlus.scr" 
	;MessageBox MB_OK $R9
	WriteRegStr HKCU "Control Panel\Desktop" "SCRNSAVE.EXE" $R9
	nsexec::exectolog '"$SYSDIR\PhotoScreensaverPlus.scr" /c'
  End:
SectionEnd

;--------------------------------
; Uninstaller
Section "Uninstall"
  ;sets the shortcuts are for all users - must be in every section
  SetShellVarContext All
  
  ;unregister DLLs
  nsexec::Exec '"$INSTDIR\PsspInstallUtils.exe" u "$INSTDIR"'
  
  ; Remove registry keys - settings  are not removed from registry
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PhotoScreensaverPlus"
  
  DeleteRegKey HKCR "Directory\shell\PhotoScreensaverPlus"
  
  ; Remove files and uninstaller
  Delete $SYSDIR\PhotoScreensaverPlus.scr
  Delete "$INSTDIR\Photo Screensaver Plus.lnk"
  Delete $INSTDIR\website.url
  Delete $INSTDIR\NLog.dll
  Delete $INSTDIR\PsspInstallUtils.exe
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\Photo Screensaver Plus\*.*"
  Delete "$DESKTOP\Photo Screensaver Plus.lnk"
  
  ; Remove directories used
  RMDir "$SMPROGRAMS\Photo Screensaver Plus"
  RMDir "$INSTDIR"

SectionEnd

;--------------------------------
;Descriptions
  ;Assign descriptions to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Pssp} $(sec1Desc)
    !insertmacro MUI_DESCRIPTION_TEXT ${StartMenuSchortcuts} $(sec2Desc)
	!insertmacro MUI_DESCRIPTION_TEXT ${DescktopShortcut} $(sec3Desc)
	!insertmacro MUI_DESCRIPTION_TEXT ${FolderContextMenuCommand} $(sec4Desc)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END