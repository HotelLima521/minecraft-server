# HL521's Minecraft Mod manager

For Windows:
1. Open Powershell
2. Run below code:
```powershell
powershell -command "& {iwr https://raw.githubusercontent.com/HotelLima521/minecraft-server/main/install.ps1 -OutFile install.ps1 }" | powershell -ExecutionPolicy Bypass -File "install.ps1"
```


For Unix-like systems (Mac/Linux/BSD):
1. Open the terminal
2. Run below code: 
```sh
wget -c https://raw.githubusercontent.com/HotelLima521/minecraft-server/main/install.sh && chmod +x install.sh && ./install.sh
```
