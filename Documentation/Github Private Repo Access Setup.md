How to Set Up Access to a Private GitHub Repository for Testing

Part 1: SSH Key Setup (if you don’t have one)

1. Check for an Existing SSH Key  
   Open a terminal on your test system and run:  
   ls ~/.ssh/id_*.pub  
   If you see no output, you don’t have an SSH key yet.

2. Generate a New SSH Key  
   If needed, create a new SSH key by running:  
   ssh-keygen -t ed25519 -C "your_email@example.com"  
   Replace "your_email@example.com" with your GitHub email.  
   Press Enter to accept defaults and optionally set a passphrase.

3. Copy Your SSH Public Key  
   Display your public key:  
   cat ~/.ssh/id_ed25519.pub  
   Copy the entire output line.

4. Add the SSH Key to Your GitHub Account  
   - Log into GitHub on a device with a GUI.  
   - Go to Settings > SSH and GPG Keys.  
   - Click "New SSH Key".  
   - Paste your copied key into the field.  
   - Add a descriptive title (e.g., “Test System”) and save.

Notes for Headless Systems  
If your test system has no GUI, to copy your SSH key:  
- Find your test system’s IP address by running `ip a` and look for the IP under interfaces starting with "enp" (wired) or "wlp" (wireless).  
- SSH into your test system from another device with GUI:  
  ssh username@ip_address  
- Use Ctrl+Shift+C and Ctrl+Shift+V to copy/paste between terminals.

Part 2: Clone and Install the Private Repository

On your test system:

1. Install git if it’s not installed:  
   sudo dnf install git -y

2. Clone the repository using SSH (example command; replace with your repo URL):  
   git clone git@github.com:Always-Growing/Level-Up.git

3. Change directory to the repo:  
   cd Level-Up

4. Make the install script executable:  
   chmod +x install.sh

5. Run the install script:  
   sudo ./install.sh

Accessing a Test Branch

If you want to work on a test branch, do the following after cloning (replace examplebranch with your branch name):  
git checkout -b feature/examplebranch origin/feature/examplebranch  
chmod +x install.sh  
./install.sh
