function PrintCfg{
    Get-CimInstance -Namespace "root\cimv2\mdm\dmmap" -ClassName "MDM_AssignedAccess"
}

function ApplyCfg{
    $aacsp  = Get-CimInstance -Namespace "root\cimv2\mdm\dmmap" -ClassName "MDM_AssignedAccess"
    Write-Host "`n1) Multi App`n2) Shell Launcher"
    $type   = $Host.Ui.ReadLine()
    
    if ($type -ne 1 -and $type -ne 2){
        Write-Host "Invalid Input"        
        ApplyCfg
    }
    else{

        try{                         
            $escXML = Get-XML
        }
        catch{
            Write-Host "`n"$_ -ForeGroundColor DarkRed
            break
        }

        if     ($type -eq 1){
            $aacsp.Configuration = $escXML
        }
        elseif ($type -eq 2){
            $prodname = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName
            if ($prodname -like "*Enterprise*" -or $prodname -like "*Education*"){
                $aacsp.ShellLauncher = $escXML                
            }
            else{                  
                Write-Host "Only Windows 10 Enterprise or Education are licensed to use Shell Launcher. You are currently using " $prodname -ForegroundColor DarkRed
                break
            }
        }        
        
        Set-CimInstance -CimInstance $aacsp
            
        Write-Host "`nThe current configuration is:"
        Get-CimInstance -Namespace "root\cimv2\mdm\dmmap" -ClassName "MDM_AssignedAccess"
    }    
}

function ClearCfg{
    $count = 0
    $aacsp  = Get-CimInstance -Namespace "root\cimv2\mdm\dmmap" -ClassName "MDM_AssignedAccess"
    if ($aacsp.Configuration){       
        $aacsp.Configuration = $NULL 
        Set-CimInstance -CimInstance $aacsp
        Write-Host "Multi-App Kiosk Configuration cleared"
        $count++
    }
    if ($aacsp.ShellLauncher){
        $aacsp.ShellLauncher = $NULL
        Set-CimInstance -CimInstance $aacsp
        Write-Host "Shell Launcher Configuration cleared"
        $count++
    }
    if ($count -eq 0){
        Write-Host "No Multi-App or Shell Launcher Configuration found on present machine"
    }
}

function ExtractCfg{
    $count = 0
    $aacsp  = Get-CimInstance -Namespace "root\cimv2\mdm\dmmap" -ClassName "MDM_AssignedAccess"
    if ($aacsp.Configuration){
        $XML = [xml]($aacsp.Configuration)
        Format-XML $XML -indent 4 >> .\extractedMultiApp.xml
        Write-Host "Found Multi-App Kiosk, saving configuration as extractedMultiApp.xml"
        $count++              
    }
    if ($aacsp.ShellLauncher){
        $XML = [xml]($aacsp.ShellLauncher)
        Format-XML $XML -indent 4 >> .\extractedShellLauncher.xml  
        Write-Host "Found Shell Launcher, saving configuration as extractedShellLauncher.xml"
        $count++     
    }
    if ($count -eq 0){
        Write-Host "No Multi-App or Shell Launcher Configuration found on present machine"
    }
}

function Get-XML{
    $Path   = Read-Host "Enter the path to XML File"
    $XML    = Get-Content -Path $Path -ErrorAction Stop
    $escXML = [System.Security.SecurityElement]::Escape($XML) 

    return $escXML
}

function Format-XML ([xml]$xml, $indent=2) #from https://devblogs.microsoft.com/powershell/format-xml/
{
    $StringWriter = New-Object System.IO.StringWriter
    $XmlWriter = New-Object System.XMl.XmlTextWriter $StringWriter
    $xmlWriter.Formatting = “indented”
    $xmlWriter.Indentation = $Indent
    $xml.WriteContentTo($XmlWriter)
    $XmlWriter.Flush()
    $StringWriter.Flush()
    return $StringWriter.ToString()
}
