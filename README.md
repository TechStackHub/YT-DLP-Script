---

## **README.md**

# yt-dlp Quick Downloader Scripts

Simple one-click batch scripts for downloading YouTube videos using **yt-dlp** and **FFmpeg**.

This repository includes two Windows `.bat` files that make video downloading fast and effortless. Instead of typing long commands, just double-click, paste your link, and the script handles everything automatically.

---

## 🚀 Features

* One-click video download
* Automatically selects best available quality
* Merges video + audio using FFmpeg
* Fast mode and custom mode included
* Works with YouTube and many other supported sites
* No complicated commands required

---

## 📂 Included Files

**1. custom_downloader.bat**
Prompts you to paste a link and downloads the best-quality video using customized parameters.

**2. quick_downloader.bat**
Instant download with default settings. Paste URL → Download starts immediately.

---

## 🔧 Requirements

Make sure you have the following installed and added to your PATH:

* **yt-dlp**
* **FFmpeg**

Download links

* yt-dlp: [https://github.com/yt-dlp/yt-dlp/releases](https://github.com/yt-dlp/yt-dlp/releases)
* FFmpeg: [https://github.com/BtbN/FFmpeg-Builds/releases]([https://www.gyan.dev/ffmpeg/builds/](https://github.com/BtbN/FFmpeg-Builds/releases)

After downloading, place `yt-dlp.exe` and the `.bat` files in the same folder or add that folder to your Windows PATH.

---

## 📘 How to Use

1. Download this repo
2. Extract files
3. Double-click any script
4. Paste your video URL
5. Press Enter
6. Done ✔️

A sample screenshot is included for reference.

---

## 🔥 Bonus Commands

If you prefer running yt-dlp manually:

**Download MP3:**

```
yt-dlp -x --audio-format mp3 URL
```

**Download best video quality:**

```
yt-dlp -f "bestvideo+bestaudio" URL
```

**Download subtitles:**

```
yt-dlp --write-subs URL
```

---

## 🎯 Why This Exists

I made these scripts to speed up my own workflow and decided to share them so beginners and power users can download videos without typing commands again and again.

---

## 📺 Video Tutorial

Watch the full tutorial on TechStackHub (link added soon).

---

## 📝 License

This project is open source and free for anyone to modify and use.

---
