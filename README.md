# Win Firewall Batch Block Outbund
This PowerShell script blocks outbound internet connections for all executable files (*.exe) found in a specified folder and its subfolders (recursively). It allows users to specify a prefix for the firewall rule names, making it easy to identify the rules in the Windows Firewall or by default, uses specified folder name.

## Features

- Recursively finds all `.exe` files in a specified folder.
- Blocks outbound internet connections for each found executable.
- Allows specifying a custom prefix for the firewall rule names.
- Automatically uses the name of the specified folder as the prefix if no custom prefix is provided.

## Prerequisites

- Windows 10 or later
- PowerShell (running as Administrator)

## Usage

1. Clone this repository or download the script file.

2. Open PowerShell as Administrator.
3. Go to the folder where you saved the script file
4. Execute the script
    ```powershell
    .\win-firewall-batch-block.ps1
    ```
6. When prompted, enter the full path to the folder (or drop the folder to the Powershell window)
7. Optionally, enter a prefix for the firewall rule names. If you leave it blank, the script will use the name of the specified folder as the prefix.

## Example

If you want to block all Adobe software, when asked,  put the (default) Adobe Installation path ``` C:\Program Files\Adobe ```

Next, will ask for a prefix to be used in all new firwall rules. For this example, we input 'Adobe Block All'. If we pulse enter, will use "Adobe" as prefix due folder name of the path we introduced 'C:\Program Files\Adobe'

The script will found thousands of executables in subfolders (in my case, 39 with photoshop 2024 and Illustrator 20024 installed). Two random examples:
 - C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe
 - C:\Program Files\Adobe\Adobe Photoshop 2024\Photoshop.exe

The final rule names **with prefix** input 'Adobe Block All':
- Adobe Block All - CCXProcess.exe
- Adobe Block All - Photoshop.exe

The final rule names **wihtout prefix** input:
- Adobe - CCXProcess.exe
- Adobe - Photoshop.exe
