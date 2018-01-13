#! /bin/bash

DOT_PROGRAMAS=('.tmux.conf' '.vimrc' 'i3status.conf' '.muttrc' '.muttrc-local')
DOT_DIRETORIOS=('.vim' '.mutt')
INICIO_CAMINHO=`pwd`

for prog in ${DOT_PROGRAMAS[@]}
do
	echo "--------------------------------------------"
	echo "	gerando link para $prog"
	echo "--------------------------------------------"
	
	caminho=$INICIO_CAMINHO"/"$prog
	
	if [ $prog != "i3status.conf" ]
	then
		rm ~/$prog
		ln $caminho ~/$prog
	else
		sudo rm /etc/i3status.conf
		sudo ln -s $caminho /etc/$prog
	fi
done

for diretorio in ${DOT_DIRETORIOS[@]}
do
	echo "--------------------------------------------"
	echo "	gerando link para o diretório $diretorio "
	echo "--------------------------------------------"

	rm -rf ~/$diretorio
	cp -rf $INICIO_CAMINHO"/"$diretorio $HOME"/"$diretorio
done

echo "--------------------------------------------"
echo "	Configurando o bashrc para que inicie com TMUX"
echo "--------------------------------------------"

echo '[[ $- != *i* ]] && return' >> ~/.bashrc
echo '[[ -z "$TMUX" ]] && exec tmux' >> ~/.bashrc
