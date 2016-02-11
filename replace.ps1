#Tyler Boire
#replacement script
#2/5/2016
#WTFPL

function getInfo(){
#this prompts the user for information about what they would like to do.

$file = Read-Host -Prompt "What file would you like to search?" 

$term1 = Read-Host -Prompt "What term would you like to replace?"

$term2 = Read-Host -Prompt "What would you like to replace that term with?"

validate
}

function validate() {
#this allows the user to confirm that they would like to continue with the information they provided. 

write ("File to open: " + $file )
write ("Term to search: " + $term1)
write ("Term to replace with: " + $term2)

    $correct = Read-Host -Prompt "is this information correct?[Yes/No]"

    if($correct -eq "Yes" -or $correct -eq "yes"){
    replace
    }

    else{
    getInfo
    }
}

function replace(){
#this prints the replacement to the screen so the user can confirm the replacement worked correctly.

Write-Host "please Verify the information is as expected"

(cat $file).replace($term1,$term2) |out-host

    $correct2 = Read-Host -Prompt "is this information correct?[Yes/No]"

    #confirms the replacement went as planned or re-prompts for the information needed
    if($correct2 -eq "Yes" -Or $correct2 -eq "yes"){
    
            #Asks the user if they would like to save to the file they specified earlier. 
            $wantTosave = Read-Host -Prompt "Do you want to save this info?[Yes/No]"
            

            #Shames the user if they dont want to save or saves the file. 
            if ($wantTosave -eq "Yes" -Or $wantTosave -eq "yes"){

                #prompts user for save location then saves the file and alerts them it saved. 
                $save = Read-Host -Prompt "Where would you like to save the file?: ";
                (cat $file).replace($term1,$term2) |Set-Content $save; 
                Write-Host "File Saved Successfuly"
                }

            else{
                #user beratement. 
                Write-Host "LAME!" -BackgroundColor Black -ForegroundColor Red
            }

    }

    else{
    getInfo
    }

}

getInfo