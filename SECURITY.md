# Security Policy

## Reporting

Open a GitHub issue or security advisory (if enabled). **Do not** paste `AP_RELOAD_PASSWORD`, live hostnames of production APs, or internal network diagrams.

## Supported scope

We treat **credential leaks in scripts** and **unsafe defaults** as security issues. Misconfiguration of your own `AP_DNS_DOMAIN` or zone files is an operator concern.

## Hardening notes

- Prefer vault / secret manager for `AP_RELOAD_PASSWORD` in production; avoid leaving it in shell history (use `source .env` from a restricted file).
- This tooling uses **interactive password-based SSH** suited to legacy AP CLIs; migrate to vendor-supported automation when available.
