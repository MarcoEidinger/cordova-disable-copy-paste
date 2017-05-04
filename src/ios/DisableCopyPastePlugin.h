//
//  DisableCopyPastePlugin.h
//  DisableCopyPastePlugin
//
//  Created by Eidinger, Marco on 05/01/17
//
//

#import <Cordova/CDV.h>

@interface DisableCopyPastePlugin : CDVPlugin

- (void)start: (CDVInvokedUrlCommand*)command;
- (void)stop: (CDVInvokedUrlCommand*)command;

@end
