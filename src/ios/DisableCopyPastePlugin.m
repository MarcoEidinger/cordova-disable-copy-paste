//
//  DisableCopyPastePlugin.m
//  DisableCopyPastePlugin
//
//  Created by Eidinger, Marco on 05/01/17
//
//

#import "DisableCopyPastePlugin.h"
#import <Cordova/NSDictionary+CordovaPreferences.h>

@interface DisableCopyPastePlugin()
@property (nonatomic,readwrite) BOOL clearClipboardRegistered;
@end

@implementation DisableCopyPastePlugin

- (void)pluginInitialize {
    [self _init];
}

#pragma mark -
#pragma mark public methods
#pragma mark -

- (void)start: (CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;

    BOOL started = [self _start];

    if (started) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsString:@"Started"];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:@"Already started"];
      return [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)stop: (CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;

    BOOL stopped = [self _stop];

    if (stopped) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsString:@"Stopped"];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:@"Already stopped"];
      return [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)onReset {
    [self _stop];
    [self _init];
}

#pragma mark -
#pragma mark private methods
#pragma mark -

- (void)_init {
    CDVViewController *viewController = (CDVViewController*)self.viewController;
    BOOL appStartPreference = [viewController.settings cordovaBoolSettingForKey:@"disablecopypasteonappstart" defaultValue:NO];
    if (appStartPreference || [self _doesManagedAppConfigWantsCopyPasteToBeDisabled]) {
        [self _start];
    }
}

-(void)_clearClipboard {
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:@"" forPasteboardType:UIPasteboardNameGeneral];
}

- (BOOL)_start {
    if (self.clearClipboardRegistered == YES) {
      return NO;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_clearClipboard)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    // Feature enhancement: Clear the clipboard even if the App is inactive or terminated/crashed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_clearClipboard)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_clearClipboard)
                                                 name:UIApplicationWillTerminateNotification object:nil];
    
    self.clearClipboardRegistered = YES;
    return YES;
}

- (BOOL)_stop {
    if (self.clearClipboardRegistered == NO) {
      return NO;
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.clearClipboardRegistered = NO;
    return YES;
}

-(BOOL)_doesManagedAppConfigWantsCopyPasteToBeDisabled {
    // get managed app configuration dictionary pushed down from an MDM server
    NSDictionary *mdmConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"com.apple.configuration.managed"];
    if (!mdmConfig) {
        return NO;
    }

    return mdmConfig[@"disableCopyPaste"];
}
@end
