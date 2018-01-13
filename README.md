# Scripts de instalação de ambiente pessoal

Não são muitos passos para iniciar

## Chaves ssh

É preciso gerar e inserir uma nova chave ssh no gitlab para que dê certo

```
ssh-keygen -t rsa -C "your.email@example.com" -b 4096

```

Para copiar sem dramas

```
xclip -sel clip < ~/.ssh/id_rsa.pub
```

## Baixar o conteudo deste diretório

- Pode ser baixando os arquivos manualmente ou copiando
- Ou usando o git clone tanto http ou git

## Alterar arquivo .env.exemplo

É necessario ter um arquivo .env, para isso basta copiar o arquivo .env.exemplo para .env e
alterando seu conteúdo

```
	cp .env.exemplo .env

```
## Possuir as chaves privadas referentes ao pass e ao email privado

É necessario duas chaves privadas encriptogrfadas simmetricamente.

Elas devem estar no mesmo diretorio clonado

## Ordem sugerida de scripts

1 - pacotes-base

2 - seguranca-configuracao

3 - dotfiles - Neste passo, deve-se ir no diretório dot e executar o arquivo **configurador.sh**

4 - pacotes-graficos
