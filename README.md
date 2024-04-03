## Setup VPS for farming
```
curl https://raw.githubusercontent.com/Minh-s-org/setup-vps/main/setup.ps1 -OutFile ./setup.ps1 ; ./setup.ps1
```

## Setup VPS for node raiser
```
Set-Location "C:\Users\Administrator"
curl https://raw.githubusercontent.com/Minh-s-org/setup-vps/main/setup-node-raiser.ps1 -OutFile ./setup-node-raiser.ps1 ; ./setup-node-raiser.ps1
```

## Setup node
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
curl https://raw.githubusercontent.com/Minh-s-org/setup-vps/main/setup-node.ps1 -OutFile ./setup-node.ps1 ; ./setup-node.ps1
```

## Renew node
##### This script will:
- Package node on VPS
- Clean up current node on PC
- Setup new node on PC
- Trigger create new node on VPS

### Setup
Clone this repo to C:\Users\<User>
```
.\setup-vps\renew-node.ps1
```