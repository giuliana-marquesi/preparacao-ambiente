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

Baixar o conteudo deste diretório

- Pode ser baixando os arquivos manualmente ou copiando
- Ou usando o git clone tanto http ou git

## Ordem sugerida de scripts

1 - pacotes-base

2 - seguranca-configuracao

3 - dotfiles

4 - pacotes-graficos

5 - xfce-teclado
