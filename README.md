# batch_reload_ap

**Languages:** [English](#english) · [Português (Brasil)](#português-brasil)

Bash + Expect utilities to **SSH into access points** listed in per-zone files and drive an **interactive reload** (enable → reload → confirm), one device at a time, with optional **fping** pre-checks.

---

## English

### Layout

| Path | Role |
| ---- | ---- |
| `batch_reload.sh` | Reads a zone file under `/home/reload/reload/`, pings each host, runs `reload_ap.expect`. |
| `reload_ap.expect` | `expect` script: SSH, password, enable, reload. |
| `reload/` | Example zone lists (one hostname **prefix** per line; FQDN = `line`.`AP_DNS_DOMAIN`). |

Install paths in the scripts assume **`reload_ap.expect`** at `/usr/local/bin/reload_ap.expect` and data under **`/home/reload/reload/`** — adjust on your server or symlink.

### Configuration (environment)

| Variable | Required | Meaning |
| -------- | -------- | ------- |
| `AP_RELOAD_PASSWORD` | **Yes** | Password for SSH + enable mode on the AP CLI. **Never** commit the real value. |
| `AP_DNS_DOMAIN` | No (default `example.invalid`) | Suffix for FQDN: `fping` and SSH use `${HOST}.${AP_DNS_DOMAIN}`. |
| `AP_SSH_USER` | No (default `admin`) | SSH username on the AP. |

Copy `.env.example`, fill secrets, then:

```bash
set -a && source .env && set +a
./batch_reload.sh zona
```

### Security

- Do **not** paste live passwords or internal DNS zones into GitHub issues or PRs.
- Prefer **SSH keys** where the device supports it; this repo follows a legacy password-based CLI flow.

### Related tools

- **`fping`**, **`expect`**, **`ssh`**

---

## Português (Brasil)

### Estrutura

| Caminho | Função |
| ------- | ------ |
| `batch_reload.sh` | Lê um arquivo de zona em `/home/reload/reload/`, faz ping em cada host e chama `reload_ap.expect`. |
| `reload_ap.expect` | Script Expect: SSH, senha, `ena`, `reload`. |
| `reload/` | Exemplos de listas por zona (um **prefixo** de hostname por linha; FQDN = `linha`.`AP_DNS_DOMAIN`). |

Os caminhos fixos no script assumem **`reload_ap.expect`** em `/usr/local/bin/reload_ap.expect` e dados em **`/home/reload/reload/`** — ajuste no servidor ou use links simbólicos.

### Configuração (ambiente)

| Variável | Obrigatório | Significado |
| -------- | ----------- | ----------- |
| `AP_RELOAD_PASSWORD` | **Sim** | Senha SSH + enable no CLI do AP. **Não** commite o valor real. |
| `AP_DNS_DOMAIN` | Não (padrão `example.invalid`) | Sufixo do FQDN: `fping` e SSH usam `${HOST}.${AP_DNS_DOMAIN}`. |
| `AP_SSH_USER` | Não (padrão `admin`) | Usuário SSH no AP. |

Copie `.env.example`, preencha e exporte (ou `source .env`) antes de rodar `./batch_reload.sh zona`.

### Segurança

- Não cole senhas nem zonas DNS internas em issues ou PRs públicos.
