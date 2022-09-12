# Todo Front-end

This project have goes to work with todo-list between multiples users.

## 🚀 Getting Started

These instructions will allow you to get a working copy of the project on your local machine for development and testing purposes.

### 📋 Prerequisites

System requirements
The Dart SDK is supported on Windows, Linux, and macOS.

### Windows
* Supported versions: Windows 10 and 11.
* Supported architectures: x64, IA32, ARM64.
* Support for ARM64 is experimental, and is available only in the beta and dev channels.
 ### Linux
* Supported versions: Debian stable and Ubuntu LTS under standard support.
* Supported architectures: x64, IA32, ARM64, ARM, RISC-V (RV64GC).
* Support for RISC-V is experimental, and is available only in the beta and dev channels.
* Note: The arm support requires glibc 2.23 or newer due to a dynamic linker bug.

 ### macOS
* Supported versions: Latest three major versions. As of November 2021, the following versions are * supported:
* macOS 10.15 (Catalina)
* macOS 11 (Big Sur)
* macOS 12 (Monterey)
* Supported architectures: x64, ARM64.
* About release channels and ver



### 🔧 Install all environments
### Windows:

To install the Dart SDK:
```
 choco install dart-sdk
```

To upgrade the Dart SDK:
```
 choco install dart-sdk
```


By default, the SDK is installed at C:\tools\dart-sdk. You can change that location by setting the ChocolateyToolsLocation environment variable to your chosen installation directory.

If you can’t use the Dart SDK executables, add the SDK location to your PATH:

* In the Windows search box, type env.
* Click Edit the system environment variables.
* Click Environment Variables….
* In the user variable section, select Path and click Edit….
* Click New, and enter the path to the dart-sdk directory.
* In each window that you just opened, click Apply or OK to dismiss it and apply the path change.



### Linux:



If you’re using Debian/Ubuntu on AMD64 (64-bit Intel), you can choose one of the following options, both of which can update the SDK automatically when new versions are released.


* Install using apt-get
* Install a Debian package

Install using apt-get
Perform the following one-time setup:

```
sudo apt-get update

sudo apt-get install apt-transport-https

wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg

echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list

```

Then install the Dart SDK:


```
 sudo apt-get update

 sudo apt-get install dart
```

Install a Debian package
Alternatively, download Dart SDK as a Debian package in the .deb package format.

Modify PATH for access to all Dart binaries
After installing the SDK, add its bin directory to your PATH. For example, use the following command to change PATH in your active terminal session:

``` 
export PATH="$PATH:/usr/lib/dart/bin
```


To change the PATH for future terminal sessions, use a command like this:

```
 echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
```




### 🚀 RUN PROJECT !!!!

First, you need a postgresSql running on port ```5555```

you have the possible to run by docker, just start the docker composer

open folder with
```
cd backend
```

and after

```
docker-compose up
```

now we are going to start the server in debug, at some folder just run.

```
dart run bin/backend.dart
```

are you will see

```
Server Up -> http://127.0.0.1:5555
```


### Api Documentation


[Postman](https://documenter.getpostman.com/view/4907684/2s7YYpdjtL)



## ✒️ Authors

Mention all those who helped lift the project from its inception

* Luís Fernando **developer** - *Initial Work* - [GitHub](https://github.com/munhozfontana) - [Linkedin](hhttps://www.linkedin.com/in/luis-fernando-munhoz-fontana-neto-652aa88a/)


## 🎁 Expressions of Gratitude

* Tell others about this project 📢;
* Invite someone from the team for a beer 🍺;
* A public thanks 🫂;
* etc.


---
⌨️ with ❤️ by [Armstrong Lohãns](https://gist.github.com/munhozfontana) 😊