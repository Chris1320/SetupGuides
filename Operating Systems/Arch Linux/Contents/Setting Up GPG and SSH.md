# Setting Up GPG and SSH

If you have an existing GPG and SSH keys, you can now start restoring them to your new system.

## Importing Your GPG keys

First, import your GPG private key.

```bash
gpg --import your_gpg_key.gpg
```

Next, edit the key and trust it ultimately. You'll have to get the key ID first.

```bash
# List secret keys and show their key IDs.
gpg --list-secret-keys --keyid-format=SHORT
# Edit the key
gpg --edit-key <THE KEY ID>
# gpg> trust
# ...
# Your decision? 5
# Do you really want to set this key to ultimate trust? (y/N) y
# gpg> quit
```

## Importing Your SSH keys

First of all, you have to install OpenSSH.

```bash
paru -S openssh
```

Copy your private and public keys to `~/.ssh`, and adjust the permissions.

```bash
# Create ~/.ssh if it does not exist.
mkdir -p ~/.ssh

# Copy the public and private keys to the newly-created directory.
# Example 1: ED25519 keys
cp ~/Downloads/your_ed25519_ssh_key ~/.ssh/id_ed25519
cp ~/Downloads/your_ed25519_ssh_key.pub ~/.ssh/id_ed25519.pub
# Example 2: RSA keys
cp ~/Downloads/your_rsa_ssh_key ~/.ssh/id_rsa
cp ~/Downloads/your_rsa_ssh_key.pub ~/.ssh/id_rsa.pub

# Adjust permissions
chmod 600 ~/.ssh/*
chmod 700 ~/.ssh
```

## Configuring SSH

You can also add a host configuration block in `~/.ssh/config` so that you can clone repositories using a shorter command.

```text
Host gh
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
```

If you add this line, all you have to do when cloning GitHub repositories is to
run `git clone gh:username/repo.git`. Make sure that you've set up your GitHub
account correctly first.

You can test your setup by running the command

```bash
ssh -T gh
```

It should print out something like this:

```text
Hi Chris1320! You've successfully authenticated, but GitHub does not provide shell access.
```

-----

- Previous: [[Setting Up ZSH]]
- Next: [[Installing Useful Software]]
