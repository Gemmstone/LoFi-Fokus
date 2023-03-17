# LoFi-Fokus
------
A Bash script for the KDE widget, [Fokus](https://store.kde.org/p/1308861), to listen to youtube Lo-Fi while working. it does this by playing a YouTube video. It uses the yt-dlp program to download the video's audio and play it in mplayer.


> As someone with ADHD, I struggle with focus during work sessions. I discovered "Fokus", a pomodoro timer widget, which has been a helpful tool to manage my work sessions and breaks. However, I still find it difficult to concentrate, i know that music helps me too so i decided to combine both.

> To help with this, I decided to make this script to be able to play random LoFi videos during my breaks when in "focus" mode. I find that background noise, such as music or white noise, can help me concentrate and filter out distractions. LoFi videos, in particular, are known for their relaxing and calming background music, which creates a peaceful and focused environment.

> This helps me to relax while I work, and ultimately supports my productivity and mental health. By integrating this script with the Fokus widget, I have created a streamlined and effective workflow that (I hope) works for me.
 

> **DISCLAIMER:** While the my script, LoFi videos and pomodoro timers may be helpful tools for some individuals with ADHD, it is important to note that ADHD is a complex disorder and requires a multifaceted treatment approach. None of these should not be considered a substitute for medical advice or therapy.


### Dependencies
------
##### Debian/Ubuntu
```bash
sudo apt-get install yt-dlp notify-send mplayer
```
##### Arch Linux
```bash
sudo pacman -S yt-dlp notify-send mplayer
```

### Clone
------
```bash 
git clone https://github.com/Gemmstone/LoFi-Fokus.git
```

### Setup
------
* Edit the contents of **[duration.txt](duration.txt)** file to the focus time you prefer (25min by default), remember to also set up the same focus time in **Fokus**
* **OPTIONAL:** Add the YouTube urls you want into **[urls.txt](urls.txt)**, they have to be the same or longer than the time you've chosen before, there's a couple of urls by default, one of the urls will be chosen at random every run.

### Add permisions
------
```bash
sudo chmod +x run.sh
sudo chmod +x stop.sh
```

### Usage
------
* Add the file **[run.sh](run.sh)** to Fokus in 
  * Start focus
  * End Break
* Add the file **[stop.sh](stop.sh)** to Fokus in
  * Start Break
  * End focus
  * Stop

### Run
------
* Just start your pomodoro timer with Fokus and it should start playing! 
  * _It might take some time to run the first time while it downloads the mp3 files!_
* It'll stop once the time is over and your break has started.

## Contributing
------
Contributions are welcome! If you find a bug or have a feature request, please open an issue on the GitHub repository. If you want to contribute code, please fork the repository, create a branch for your changes, and submit a pull request. 

## License
------
The LoFi-Fokus Script is released under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
