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



Quick usage
-------------

These batch script allow you to change wallpaper just by clicking on the script. It opens a terminal with some instructions. 
You just need to change the path to your wallpapers if you want. Otherwise it will be the folder "wallpapers" beside the script. Then it will pick up one of them randomly and will refresh your desktop by restarting explorer task.

#### Clone or download this repo where you want

#### Change name of the original **(required)**
```
REM Define the filename imposed by your IT department
set outputFilename=MazarineNoir_Grand.jpg
```

#### Change your path here in code **(optional)**
```
REM Define your wallpapers directory
set wpDir=%~dp0\wallpapers
```

#### Just double click on `runupwp.cm`



Demo
-------------
#### After this window, a prompt will request to run as administrator, you have to accept it.
![step1](https://cloud.githubusercontent.com/assets/1054387/15070008/d24846cc-1381-11e6-9750-5c88ac54cada.jpg)

### Follow the next steps as below:
#### The script check if it can know current wallpaper
![step2](https://cloud.githubusercontent.com/assets/1054387/15097864/50a3e8c8-152b-11e6-930f-ba2bb87ac981.jpg)
#### List all files in wallpapers folder and excludes the current from the list
![step3](https://cloud.githubusercontent.com/assets/1054387/15097865/54282aea-152b-11e6-96c3-e9901f6e9065.jpg)
#### After your confirmed by entering "Y"
![step4](https://cloud.githubusercontent.com/assets/1054387/15097866/575e3236-152b-11e6-8f06-c81b041e812c.jpg)
#### Last step: restart explorer
![step5](https://cloud.githubusercontent.com/assets/1054387/15097867/5a18d378-152b-11e6-843b-51cf0edd0a4b.jpg)





