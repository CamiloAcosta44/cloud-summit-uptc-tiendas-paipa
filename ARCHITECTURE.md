# Arquitectura de la infraestructura

## Resumen

Arquitectura cloud híbrida con patrón "Datos Anclados, Cómputo Expuesto".

## Componentes

| Componente | IP | Tipo | Función |
|---|---|---|---|
| Proxmox VE | 192.168.1.50 | Host físico | Hipervisor |
| LXC1 vm-app | 192.168.1.100 | LXC | PrestaShop + WireGuard |
| VM2 vm-db | 192.168.1.110 | VM | MariaDB + phpMyAdmin |
| LXC3 vm-continuidad | 192.168.1.120 | LXC | Uptime Kuma + Backups |
| GCP vm-publica-paipa | 34.95.135.114 | VM Cloud | Nginx + WireGuard servidor |
| GCP vm-replica-db | 35.253.11.22 | VM Cloud | MariaDB réplica |

## Capas

- **Edge:** Cloudflare (CDN + WAF + SSL)
- **Cloud:** Google Cloud (Nginx + WireGuard + Réplica MariaDB)
- **Fog:** Proxmox Paipa (PrestaShop + MariaDB + Monitoreo)

## Túnel WireGuard
10.10.0.1 — GCP vm-publica-paipa (servidor)
10.10.0.2 — LXC1 vm-app (cliente app)
10.10.0.3 — GCP vm-replica-db (cliente réplica)

## Flujo de una compra
Cliente → Cloudflare → GCP Nginx → WireGuard → LXC1 PrestaShop → VM2 MariaDB

## Marco regulatorio

- Ley 1480 de 2011 + Ley 2439 de 2024
- Ley 1581 de 2012
- Resolución DIAN 165/2023
