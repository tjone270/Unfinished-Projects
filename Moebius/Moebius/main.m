//
//  main.m
//  Moebius
//
//  Created by Thomas Jones on 27/04/2015.
//  Copyright (c) 2015 TomTec Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
	return NSApplicationMain(argc, argv);
}
