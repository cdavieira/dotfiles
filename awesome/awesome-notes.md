# awesome

Primeiramente, instale o [xorg](https://wiki.archlinux.org/title/Xorg), alguns
programas auxiliares e o awesome

```sh
pacman -S xorg-server xf86-video-nouveau xorg-setxkbmap xorg-server-xephyr awesome
# create a link to my awesome config
ln -s ~/dotfiles/awesome -t ~/.config/ -v
```

---

## Como debugar o awesome usando Xephyr?

Comando:
```bash
Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome -c ~/.config/awesome/rc.test.lua
```

Para estabelecer foco na janela gerada:
1. posicionar o cursor do mouse dentro dela
2. digitar `<Ctrl>` + `<Shift>`

É possível colocar prints dentro do script lua e observar os resultados no terminal

O comando `awesome --check /path/to/rc.lua` pode ser usado para checar erros
de sintaxe do arquivo de config.

Esse comando funciona bem para edições simples feitas no arquivo de config,
pois exclui a necessidade de usar o Xephyr

---

## Sobre os widgets usados no awesome

Também aprendi que um widget possui vários setters, ainda que esses não
apareçam documentados de forma explicita na documentacao do awesome.

o wibox é um "objeto" (em lua são do tipo 'table') que contem como um de seus
atributos um widget.  O widget em si é algo que requer implementação. Cada
widget pode apresentar propriedades diferentes. Para acessar as diferentes
propriedades de um widget é necessário definir o atributo 'widget' com a
implementação do widget a ser usada (exemplo:: widget =
wibox.widget.progressbar). Desse modo, sera possível especificar diferentes
atributos, que variam conforme o widget escolhido.

É preciso se atentar ao tipo de dado que diferentes atributos podem ser. Por
exemplo, descobri que o widget de texto apresenta um atributo que é do tipo
'pango markup', permitindo usar uma notação parecida com html para definir
propriedades como cor, negrito, italico entre outros.

o awful.widget.watch também se mostrou uma forma relativamente simples de criar
widgets que se auto atualizam, seu uso foi tranquilo de compreender seguindo o
site

---

## Significado dos simbolos que aparecem na barra superior das janelas:

* aviaozinho: `<Ctrl>` + `<Super>` + `<Space>`
* setinha para cima e para baixo: `<Ctrl>` + `<Super>` + `m`
* setinha para esquerda e para direita: `<Shift>` + `<Super>` + `m`
* `+`: `<Super>` + `m`

---

## Sobre as diferentes formas de executar comandos no awesome e mapear comandos

* Existem algumas formas diferentes de executar um comando no awesome:
1. `awesome.utils.spawn`
2. `awesome.utils.spawn.with_shell`
3. `awesome.utils.spawn.easy_async`
4. `awesome.utils.spawn.easy_async_with_shell`

A diferença entre os metodos marcados com e sem `async` é que o `async`
permite que o comando seja executado de maneira assincrona, o que é desejavel
para não travar o processo que executa o próprio `awesome`

A diferença entre os metodos marcados com e sem `with_shell` é que o
`with_shell` faz o awesome executar um certo comando como se tivesse rodado
`$SHELL -c <comando>`.

A execução sem shell é preferível quando se quer executar um programa que não
leva parâmetros/opções/flags/variáveis de ambiente, por exemplo `ls` ou
`gnome-screenshot`. Nesses casos, a nao execucao de um shell economiza um
pouco de memoria e processamento.

Para os demais casos, opte pelo metodo `with_shell`, já que é mais garantido
que funcione caso parâmetros/opções/variáveis de ambiente sejam passados pela
commandline

Além disso, é importante lembrar que um shell normalmente se encarrega de
realizar expansão de variáveis, então isso também pode ser um fator a ser
considerado quando se deseja evitar essa funcionalidade

---

## Como configurar temporariamente o layout do teclado para pt-br?

Para configurar temporariamente o layout do teclado para o formato brasileiro,
utilize o seguinte comando:
```
setxkbmap -rules evdev -model pc105 -layout br
```

---

## Como configurar automaticament eo layout do teclado para pt-br?

```sh
# obtenha as configurações de layout setadas após configuração manual do layout
setxkbmap -query
# crie um arquivo-hook no diretorio de configuração do xorg para definir as opções listadas no comando anterior
cd /etc/X11/xorg.conf.d
sudo nvim 80-mykbmap.conf
```
> [refer to Xorg's documentation on how to configure the keyboard using a `.conf` file](https://www.x.org/releases/X11R7.7/doc/xorg-docs/input/XKB-Config.html)*

```
# /etc/X11/xorg.conf.d

Section "InputClass"
    Identifier "br keyboard"
    MatchIsKeyboard "on"

    Option "XkbRules" "evdev"
    Option "XkbModel" "pc105"
    Option "XkbLayout" "br"
    Option "XKbOptions" ""
EndSection
```
> *`Identifier` is obligatory and it must be an unique name*
> *`MatchIsKeyboard` identifies this Section as being associated with a keyboard*
> *All remaining `Options` (except the layout) were taken from the output of `setxkbmap -query` *


---

## Outras referências
* [FAQ compressivo do awesome](https://awesomewm.org/doc/api/documentation/90-FAQ.md.html)
* [awesome - Website](https://awesomewm.org/)
* [awesome - ArchWiki](https://wiki.archlinux.org/title/Awesome)
