# Tools Reference

## Bettercap

**Version used:** v2.33.0 (linux amd64, Go 1.22.6)

Bettercap is a powerful, modular, and portable framework for network reconnaissance and MITM attacks. It provides real-time network monitoring, ARP/DNS spoofing, packet sniffing, and credential harvesting.

### Installation

```bash
# Kali Linux (pre-installed)
sudo apt update && sudo apt install bettercap

# From source
go install github.com/bettercap/bettercap@latest
```

### Key Modules Used

| Module        | Purpose                                    |
|---------------|--------------------------------------------|
| `net.probe`   | Active host discovery via ARP/UDP probes   |
| `net.recon`   | Passive network reconnaissance             |
| `arp.spoof`   | ARP cache poisoning for MITM positioning   |
| `net.sniff`   | Packet capture and protocol dissection     |

### Documentation

- https://www.bettercap.org/docs/

---

## Hydra (THC)

**Version used:** v9.x

THC-Hydra is a fast and flexible network login cracker supporting numerous protocols including HTTP, FTP, SSH, SMB, and more.

### Installation

```bash
# Kali Linux (pre-installed)
sudo apt update && sudo apt install hydra

# From source
git clone https://github.com/vanhauser-thc/thc-hydra.git
cd thc-hydra && ./configure && make && sudo make install
```

### Supported Protocols (subset relevant to IoT)

| Protocol         | Flag             |
|------------------|------------------|
| HTTP GET         | `http-get`       |
| HTTP POST Form   | `http-post-form` |
| FTP              | `ftp`            |
| SSH              | `ssh`            |
| Telnet           | `telnet`         |
| RTSP             | `rtsp`           |

### Documentation

- https://github.com/vanhauser-thc/thc-hydra
