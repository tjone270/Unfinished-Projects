--
--  AppDelegate.applescript
--  Debug Menu Activator
--
--  Created by Thomas Jones on 24/01/2014.
--  Copyright (c) 2014 TomTec Solutions. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	property title : "Debug Menu Activator"
	
	property diskUtility : "false"
	property iCal : "false"
	property screenSharing : "false"
	property safariDebug : "false"
	property safariDevelop : "false"
	property xcodeInternal : "false"
	property iBooks : "false"
	property AddressBook : "false"
	property AppStore : "false"
	
	property FinalTextSuccess : "Completed successfully. You will need to relaunch the applications you've made modifications to."
	property FinalTextFailure : "Errors have occurred! Errors are listed below:"
	
	on diskUtilityBox:sender
		if diskUtility is "true" then
			set diskUtility to "false"
		else if diskUtility is "false" then
			set diskUtility to "true"
		end if
	end diskUtilityBox:
	
	on iCalBox:sender
		if iCal is "true" then
			set iCal to "false"
		else if iCal is "false" then
			set iCal to "true"
		end if
	end iCalBox:
	
	on screenSharing:sender
		if screenSharing is "true" then
			set screenSharing to "false"
		else if screenSharing is "false" then
			set screenSharing to "true"
		end if
	end screenSharing:
	
	on safariDevelop:sender
		if safariDevelop is "true" then
			set safariDevelop to "false"
		else if safariDevelop is "false" then
			set safariDevelop to "true"
		end if
	end safariDevelop:
	
	on safariDebug:sender
		if safariDebug is "true" then
			set safariDebug to "false"
		else if safariDebug is "false" then
			set safariDebug to "true"
		end if
	end safariDebug:
	
	on xcodeInternal:sender
		if xcodeInternal is "true" then
			set xcodeInternal to "false"
		else if xcodeInternal is "false" then
			set xcodeInternal to "true"
		end if
	end xcodeInternal:
	
	on iBooks:sender
		if iBooks is "true" then
			set iBooks to "false"
		else if iBooks is "false" then
			set iBooks to "true"
		end if
	end iBooks:
	
	on AddressBook:sender
		if AddressBook is "true" then
			set AddressBook to "false"
		else if AddressBook is "false" then
			set AddressBook to "true"
		end if
	end AddressBook:
	
	on AppStore:sender
		if AppStore is "true" then
			set AppStore to "false"
		else if AppStore is "false" then
			set AppStore to "true"
		end if
	end AppStore:
	
	on applyButton:sender
		try
			do shell script "defaults write com.apple.appstore ShowDebugMenu -bool " & AppStore
			do shell script "defaults write com.apple.Safari IncludeDevelopMenu -bool " & safariDevelop
			do shell script "defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool " & diskUtility
			do shell script "defaults write com.apple.DiskUtility advanced-image-options -bool " & diskUtility
			do shell script "defaults write com.apple.AddressBook ABShowDebugMenu -bool " & AddressBook
			do shell script "defaults write com.apple.Safari IncludeInternalDebugMenu -bool " & safariDebug
			do shell script "defaults write com.apple.Safari IncludeDebugMenu -bool " & safariDebug
			do shell script "defaults write com.apple.ScreenSharing debug -bool " & screenSharing
			do shell script "defaults write com.apple.iCal IncludeDebugMenu -bool " & iCal
			do shell script "defaults write com.apple.iBooksX BKShowDebugMenu -bool " & iBooks
			do shell script "defaults write com.apple.dt.Xcode ShowDVTDebugMenu -bool " & xcodeInternal
			displayAlert(FinalTextSuccess)
		on error errorString
			displayErrorAlert(FinalTextFailure & return & return & errorString)
            do shell script "touch ~/Desktop/TTS-Errors.txt"
            set outputFile to ((path to desktop as text) & "TTS-Errors.txt")
            try
                set fileReference to open for access file outputFile with write permission
                write errorString to fileReference
                close access fileReference
                on error
                try
                    close access file outputFile
                end try
            end try
        end try
	end applyButton:
	
	on displayDialog(textToDisplay)
		display dialog textToDisplay with icon note with title title buttons {"OK"}
		return the result
	end displayDialog
	
	on displayAlert(textToDisplay)
		display alert title message textToDisplay
		return the result
	end displayAlert
	
	on displayErrorAlert(textToDisplay)
		display alert title message textToDisplay as warning
		return the result
	end displayErrorAlert
	
	on applicationWillFinishLaunching:aNotification
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching:
	
	on applicationShouldTerminate:sender
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
end script