#!/bin/bash
##########################################################################################################################
###
###		Programa de estudo de shellscript com a finalidade de desenvolver um ou mais scripts que
###						automatizam a configuração de um ambiente pessoal
###
###
###		Data de início: 30/12/17
###		Data da última modificação: 23/04/18
###		Desenvolvido por Giuliana
###		Script: pacotes-base.sh
###		Comentário: É o primeiro script. Espero separar em módulos, pois não precisarei fazer sempre
###					TUDO.
###
###
###
######################################################################################################################

# A lista dos pacotes basicos a serem instalados
#
pacotes=("vim" "tmux" "git" "bash-completion" "pass" "mutt" "pandoc" "i3status" "tmate" "gnupg" "xclip")

#Criando um logfile
#
logfile=".pacotes-base.log"

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

# Agora vem as instalações
#
for pac in ${pacotes[@]}
do
	if [ ! -e "/bin/$pac" ]
	then
		echo " "
		if ! $c_instalador $pac >> $logfile
		then
			echo "!!!--- Não instalado: $pac"
		else
			echo "Instalado: $pac"
		fi
	else
		echo " "
		echo "+++ $pac já está instalado"
	fi
done
