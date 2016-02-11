#Tyler Boire
#Intro to menus in powershell
#2/4/2016
#WTFPL

#main menu that presents initial choices to the users and allows the script to be terminated. 
function menu () {
 
Write-Host "Welcome to NET300-01 Powershell for Admins menus"
Write-Host "Please select an option from the menu."
Write-Host "1.Security"
Write-Host "2.Administration"
Write-Host "3.exit"

$choice = Read-Host "Selection: "

#runs the command chosen by the user or exits the script. If the users picks and inncorrect choice, the script loops. 
switch($choice)
    {
        1 {secMenu;break}
        2 {adminMenu;break}
        3 {exit;break}
        default {Write-Host "That is not an option, please try again";menu}
    }

}

#broke out the logic for searching logs rather than do it in my case statement.
#prompts users for how many logs they want and then search terms for the logs. 
function logSearch(){

    $logCount = Read-Host -Prompt "How many logs would you like to search?"
    $logTerm = Read-Host -Prompt "Please enter search terms seperated by comma"
    $logTerm = ($logTerm).Replace(",","|")

    Get-EventLog -Newest $logCount | where{$_.Message -match ($logTerm)}

}

#secondary menu for security options. 
function secMenu() {
    Write-Host "Security Menu: "
    Write-Host "1. Get 100 event logs"
    Write-Host "2. Get applied HotFixes"
    Write-Host "3. Get running services"
    Write-Host "4. Search through event logs"
    Write-Host "5. Return to main menu"

   $choice = Read-Host "Selection: "
    
#runs security commands based on user choice then returns to main menu. 
switch($choice)
    {
        1{Get-EventLog -Newest 100;break}
        2{Get-HotFix;break}
        3{Get-Service|where{$_.Status -match "running" };break}
        4{logSearch;break}
        5{menu;break}
        default {write-host "That is not an option, please try again";secMenu}
    }

#goes back to main menu after choice. 
secMenu
}

#secondary menu for administration commands. 
function adminMenu() {
    Write-Host "Admin Menu: "
    Write-Host "1. Get running process as CSV"
    Write-Host "2. Get running process as HTML"
    Write-Host "3. Start administrator shell"
    Write-Host "4. Return to the main menu"

    $choice = Read-Host "Selection: "

	
#runs commands based on the choice of the user. 
switch($choice)
    {
		#asks where to save the CSV in absolute path notation then saves to the location. 
        1{  $path = read-host "Where would you like to save the CSV?"; 
            Get-Process| ConvertTo-Csv > $path;
            break}

		#asks where to save the HTML in absolute path notation then saves to the location. 
        2{ $path = read-host "Where would you like to save the HTML";
            Get-Process | ConvertTo-Html > $path;
            break}

        3{Start-Process powershell -Verb runas;break}

        4{menu;break}

        default {write-host "That is not an option, please try again";adminMenu}
    }

#loops back to main menu after the choice was ran. 
adminMenu
}




#calls the main menu function.
menu