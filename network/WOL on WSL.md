---
type: concept
title: WSL2 Networking Modes and Wake-on-LAN Workarounds
description: Resolving Wake-on-LAN packet delivery issues from WSL2 on Windows 11 via mirrored networking, directed subnet broadcast, and native PowerShell invocation.
Source: https://gemini.google.com/app/fa4644a760b6dad5
tags:
  - wsl
  - networking
  - wol
  - fedora
  - fish-shell
---

# WSL2 Networking Modes and Wake-on-LAN Workarounds

## Problem
Tools relying on Layer 2 / UDP broadcast packets (such as the `wol` utility) fail to wake target machines when executed from inside a standard WSL2 instance.

## Cause
By default, WSL2 operates behind a virtual Hyper-V NAT switch on an isolated private subnet (e.g., `172.x.x.x`). Outbound unicast TCP/UDP traffic is translated seamlessly, but local Layer 2 broadcast packets (e.g., to `255.255.255.255`) are dropped and cannot reach the physical host Wi-Fi or LAN adapter.

---

## Solutions & Workarounds

### Method 1: Enable Mirrored Networking Mode
Mirrored networking allows WSL2 to share the host's physical network adapters directly, enabling raw broadcast utilities to function normally.

1. Edit or create `%USERPROFILE%\.wslconfig` in Windows:
   ```ini
   [wsl2]
   networkingMode=mirrored

## Fish shell utility
'''
function wake-m920x --description "Send Wake-on-LAN packet to m920x server"
    # Under Mirrored Networking:
    wol 98:fa:9b:36:f3:d4

    # Under NAT with Subnet Broadcast (Fallback):
    # Your router (e.g., MikroTik) must permit IP directed broadcasts.
    # wol -i 192.168.88.255 98:fa:9b:36:f3:d4
end
'''

Save with `funcsave wake-m920x`

