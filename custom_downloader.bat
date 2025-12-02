@echo off
title YouTube Video Downloader
color 0A
echo.
echo ====================================
echo    YouTube Video Downloader v1.0
echo         Created by TechStackHub
echo ====================================
echo.

REM Check if yt-dlp is installed
yt-dlp --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] yt-dlp is not installed or not in PATH!
    echo.
    echo Please download yt-dlp.exe from: https://github.com/yt-dlp/yt-dlp/releases
    echo and add it to your system PATH or place it in this folder.
    echo.
    pause
    exit /b 1
)

REM Check if ffmpeg is installed
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] ffmpeg is not installed or not in PATH!
    echo.
    echo For best quality downloads, you need ffmpeg to merge video and audio.
    echo Download from: https://github.com/BtbN/FFmpeg-Builds/releases
    echo.
    echo The script will continue but may download separate video/audio files.
    echo.
    timeout /t 5 >nul
)

:main
echo.
echo Enter YouTube URL (or 'quit' to exit):
set /p "url=URL: "

REM Check if user wants to quit
if /i "%url%"=="quit" (
    echo Goodbye!
    timeout /t 2 >nul
    exit /b 0
)

REM Check if URL is empty
if "%url%"=="" (
    echo [ERROR] Please enter a valid URL!
    goto main
)

REM Validate if it's a YouTube URL
echo %url% | findstr /i "youtube.com youtu.be" >nul
if %errorlevel% neq 0 (
    echo [WARNING] This doesn't appear to be a YouTube URL.
    set /p "continue=Do you want to continue anyway? (y/n): "
    if /i not "%continue%"=="y" goto main
)

echo.
echo ====================================
echo           Download Options
echo ====================================
echo 1. Best Quality (Default)
echo 2. 720p Maximum
echo 3. 480p Maximum  
echo 4. Audio Only (MP3)
echo 5. Custom Format
echo.
set /p "choice=Choose option (1-5, Enter for default): "

REM Set download format based on choice
if "%choice%"=="" set "format=bestvideo+bestaudio/best"
if "%choice%"=="1" set "format=bestvideo+bestaudio/best"
if "%choice%"=="2" set "format=bestvideo[height<=720]+bestaudio/best[height<=720]"
if "%choice%"=="3" set "format=bestvideo[height<=480]+bestaudio/best[height<=480]"
if "%choice%"=="4" (
    set "format=bestaudio"
    set "audio_only=true"
)
if "%choice%"=="5" (
    echo.
    echo Enter custom format e.g., bestvideo[height<=1080]+bestaudio:
    set /p "format=Format: "
)

echo.
echo ====================================
echo        Download Location
echo ====================================
echo Current folder: %cd%
echo.
echo 1. Download to current folder
echo 2. Download to Downloads folder
echo 3. Choose custom folder
echo.
set /p "location=Choose location (1-3, Enter for current): "

REM Set download path
set "download_path=%cd%"
if "%location%"=="2" (
    set "download_path=%USERPROFILE%\Downloads"
)
if "%location%"=="3" (
    echo.
    echo Enter full path e.g., C:\Videos:
    set /p "download_path=Path: "
)

REM Create download directory if it doesn't exist
if not exist "%download_path%" (
    mkdir "%download_path%" 2>nul
    if %errorlevel% neq 0 (
        echo [ERROR] Cannot create directory: %download_path%
        echo Using current directory instead.
        set "download_path=%cd%"
    )
)

echo.
echo ====================================
echo         Starting Download
echo ====================================
echo URL: %url%
echo Format: %format%
echo Location: %download_path%
echo.

REM Change to download directory
pushd "%download_path%"

REM Build and execute yt-dlp command
if "%audio_only%"=="true" (
    echo Downloading audio only...
    yt-dlp -f "%format%" --extract-audio --audio-format mp3 --audio-quality 0 --extractor-args "youtube:player_client=android_creator" -o "%%(title)s.%%(ext)s" "%url%"
) else (
    echo Downloading video...
    yt-dlp -f "%format%" --extractor-args "youtube:player_client=android_creator" --merge-output-format mp4 -o "%%(title)s.%%(ext)s" "%url%"
)

REM Check if download was successful
if %errorlevel% equ 0 (
    echo.
    echo ====================================
    echo       Download Completed!
    echo ====================================
    echo File saved to: %download_path%
    echo.
    
    REM Ask if user wants to open the folder
    set /p "open_folder=Open download folder? (y/n): "
    if /i "%open_folder%"=="y" explorer "%download_path%"
    
) else (
    echo.
    echo ====================================
    echo        Download Failed!
    echo ====================================
    echo Please check the URL and try again.
    echo.
)

REM Return to original directory
popd

echo.
echo ====================================
set /p "again=Download another video? (y/n): "
if /i "%again%"=="y" (
    cls
    goto main
)

echo.
echo Thank you for using YouTube Downloader!
timeout /t 3 >nul
exit /b 0