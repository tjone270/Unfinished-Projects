//
//  main.m
//  Delayed Command Execution
//
//  Created by Thomas Jones on 31/12/2014.
//  Copyright (c) 2014 TomTec Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
	NSLog(@"Hello, welcome to the application!");
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
	return NSApplicationMain(argc, argv);
}
