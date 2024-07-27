[Setup]
AppName=ConcordClient
AppVersion=1.0
DefaultDirName={commondocs}\ConcordClient
DefaultGroupName=ConcordClient
OutputBaseFilename=ConcordClientInstaller
OutputDir=E:\Projetos Flutter
Compression=lzma
SolidCompression=yes

[Files]
Source: "E:\Projetos Flutter\concord_client\build\windows\x64\runner\Release\concord_client.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Projetos Flutter\concord_client\build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "E:\Projetos Flutter\concord_client\build\windows\x64\runner\Release\file_selector_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Projetos Flutter\concord_client\build\windows\x64\runner\Release\flutter_webrtc_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Projetos Flutter\concord_client\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Projetos Flutter\concord_client\build\windows\x64\runner\Release\libwebrtc.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\ConcordClient"; Filename: "{app}\concord_client.exe"
Name: "{group}\Uninstall ConcordClient"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\concord_client.exe"; Description: "{cm:LaunchProgram,ConcordClient}"; Flags: nowait postinstall skipifsilent
