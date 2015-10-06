--
--  AppDelegate.applescript
--  Delayed Command Execution
--
--  Created by Thomas Jones on 31/12/2014.
--  Copyright (c) 2014 TomTec Solutions. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value
	property theSpinner : missing value
	property adminCheckbox : missing value
	property commandTextbox : missing value
	property adminUsernameTextbox : missing value
	property adminPasswordTextbox : missing value
	property executionProgressLabel : missing value
	property executeButton : missing value
	
	global radioButtonChoice, title, theBoxState
	
	on someonePressedTheExecuteButton:sender
		tell executeButton to setEnabled:0
		set errorString to ""
		set errorNumber to ""
		if radioButtonChoice is 0 then
			display alert title message "You didn't select a post-execution option. Please select one, and try again." as critical
			--else
			--display alert title message "You selected the '" & radioButtonChoice & "' option."
		end if
		set theCommand to stringValue() of commandTextbox as string
		if theBoxState is "true" then
			set theUsername to stringValue() of adminUsernameTextbox as string
			set thePassword to stringValue() of adminPasswordTextbox as string
			if theUsername is "" then
				set theEnding to " To run commands with elevated privileges, the user name and password of an administrator is required."
				display alert title message "Nothing was entered in the user name text box." & theEnding as critical buttons {"Try Again"} default button 1
			end if
			if thePassword is "" then
				display alert title message "Nothing was entered in the password text box." & theEnding as critical buttons {"Try Again"} default button 1
			end if
		end if
		tell executionProgressLabel to setStringValue:"Executing the command..."
		tell theSpinner to startAnimation:me
		if theBoxState is "true" then
			try
				do shell script theCommand user name theUsername password thePassword with administrator privileges
			on error errorString number errorNumber
				display dialog errorString
			end try
		else if theBoxState is "false" then
			try
				do shell script theCommand
			on error errorString number errorNumber
				display dialog errorString
			end try
		end if
		tell theSpinner to stopAnimation:me
		if errorString is not "" then
			tell executionProgressLabel to setStringValue:"Done, with errors. Error number:" & space & errorNumber
			else
			tell executionProgressLabel to setStringValue:"Done"
			end if
		tell executeButton to setEnabled:1
	end someonePressedTheExecuteButton:
	
	on theAdminCheckboxWasFlipped:sender
		set theBoxState to objectValue() of adminCheckbox as string
		if theBoxState is "false" then
			tell adminUsernameTextbox to setStringValue:""
			tell adminPasswordTextbox to setStringValue:""
			tell adminUsernameTextbox to setEnabled:0
			tell adminPasswordTextbox to setEnabled:0
		end if
		if theBoxState is "true" then
			tell adminUsernameTextbox to setEnabled:1
			tell adminPasswordTextbox to setEnabled:1
		end if
	end theAdminCheckboxWasFlipped:
	
	on radioButton1Pressed:sender
		set radioButtonChoice to "Shut Down"
	end radioButton1Pressed:
	
	on radioButton2Pressed:sender
		set radioButtonChoice to "Restart"
	end radioButton2Pressed:
	
	on radioButton3Pressed:sender
		set radioButtonChoice to "Play Alert Beep"
	end radioButton3Pressed:
	
	on radioButton4Pressed:sender
		set radioButtonChoice to "Full Sleep"
	end radioButton4Pressed:
	
	on radioButton5Pressed:sender
		set radioButtonChoice to "Display Sleep"
	end radioButton5Pressed:
	
	on radioButton6Pressed:sender
		set radioButtonChoice to "Do Nothing"
	end radioButton6Pressed:
	
	
	on applicationWillFinishLaunching:sender
		set radioButtonChoice to 0
		set theBoxState to "false"
		set title to the name of the current application
		tell executionProgressLabel to setStringValue:""
	end applicationWillFinishLaunching:
	
	on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	on applicationShouldTerminateAfterLastWindowClosed:sender
		return true
	end applicationShouldTerminateAfterLastWindowClosed:
	
end script