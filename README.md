# Cloud Summit UPTC — Tiendas Paipa Online
## Arquitectura cloud híbrida para e-commerce boyacense

**Grupo 6 — Sector Comercio / E-commerce**  
**Cloud Summit UPTC — Transformación Digital Sectorial: De Boyacá a la Nube**  
**CloudPaipa Consulting S.A.S. — Mayo 2026**

---

## Descripción del proyecto

Este repositorio contiene la implementación completa de la arquitectura cloud híbrida
propuesta para Tiendas Paipa Online, un e-commerce de productos artesanales y
agroindustriales del municipio de Paipa, Boyacá.

La solución combina infraestructura on-premise con Proxmox VE y servicios en Google
Cloud, protegida por Cloudflare, conectada mediante WireGuard y cumpliendo con la
Ley 1480, Ley 2439/2024 y Ley 1581.

## Sitio en producción

**https://prestashop.monster**

## Arquitectura
## Stack tecnológico

| Capa | Tecnología |
|------|-----------|
| E-commerce | PrestaShop 8.1 |
| Base de datos | MariaDB 10.6 |
| Orquestación | Docker Compose |
| Virtualización | Proxmox VE 8 + LXC + KVM |
| VPN | WireGuard |
| CDN / WAF | Cloudflare Free |
| Nube pública | Google Cloud Free Tier |
| Monitoreo | Uptime Kuma |

## Instrucciones de despliegue

Ver [docs/Informe_Tecnico_Tiendas_Paipa_Online.txt](docs/Informe_Tecnico_Tiendas_Paipa_Online.txt)
o el Anexo D del archivo [docs/Anexos_Tiendas_Paipa_Online.docx](docs/Anexos_Tiendas_Paipa_Online.docx)

## Marco regulatorio

- Ley 1480 de 2011 (Estatuto del Consumidor)
- Ley 2439 de 2024 (modifica Ley 1480)
- Ley 1581 de 2012 (Protección de datos personales)

## Integrantes

| Nombre | Rol |
|--------|-----|
| [Nombre 1] | Arquitecto de infraestructura |
| [Nombre 2] | Especialista de aplicación y datos |
| [Nombre 3] | Especialista cloud y seguridad |
