--------------------------------
DaisyWorks User Interface App repository
--------------------------------
This is the repo for various UI Modules for the Daisy.  The Daisy is an Arduino-derivative board that includes:

a) Class 1 Bluetooth Modem
b) SD Card
c) IrDA
d) 3 RJ25, and 1 RJ45 jacks that allow you to easily swap out various sensors and controls (e.g. light, moisture, temp, etc.)
e) Servo control ports

The Daisy uses the Atmel ATMEGA328 microcontroller.  It is compatible with the Arduino, which means you can use Arduino libraries to build firmware for the Daisy (in fact, we do).  It als has the Arduino stk500 bootloader, and we've built software that allows you to do Firmware-Over-The-Air (FOTA) to reprogram the Daisy using Bluetooth from your Android phone or Desktop Computer (Mac / Windows / Linux).

We've also built an App Store that allows you to quickly browse applications that are custom made for the various sensors / controls we sell for the Daisy.  To find out more information, check our website:

http://daisyworks.com

This repository has all the source code we are using in our sample user interface applications.  Instructions are on the website and simple instructions are provided below on how to get started.  Each of these apps is a Flex Module that can be dynamically loaded into our Air Desktop application and communicate with the embedded firmware running on a Daisy.

Developing an Application means you develop a short piece of Arduino firmware that runs on the device and does interesting things with sensors / controls -- and then you build a small user-interface component in Flex that allows you to interact with the device real-time.

-------------------------
| License
_________________________

All the code in this repository is public domain which means you are free to modify it to your heart's content.   If we use libraries created by others, we credit them in the README and provide a link to the original source.  If we use code that has an open source license attached to it, we'll include a copy of the license and credit.

-------------------------
| Pre-requisites
------------------------- 

You need all the stuff below before you try to begin:

  # jdk 6 
	http://java.oracle.com

  # ant 1.7 or better
	http://ant.apache.org

  # Flex 4.5.* SDK (you need at least 4.5.0.20967 or better)
	http://fpdownload.adobe.com/pub/flex/sdk/builds/flex4.5/flex_sdk_4.5.0.20967.zip
	
Download the package and unzip it somewhere.  You'll need to modify the ant script to point here.

-------------------------
| Build
-------------------------
Step into this directory and:

$ cp build.properties.sample build.properties

Now, edit build.properties for your environment...you need to tell it where the Flex SDK lives.  Just run Ant to build it.  Each UI app is built as a separate SWF file.  This file can then be loaded directly into the Daisy Desktop software http://daisyworks.com/downloads.html#desktop

$ ant

-------------------------
| Libraries
-------------------------
There are two required .swc libraries here.  One is the Swiz Framework http://swizframework.org

/libs/swiz-framework.swc

 and the other is a simple library that defines the definition of the Event that is exchanged between your software and the desktop container

/libs/daisyworks-desktop-sdk.swc

--------------------------
| FlashBuilder (OPTIONAL)
--------------------------

You can build this in FlashBuilder http://www.adobe.com/products/flash-builder.html simply by importing the whole project.  FlashBuilder is not free but you can get a free trial version.  It is not required to build the software -- all you need are Ant, Java, and the Flex SDK -- but it sure does make it easier when you're coding up MXML.  

--------------------------
| Runtime Shared Libraries (RSLs)
--------------------------

I really did try to get this to work, but ran into all kinds of runtime errors when I loaded the modules.  I tried a whole slew of different settings to compile the modules to use RSL for framework, etc., but it just wasn't working.  I'd welcome anyone who wants to try -- sure would get our SWF sizes down.
