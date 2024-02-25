#!/bin/bash
COMANDO=$0
ARGUMENTO=$1
TIMESTAMP=`date +"%Y-%m-%d %T"`
HOME_="/home/reload/reload"
ZONA=${HOME_}/${ARGUMENTO}
RELOAD="/usr/local/bin/reload_ap.expect"

function ajuda_(){
echo "Usage: $COMANDO [zona] [-h|--help]" >&2 ;
}

function arruma_param_(){
if [ -f ${ZONA} ] ; then 
	echo "${TIMESTAMP} - SOLICITADA LISTA ${ARGUMENTO} PARA DESLIGAMENTO" | tee -a ${HOME_}/aps.log
	UNIDADES=`cat ${ZONA}`
	for UNIDADE in ${UNIDADES} ; do
		fping $UNIDADE.glibra.corp
		ULTIMA=$?
		if [ ${ULTIMA} -ne 0 ]; then
			echo "${TIMESTAMP} - ERRO AO CONTACTAR EQUIPAMENTO ${UNIDADE}, PROVAVELMENTE INACESSIVEL OU DESLIGADO!" | tee -a ${HOME_}/aps.log
		else
			${RELOAD} ${UNIDADE} telecom000
			ULTIMA=$?
			if [ ${ULTIMA} -ne 0 ]; then
				echo "${TIMESTAMP} - ERRO AO REINICIAR EQUIPAMENTO ${UNIDADE}!" | tee -a ${HOME_}/aps.log
			else
				echo "${TIMESTAMP} - EQUIPAMENTO ${UNIDADE} REINICIADO COM SUCESSO!" | tee -a ${HOME_}/aps.log
			fi
		fi
		sleep 10	
	done
else
	echo "Arquivo de parametros ${ARGUMENTO} não existe ou inacessível"
fi
}

case "${ARGUMENTO}" in
        -h|--help)
                ajuda_;
                ;;
        *)
                arruma_param_;
                ;;
esac
