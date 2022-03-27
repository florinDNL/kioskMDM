# kioskMDM
Powershell cmdlets for applying/extracting Multi-App Kiosk and Shell Launcher configurations

How To:


1. Download PSExec: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
2. Run powershell as SYSTEM using psexec in an elevated CMD: **psexec -s -i powershell**
3. Import the script: **. .\kioskMDM.ps1**

Available Functions:

- **printcfg**    - Shows current configuration
- **applycfg**    - Applies a Multi-App Kiosk or ShellLauncher XML
- **clearcfg**    - Clears any configuration found on the system
- **extractcfg**  - Scans for Multi-App Kiosk / Shell Launcher configuration then formats and extracts them to an XML file
