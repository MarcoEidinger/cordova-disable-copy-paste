|Travis CI|
|:-:|
|[![Build Status](https://travis-ci.org/MarcoEidinger/cordova-disable-copy-paste.svg?branch=master)](https://travis-ci.org/MarcoEidinger/cordova-disable-copy-paste)|

## Overview
This Cordova Plugin is iOS-specific which enables you to prevent copy-paste to other applications by clearing clipboard when entering background, is inactive or app crashed.

Three major use case are supported:
* disable Copy-Paste to other applications **automatically** (default: off)
* disable Copy-Paste to other applications **on demand**
* disable Copy-Paste to other applications [**on request of EMM solution**](#EMM)

This plugin does not prohibit copy & paste within the application itself!

## Installation

```bash
cordova plugin add https://github.com/MarcoEidinger/cordova-disable-copy-paste.git
```

 To disable Copy-Paste automatically on app start please add the following to your `config.xml`:

```xml
<preference name="DisableCopyPasteOnAppStart" value="true"/>
```

Default is false.


## Usage
This plugin defines a global `window.cordova.plugins.disableCopyPaste` object which exposes functions to start or stop the disablement of Copy-Paste **on demand**

## Javascript API

### start

```javascript
window.cordova.plugins.disableCopyPaste.start(function(){
    // success callback (optional): clipboard gets cleared when app enters background
}, function(sError) {
    // error callback (optional): most likely the plugin already started to disable CopyPaste to other applications
});
```

### stop

```javascript
window.cordova.plugins.disableCopyPaste.stop(function(){
    // success callback (optional): clipboard does no longer get cleared when app enters background
}, function(sError) {
    // error callback (optional): most likely the plugin already stopped to disable CopyPaste to other applications
});
```

## EMM support and consideration<a name="EMM"></a>

The plugin is developed with [iOS Managed Configuration](https://www.appconfig.org/ios/) capabilities built in and therefore customers using a Enterprise Mobility Management (EMM) solution can specify if copy-paste shall be disabled or not.

Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>disableCopyPaste</key>
		<true/>
	</dict>
</plist>
```

P.S.: for Android use an Android for Work / Android 5.0+ managed profile to containerize copy and pasting to only managed applications. No development required. Reference: https://www.appconfig.org/android/
