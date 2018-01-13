#!/bin/bash
##########################################################################################################################
###
###		Programa de estudo de shellscript com a finalidade de desenvolver um ou mais scripts que
###						automatizam a configuração de um ambiente pessoal
###
###
###		Data de início: 09/01/18
###		Data da última modificação: 11/01/18
###		Desenvolvido por Giuliana
###		Script: seguranca-configuracao.sh
###		Comentário: Após instalar os programas básicos e inserir a chave rsa no gitlab e github, agora é hora de 
###		configurar as chaves criptograficas e chaveiro de seguranca
###
###
###
##########################################################################################################################

#Incluindo o souce .env para as variaveis de ambiente
source .env

echo "---"
echo "Configurando git com config user.email e user.name"
git config --global user.email "giuliana@riseup.net"
git config --global user.name "Giuliana Marquesi"

echo " "
echo "---"
echo " Decriptando a chave kukinho. Insira a senha simetrica"
cd $HOME
gpg --batch --yes -d $ARQUIVO_PASS_SIMETRICO | gpg --batch --yes --allow-secret-key-import --import 

echo " "
echo "---"
echo "Criando um novo repositorio pass com a chave do kukinho"
pass init $IDENTIFICADOR_GPG_PASS 
echo " "
echo "Iniciando um repositorio git no pass"
pass git init
echo " "
echo "Inserindo endereco de origem"
pass git remote add origin $ORIGEM_GIT_PASS 
echo " "
echo "populando o chaveiro"
pass git pull -r origin master

echo " "
echo "---"
echo "Decriptografando chave privada riseup"
gpg --passphrase `pass $CAMINHO_SENHA_PASS_GPG_PRIVADO` --batch --yes -d $ARQUIVO_GPG_SIMETRICO | gpg --batch --yes --allow-secret-key-import --import 

echo " "
echo "Configurando a confibilidade da chave kukinho"
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key $ENDERECO_EMAIL_GPG_PASS
echo " "
echo "Configurando a confiabilidade da chave riseup"
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key $ENDERECO_EMAIL_GPG_PRIVADO

echo " "
echo "---"
echo "Deletando arquivos sensíveis"
rm *.sec.asc