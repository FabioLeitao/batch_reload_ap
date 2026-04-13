#!/bin/bash
set -u
COMANDO=$0
ARGUMENTO=${1:-}
TIMESTAMP=$(date +"%Y-%m-%d %T")
HOME_="/home/reload/reload"
ZONA=${HOME_}/${ARGUMENTO}
RELOAD="/usr/local/bin/reload_ap.expect"

function ajuda_() {
	echo "Usage: $COMANDO [zona] [-h|--help]" >&2
	echo "Requires AP_RELOAD_PASSWORD when running a zone; optional AP_DNS_DOMAIN, AP_SSH_USER." >&2
}

function arruma_param_() {
: "${AP_RELOAD_PASSWORD:?AP_RELOAD_PASSWORD is not set (see .env.example)}"
export AP_RELOAD_PASSWORD
export AP_DNS_DOMAIN="${AP_DNS_DOMAIN:-example.invalid}"
export AP_SSH_USER="${AP_SSH_USER:-admin}"

if [ -f "${ZONA}" ]; then
	echo "${TIMESTAMP} - SOLICITADA LISTA ${ARGUMENTO} PARA DESLIGAMENTO" | tee -a "${HOME_}/aps.log"
	UNIDADES=$(cat "${ZONA}")
	for UNIDADE in ${UNIDADES}; do
		fping "${UNIDADE}.${AP_DNS_DOMAIN}"
		ULTIMA=$?
		if [ "${ULTIMA}" -ne 0 ]; then
			echo "${TIMESTAMP} - ERRO AO CONTACTAR EQUIPAMENTO ${UNIDADE}, PROVAVELMENTE INACESSIVEL OU DESLIGADO!" | tee -a "${HOME_}/aps.log"
		else
			${RELOAD} "${UNIDADE}"
			ULTIMA=$?
			if [ "${ULTIMA}" -ne 0 ]; then
				echo "${TIMESTAMP} - ERRO AO REINICIAR EQUIPAMENTO ${UNIDADE}!" | tee -a "${HOME_}/aps.log"
			else
				echo "${TIMESTAMP} - EQUIPAMENTO ${UNIDADE} REINICIADO COM SUCESSO!" | tee -a "${HOME_}/aps.log"
			fi
		fi
		sleep 10
	done
else
	echo "Arquivo de parametros ${ARGUMENTO} nao existe ou inacessivel"
fi
}

case "${ARGUMENTO}" in
	-h|--help|"")
		ajuda_
		;;
	*)
		arruma_param_
		;;
esac
