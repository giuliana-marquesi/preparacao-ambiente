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

echo "---"
echo "Configurando git com config user.email e user.name"
git config --global user.email "giuliana@riseup.net"
git config --global user.name "Giuliana Marquesi"

echo " "
echo "---"
echo " Decriptando a chave kukinho. Insira a senha simetrica"
cd $HOME
gpg --batch --yes -d kukinho.sec.asc | gpg --batch --yes --allow-secret-key-import --import 

echo " "
echo "---"
echo "Criando um novo repositorio pass com a chave do kukinho"
pass init 7EF4651CE7C75C90BF80A93F10683B87A56CE5B6
echo " "
echo "Iniciando um repositorio git no pass"
pass git init
echo " "
echo "Inserindo endereco de origem"
pass git remote add origin git@gitlab.com:giuliana-marquesi/pass-store.git
echo " "
echo "populando o chaveiro"
pass git pull -r origin master

echo " "
echo "---"
echo "Decriptografando chave privada riseup"
gpg --passphrase `pass seguranca/chaves-gpg/giuliana@riseup-simetrico` --batch --yes -d riseup.sec.asc | gpg --batch --yes --allow-secret-key-import --import 

echo " "
echo "Configurando a confibilidade da chave kukinho"
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key email@email.com
echo " "
echo "Configurando a confiabilidade da chave riseup"
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key giuliana@riseup.net

echo " "
echo "---"
echo "Deletando arquivos sensíveis"
rm *.sec.asc
