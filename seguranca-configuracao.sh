#!/bin/bash
##########################################################################################################################
###
###		Programa de estudo de shellscript com a finalidade de desenvolver um ou mais scripts que
###						automatizam a configuração de um ambiente pessoal
###
###
###		Data de início: 09/01/18
###		Data da última modificação: 13/01/18
###		Desenvolvido por Giuliana
###		Script: seguranca-configuracao.sh
###		Comentário: Após instalar os programas básicos e inserir a chave rsa no gitlab e github, agora é hora de 
###		configurar as chaves criptograficas e chaveiro de seguranca
###		sugestão de melhoria: separar em funcoes e garantir que não prossiga enquanto nao resolva erros
###
###
##########################################################################################################################

#Incluindo o souce .env para as variaveis de ambiente
source .env

echo "---"
echo "Configurando git com config user.email e user.name"
git config --global user.email $EMAIL_GIT
git config --global user.name $USUARIO_GIT

echo " "
echo "---"
echo " Decriptando a chave $ARQUIVO_PASS_SIMETRICO. Insira a senha simetrica"
gpg2 --batch --yes -d $ARQUIVO_PASS_SIMETRICO | gpg2 --batch --yes --allow-secret-key-import --import 

echo " "
echo "---"
echo "Criando um novo repositorio pass com a chave exportada de $ARQUIVO_PASS_SIMETRICO"
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
echo "Decriptografando chave privada $ARQUIVO_GPG_SIMETRICO"
gpg2 --passphrase `pass $CAMINHO_SENHA_PASS_GPG_PRIVADO` --batch --yes -d $ARQUIVO_GPG_SIMETRICO |gpg2 --batch --yes --allow-secret-key-import --import 

echo " "
echo "Configurando a confibilidade da chave $ARQUIVO_PASS_SIMETRICO"
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key $ENDERECO_EMAIL_GPG_PASS
echo " "
echo "Configurando a confiabilidade da chave $ARQUIVO_GPG_SIMETRICO"
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key $ENDERECO_EMAIL_GPG_PRIVADO

echo " "
echo "---"
echo "Deletando arquivos sensíveis"
rm *.sec.asc
