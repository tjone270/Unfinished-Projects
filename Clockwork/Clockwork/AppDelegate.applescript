--
--  AppDelegate.applescript
--  Clockwork
--
--  Created by Thomas Jones on 31/03/2015.
--  Copyright (c) 2015 TomTec Solutions. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value

	on applicationWillFinishLaunching_(aNotification)
		
	end applicationWillFinishLaunching_
	
	on request(uri)
		do shell script "curl tomtecsolutions.com/clockwork/" & uri
		return result
	end request
	
	on createJob()
		set theDate
		set latestJobNumber to (request("latestjobnumber"))
		set newUnusedJobNumber to (latestJobNumber + 1)
		write(newUnusedJobNumber, "created " & theDate
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script