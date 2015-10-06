--
--  AppDelegate.applescript
--  Moebius
--
--  Created by Thomas Jones on 28/02/2015.
--  Copyright (c) 2015 TomTec Solutions. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property loginWindow : missing value
	property tomTecSolutionsDomain : "tomtecsolutions.com"
	property secondaryTestingDomain : "8.8.8.8"
	global theVersion, title
	
	on applicationWillFinishLaunching:aNotification
		initialise()
	end applicationWillFinishLaunching:
	
	on initialise()
		set theVersion to "Version " & version of current application
		set title to the name of the current application
		tell loginWindow to setTitle:("Moebius Ð " & theVersion)
		checkConnectivity()
	end initialise
	
	on checkConnectivity()
		try
			do shell script "ping -o " & tomTecSolutionsDomain
		on error errorString number errorNumber
			display alert title message "Moebius isn't able to establish a connection to the TomTec Solutions server. Please try again later." as warning buttons {"Quit"}
			logEntry("Error String: " & errorString)
			logEntry("Error Number: " & errorNumber)
			quit me
		end try
	end checkConnectivity
	
	on applicationShouldTerminate:sender
		logEntry("applicationShouldTerminate, NSTerminateNow...")
		logEntry("================================================================================")
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	on logEntry(logText)
		set theDate to do shell script "date"
		do shell script "echo [" & theDate & "]: " & logText & " >> ~/Documents/MoebiusLog.txt"
		log logText
	end logEntry
	
	on applicationShouldTerminateAfterLastWindowClosed_(sender)
		return true
	end applicationShouldTerminateAfterLastWindowClosed_
	
end script