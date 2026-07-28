---
title: Device Checklist
description: My First Setup Checklist
draft: true
tags:
  - android
  - linux
  - windows
  - windows/wsl
---

# Device Checklist

This checklist contains the following:

- ~~Windows 11 Pro 24H2~~
- [[#Fedora Linux (Server Edition)]]
- ~~Armbian 25 Bookworm~~
- ~~Android 14~~

> [!CAUTION] DO NOT BLINDLY COPY-PASTE!!!
> 
> The commands here are for reference only and for providing hints. They are not meant to be copy-pasted without knowing what you are doing.

## Fedora Linux (Server Edition)

<html>
	<table>
		<tbody>
			<tr>
				<td>Tested on version</td>
				<td><code>== 42</code></td>
			</tr>
		</tbody>
	</table>
</html>

- [ ] [Cockpit](https://cockpit-project.org/) is installed, running, and configured properly.
- [ ] Firewall is enabled.
- [ ] [Tailscale](https://tailscale.com/) is installed, enabled, and connected to tailnet. [wiki](https://tailscale.com/kb/1511/install-fedora-2)
	- [ ] [Key expiry](https://tailscale.com/kb/1028/key-expiry) is disabled.

```bash
# Install Tailscale
sudo dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install tailscale

# More info: https://tailscale.com/kb/1019/subnets?tab=linux#enable-ip-forwarding
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/98-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/98-tailscale.conf
sudo sysctl -p /etc/sysctl.d/98-tailscale.conf

# Start Tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up --advertise-exit-node
```

- [ ] SSH configuration:
	- [ ] Disabled password authentication
	- [ ] SSH is running on a different port.
	- [ ] SSH public keys are added to the system. `ssh-keygen -t ed25519 && ssh-copy-id user@server_address`

```plaintext
# Edit /etc/ssh/sshd_config and restart sshd.service

PubkeyAuthentication yes
PasswordAuthentication no  # Disable password-based login
PermitRootLogin no  # Disable root login
```

```bash
mkdir -p ~/.ssh

# append public keys to ~/.ssh/authorized_keys

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

- [ ] [Podman](https://podman.io/) is installed.
- [ ] CLI utilities:
	- [ ] `git`, `git-lfs` for managing Git repositories.
	- [ ] `tmux` to keep terminal sessions even when disconnected.
	- [ ] `btop` as a CLI fallback to Cockpit.
	- [ ] `podman-compose` to manage Podman containers using compose files.
	- [ ] `uv` to manage Python projects and installation. [website](https://docs.astral.sh/uv/)
	- [ ] `pfetch` is in `~/.local/bin`. [repo](https://github.com/Un1q32/pfetch/)
	- [ ] `inxi` for system information.
- [ ] System configuration:
	- [ ] Set `HandleLidSwitch` to `ignore` in `/usr/lib/systemd/logind.conf`, if server is a laptop.
	- [ ] Add `defaultyes`, `deltarpm`, and `max_parallel_downloads` in `/etc/dnf/dnf.conf`.
	- [ ] Run `echo "net.ipv4.ip_unprivileged_port_start = 80" | sudo tee /etc/sysctl.d/90-unprivileged_port_start.conf`
	- [ ] `systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target` to prevent sleeping.
- [ ] `SelfHosted` repo is in `~/SelfHosted`.
- [ ] `Temp` directory is created in `~/Temp`.
