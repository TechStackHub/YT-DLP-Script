@echo off
title Quick YouTube Downloader
color 0B
cls

echo ==========================================
echo        Quick YouTube Downloader
echo           Created by TechStackHub
echo ==========================================
echo.

REM Check if yt-dlp exists
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo yt-dlp not found! Installing...
    pip install yt-dlp
    if %errorlevel% neq 0 (
        echo Failed to install yt-dlp. Please install manually.
        pause
        exit
    )
)

:download
echo.
echo Paste YouTube URL and press Enter:
set /p url=

if "%url%"=="" (
    echo No URL entered. Exiting...
    timeout /t 2 >nul
    exit
)

echo.
echo Downloading...
echo ==========================================

REM Download with best quality to script directory
yt-dlp -o "%%(title)s.%%(ext)s" "%url%"

if %errorlevel% equ 0 (
    echo.
    echo ==========================================
    echo Download Complete!
    echo Saved to: %~dp0
    echo ==========================================
) else (
    echo.
    echo Download failed! Check the URL and try again.
)

echo.
set /p again=Download another? (y/n): 
if /i "%again%"=="y" goto download

echo.
echo Goodbye!
timeout /t 2 >nul