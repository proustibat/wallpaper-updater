Wallpaper updater!
===================

Context
-------------
Computers in my office have **restricted access to wallpaper change**.

The IT department think that when they prevent people to customize their workspace, it looks professional and skilled.

Personally as a developer, I work better when I feel comfortable with my workspace.

So I decided to make some efforts to skirt this restriction.



Problem
-------------
My IT department is smart enough to disable access to the Registry Editor. That's quite normal and understandable.
I do not want to touch it. I just wanna customize my wallpapers.

> **My chance:**
>I noticed that the imposed wallpaper image was **on my machine** (in c:\Windows\).



Solution
-------------

#### Replace the image by another
The name should be the same but the content can change ☺

#### Don't change anything else
First to not attract attention and then to not create a dysfunction.
##### 1. So start by copying a backup of the original wallpaper.
> **Look at the image properties**
>In my case, it's a jpeg format.
>It has these properties : hidden file and read-only mode.

##### 2. Copy your desired wallpaper in the same folder with the name of the original.
##### 3. Give it the same properties than the original.
##### 4. Restart your computer.



Automatisation
-------------

These batch script allow you to change wallpaper just by clicking on the script. It opens a terminal with some instructions. 
You just need to change the path to your wallpapers if you want. Otherwise it will be the folder "wallpapers" beside the script. Then it will pick up one of them randomly and will refresh your desktop by restarting explorer task.

#### Change your path here in code
```
REM Define your wallpapers directory
set wpDir=%~dp0\wallpapers
```



Demo
-------------
#### After this window, a prompt will request to run as administrator, you have to accept it.
![step01](https://cloud.githubusercontent.com/assets/1054387/15070008/d24846cc-1381-11e6-9750-5c88ac54cada.jpg)

### Follow the next steps as below:
![step2](https://cloud.githubusercontent.com/assets/1054387/15070043/22874480-1382-11e6-80f6-9d64cfd209b7.jpg)

![step3](https://cloud.githubusercontent.com/assets/1054387/15070046/286f3574-1382-11e6-9cd5-4a9a13861aab.jpg)

![step4](https://cloud.githubusercontent.com/assets/1054387/15070049/2da94e80-1382-11e6-824b-1f68d4251ae0.jpg)

![step5](https://cloud.githubusercontent.com/assets/1054387/15070055/341f1e66-1382-11e6-877b-2d9ae81a3760.jpg)





