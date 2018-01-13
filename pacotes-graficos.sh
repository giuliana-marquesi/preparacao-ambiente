#!/bin/bash
##########################################################################################################################
###
###		Programa de estudo de shellscript com a finalidade de desenvolver um ou mais scripts que
###						automatizam a configuração de um ambiente pessoal
###
###
###		Data de início: 13/01/2018
###		Data da última modificação: 13/01/2018
###		Desenvolvido por Giuliana
###		Script: pacotes-graficos.sh
###		Comentário: Script de instalação de pacotes usados em modo gráfico e um diretorio do gitlab
###
###
###
######################################################################################################################

#
# Carregando as variaveis de ambiente
#
source .env

# Iniciada a lista vazia para a escolha dos programas
#
escolhas=()

#Criando um logfile
#
logfile="pacotes-graficos.log"

# É necessário saber qual é a base de distribuição usada. Preferi usar uma variavel pra não haver
# confusoes
#
echo "-----------------------------------------------"
echo "Qual é a base da distribuição?"
read base_distro

if [ $base_distro == "debian" ]
then
	c_instalador="apt-get install -y"
	# atualizando no debian
	echo "			----- "
	echo "Atualizando antes das instalações"
	echo " "
	echo Atualizando repositórios..
	if ! apt-get update
	then
    	echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    	exit 1
	fi
	echo "Atualização feita com sucesso"
	#
	echo "Atualizando pacotes já instalados"
	if ! apt-get dist-upgrade -y
	then
    	echo "Não foi possível atualizar pacotes."
	    exit 1
	fi
	echo "Atualização de pacotes feita com sucesso"
elif [ $base_distro == "arch" ]
then
	c_instalador="yaourt -S --noconfirm"
	# atualizando no arch
	echo "			----- "
	echo "Atualizando antes das instalações"
	echo " "
	if ! sudo pacman -Syu --noconfirm
	then
		echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    	exit 1
	fi
	echo "Atualização feita com sucesso"
	#instalando yaourt
	echo "			----- "
	echo "		Instalando yaourt"
	echo " "
	if ! sudo pacman -S yaourt --noconfirm >> $logfile
	then
		echo "Não foi possível instalar yaourt."
    	exit 1
	fi
	echo "Yaourt instalado com sucesso"
else
	echo "			+++++ "
	echo "Não é nenhuma das opções: debian ou arch"
	echo " "
	exit
fi

#Menu para a escolha dos pacotes a serem instalados
echo "Escolha quais programas deseja instalar separando espaco em cada numero e depois dê enter"
  echo "------------------------------------------"
  echo "Opções:"
  echo
  echo "1. Libreoffice"
  echo "2. Calibre"
  echo "3. VLC"
  echo "4. GIMP"
  echo "5. Inkscape"
  echo "6. Virtualbox"
  echo "7. Diretório trocas"
  echo
  echo -n "Quais são as opções desejadas? "
  read escolhas
  
# Agora vem as instalações
#
# Iterar sobre a lista de escolhas e depois passar por um case que direciona o que deve ser feito
for num in ${escolhas[@]}
do
	case $opcao in
		1) instalar 'libreoffice' ;;
		2) instalar 'calibre' ;;
		3) instalar 'vlc' ;;
		4) instalar 'gimp' ;;
		5) instalar 'inkscape' ;;
		6) instalar 'virtualbox' ;;
		7) cd ~/Documentos && git clone $ORIGEM_GIT_TROCAS ;;
	esac
done

instalar() {
	if [ ! -e "/bin/$pac" ]
	then
		echo " "
		if ! $c_instalador $1 >> $logfile
		then
			echo "!!!--- Não instalado: $1"
		else
			echo "Instalado: $1"
		fi
	else
		echo " "
		echo "+++ $1 já está instalado"
	fi
}
	