# kioskMDM
Powershell cmdlets for applying/extracting Multi-App Kiosk and Shell Launcher configurations

How To:


1. Download PSExec: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
2. Run powershell as SYSTEM using psexec in an elevated CMD: **psexec -s -i powershell**
3. Import the script: **. .\kioskMDM.ps1**

Available Functions:

- **printcfg**    - Shows current configuration

     ![image](https://user-images.githubusercontent.com/79944491/160303609-5683b48a-d976-458d-b6ed-86adcb01f185.png)

- **applycfg**    - Applies a Multi-App Kiosk or ShellLauncher XML

     ![image](https://user-images.githubusercontent.com/79944491/160303637-600fa903-9719-4939-a32d-0233473b029e.png)

- **clearcfg**    - Clears any configuration found on the system

     ![image](https://user-images.githubusercontent.com/79944491/160303670-c01a7e25-2f3b-4b7a-9cf8-a31c3edfda9f.png)

- **extractcfg**  - Scans for Multi-App Kiosk / Shell Launcher configurations then formats and extracts them to an XML file

     ![image](https://user-images.githubusercontent.com/79944491/160303662-781f0387-c9ad-4226-a442-16ac4c0aac3d.png)
