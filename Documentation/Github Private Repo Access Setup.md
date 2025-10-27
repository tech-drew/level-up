# Setting Up Access to a Private GitHub Repository for Testing
These steps explain how to configure SSH access and clone a private GitHub repository securely on your Fedora system.

## Part 1: Set Up SSH Key Access (if you don’t have one)

## 1. Check for an Existing SSH Key
```bash
ls ~/.ssh/id_*.pub
```
If you see no output, you don’t have an SSH key yet and will need to generate one.

## 2. Generate a New SSH Key
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"  
```
Replace "your_email@example.com" with the email address associated with your GitHub account.  
Press Enter to accept the defaults, and optionally set a secure passphrase.

## 3. Copy Your SSH Public Key
```bash
cat ~/.ssh/id_ed25519.pub  
```
Copy the entire output line — this is your public key.

## 4. Add the SSH Key to Your GitHub Account
1. Log into your GitHub account on a device with a graphical interface (GUI).  
2. Go to: Settings → SSH and GPG Keys  
3. Click "New SSH Key".  
4. Paste your copied key into the key field.  
5. Add a descriptive title (for example, "Test System") and save.

## Notes for Headless Systems
If your test system does not have a GUI:

1. Find your system’s IP address:  
   ip a  
   Look for an address under interfaces beginning with "enp" (wired) or "wlp" (wireless).

2. From another device with a GUI, SSH into your test system:  
   ssh username@ip_address  

3. Use Ctrl+Shift+C and Ctrl+Shift+V to copy and paste between terminals.

## Part 2: Clone and Install the Private Repository

### 1. Install Git (if not already installed)
```bash
sudo dnf install git -y
```

### 2. Clone the Repository Using SSH
```bash
git clone git@github.com:Always-Growing/Level-Up.git  
```
Replace this URL with your own private repository’s SSH clone URL.

### 3. Change Directory to the Repository
```bash
cd Level-Up
```

### 4. Make the Install Script Executable
```bash
chmod +x install.sh
```

### 5. Run the Install Script
```bash
./install.sh
```

## Accessing a Test Branch
If you want to switch to a specific test branch, use the following commands (replace "examplebranch" with your branch name):
```bash
git checkout -b feature/examplebranch origin/feature/examplebranch  
chmod +x install.sh  
./install.sh
```

Your system is now configured to securely access and install your private GitHub repository using SSH.
