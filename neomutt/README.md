# Dependências 

O `neomuttrc` necessita de arquivos, variáveis de ambiente e diretórios para
que funcione corretamente.


## Arquivos
Quanto aos arquivos, o `neomuttrc` depende ao todo de 5 arquivos para ser configurado
corretamente:

1. `secret.fish` e `secretneomuttrc`
Armazena os segredos a serem usados pelo `oauth.fish` e pelo `neomuttrc`,
respectivamente

O arquivo `secret.fish` contém mais especificamente ao todo 4 chaves (2 do
Google e 2 da Microsoft)

Esses dois arquivos precisam ser criados e guardados com cuidado no seu
computador

As 2 chaves do Google (**client id** e **client secret**) podem ser obtidas
pelo [Google Cloud](https://console.cloud.google.com/?hl=en)

As 2 chaves da Microsoft (**client id** e **client secret VALUE**) podem ser
obtidas pela [Azure](https://azure.microsoft.com/en-us/)

Informações detalhadas de como gerar as chaves para cada um dos dois casos
mais abaixo

Já o arquivo `secretneomuttrc` contém ao todo 3 chaves (3 do Google)

2 das 3 chaves são as mesmas daquelas do `secret.fish`. Já a terceira,
consiste no **refresh token**, que é explicado como ser obtido mais abaixo.


2. `mutt_oauth2.py`
Esse script obtém o token de acesso e o token de refresh do OAuth2.0 para o Outlook

Pode ser baixado de um repositório confiável de autoria do próprio time do
[Neomutt no Github](https://github.com/neomutt/neomutt/blob/main/contrib/oauth2/mutt_oauth2.py)

Esse arquivo também pode ser encontrado no path `/usr/share/neomutt/` num
sistema UNIX que tenha o neomutt instalado

Diferentemente do `oauth2.py`, o arquivo `mutt_oauth2.py` necessita de uma
alteração para que funcione pelo método de autorização escolhido (devicecode). O patch
consiste em adicionar as seguintes linhas de código:
```python
        if 'client_secret' not in list(registration.keys()):
            registration['client_secret'] = input("'client_secret' not found in registration. Please enter it: ")
```
nessa parte do arquivo `mutt_oauth.py`:
```python
...
elif authflow == 'devicecode':
        try:
            response = urllib.request.urlopen(registration['devicecode_endpoint'],
                                              urllib.parse.urlencode(p).encode())
        except urllib.error.HTTPError as err:
            print(err.code, err.reason)
            response = err
        response = response.read()
        if args.debug:
            print(response)
        response = json.loads(response)
        if 'error' in response:
            print(response['error'])
            if 'error_description' in response:
                print(response['error_description'])
            sys.exit(1)
        print(response['message'])
        del p['scope']
        # THE TWO FOLLOWING LINES OF CODE WERE ADDED BY ME
        # (cd_vieira@hotmail.com) IN ORDER TO MAKE
        # 'devicecode' WORK
        if 'client_secret' not in list(registration.keys()):
            registration['client_secret'] = input("'client_secret' not found in registration. Please enter it: ")
        p.update({'grant_type': 'urn:ietf:params:oauth:grant-type:device_code',
                  'client_secret': registration['client_secret'],
                  'device_code': response['device_code']})
        interval = int(response['interval'])
        print('Polling...', end='', flush=True)
        while True:
            time.sleep(interval)
            print('.', end='', flush=True)
...
```

3. `oauth2.py`
Script que obtém o token de acesso e o token de refresh do OAuth2.0 para o Gmail

O arquivo `oauth2.py` pode ser baixado de um repositório de autoria do [Google no
Github](https://github.com/google/gmail-oauth2-tools/blob/master/python/oauth2.py)

Esse arquivo já foi testado e funciona bem

4. `oauth2.fish`

Script que automatiza os comandos na CLI necessários para obter a
autorização e os tokens (de acesso e refresh) para logar no Gmail e Outlook


### Gerando as chaves pelo Google Cloud
Para criar as chaves pelo Google Cloud, siga as instruções:
1. Acesse o [Google Cloud](https://console.cloud.google.com/?hl=en)
2. Logue com a conta Google que deseja ter acesso ao Gmail
3. Crie o seu primeiro projeto
> Escolha um nome que tenha a ver com o **neomutt** para identifica-lo mais facilmente

> Não há necessidade de escolher uma organização/instituição
4. Com o projeto criado, acesse-o e entre na página de **APIs and Services**
5. Na aba lateral, selecione a seção de **Credentials** e crie uma nova credential
   do tipo **OAuth Client ID**
> Como **application type** escolha **Web application**

> Escolha um nome que tenha a ver com o **neomutt**

> Na parte de **Authorized redirect URIs**, adicione uma nova URI que tenha
> como valor o mesmo da variável `REDIRECT_URI` contida no script `oauth2.py`
>> Essa variável tem como valor: `https://oauth2.dance/`

> Após você criar essa credencial, você passará a ter acesso ao **client id**
> e ao **client secret**
6. Agora, na aba lateral, selecione a seção **OAuth consent screen** e crie um
   recurso desse tipo
> Cadastre o seu email do gmail como usuário de teste (just in case)
7. Crie as variáveis `GMAIL_CLIENT_ID` e `GMAIL_CLIENT_SECRET` no arquivo
   `secret.fish` e as variáveis `my_gmail_client_id` e
`my_gmail_client_secret` no arquivo `secretneomuttrc`


### Gerando as chaves pelo Azure
1. Acesse a [Azure](https://azure.microsoft.com/en-us/)
2. Logue com algum email
3. Uma vez logado, pesquise na aba de pesquisa por 'App Registrations'
4. Crie um novo 'App Registration'
> Escolha um nome que tenha a ver com o **neomutt** para identifica-lo mais facilmente

> Escolha a opção `Accounts in any organization directory and personal Microsoft accounts`

> Como `Redirect URI` coloque o mesmo valor da variável
> `registrations['microsoft']['redirect_uri']` contida no código
> `mutt_oauth.py`
>> O Redirect URI na verdade não será utilizado como método de autenticação
>> pelo script `oauth.fish`, que na verdade opta pelo método `devicecode`.
>> Assim foi feito, porque o método `authcode` (que utiliza o Redirect URI)
>> não retorna um refresh token válido, indicando algum erro de
>> configuração/permissão
5. Acesse a página do App criado e na seção **Branding & properties** coloque
   o nome do seu aplicativo criado
6. Acesse agora a seção **Authentication** e habilite as opções
[ ] `Access tokens`
[ ] `ID tokens`
E também coloque como **yes** a opção `Allow public client flows`

7. Acesse agora a seção **Certificates & secrets**, crie um novo **client
   secret** e anote o **SECRET VALUE ID**
> Preste atenção para não anotar o **Secret ID**. Nesse momento você quer
> anotar o **Secret VALUE ID**!

8. Acesse a seção **API Permissions** na barra lateral e adicione as seguintes
   opções do **Microsoft Graph**, Type: **Delegated** para seu App:
[X] `IMAP.AccessAsUser.All`
[X] `offline_access`
[X] `POP.AccessAsUser.All`
[X] `SMTP.Send`
[X] `User.Read`

9. Acesse a seção **Overview** e anote o **Application (Client) ID**
10. Com o **Client ID** e o **Secret VALUE ID** em mãos, preencha o arquivo
   `secret.fish` com as variáveis `OUTLOOK_CLIENT_ID` e
`OUTLOOK_CLIENT_SECRET_VALUE`

```fish
# exemplo do arquivo secret.fish
#!/usr/bin/fish

...
set -x OUTLOOK_CLIENT_ID <application/client_id>
set -x OUTLOOK_CLIENT_SECRET_VALUE <client_secret_value>
```

### Gerando o refresh token para acesso do Gmail
Para obter o refresh token, que deverá ser colocado também no arquivo
`secretneomuttrc`:
1. Abra o arquivo `oauth2.fish`, comente a chamada da função `outlook` e
   descomente a chamada da função `gmail`
2. Rode o script `./oauth2.fish`

O script pedirá que você abra um link no seu navegador, que irá se encarregar
de disparar a rotina de autorização do Google para o seu client id.

Uma vez autorizado, o terminal irá exibir o seu **access token** bem como o
seu **refresh token**

Uma vez obtido o **refresh token**, coloque o no arquivo `secretneomuttrc`
como comentado anteriormente.


### Gerando o arquivo `$OUTLOOK.tokens` para acesso do Outlook
Diferentemente da gambiarra do `secret.fish` e `secretneomuttrc`, o script do
outlook utiliza encriptação utilizando o `gpg` para armazenar o refresh token
obtido em um arquivo com o formato `$OUTLOOK.tokens`

Isso requer que você crie um par chave pública-privada pelo `gpg`, o que pode
ser feito da seguinte forma:
```bash
gpg --gen-key
```

Ao gerar a sua chave pública, modifique o arquivo `oauth2.fish` e coloque o
identificador da chave criada na opção `--encryption-pipe`

Além disso, é necessário que a variável de ambiente `$GPG_TTY` já esteja
configurada e presente no SHELL nesse momento. Portanto, crie/set essa
variável e reinicie o terminal para certificar-se que ela estará presente.

Uma vez que o GPG tenha sido configurado, prossiga para obter o refresh token do outlook:
1. Abra o arquivo `oauth2.fish`, descomente a chamada da função `outlook` e
   comente a chamada da função `gmail`
2. Rode o script `./oauth2.fish`
> Em caso de erro, delete o arquivo `$OUTLOOK.tokens` caso ele tenha sido
> criado anteriormente

O script fornecerá um código e pedirá que você abra um link no seu navegador,
onde será solicitado que você entre na sua conta da Microsoft e coloque o
código gerado no terminal.

Além disso, o patch feito logo após baixar esse arquivo (que corrige um erro nesse momento do tutorial), 
faz o script solicitar que você entre (novamente) com o **client secret
value** (que está contido no arquivo `secret.fish` a essa altura)

Uma vez que você tenha entrado o código solicitado no navegador, logado com a
sua conta da Microsoft e fornecido novamente o **client secret value**, o
script irá gerar um **access token** para que você possa logar no Outlook pelo
neomutt
> Na verdade esse access token não é diretamente usado por nenhum
> script/arquivo aqui presente. Portanto, não é necessário anota-lo nem nada
> do tipo

Após gerar o arquivo $OUTLOOK.tokens, será possível utiliza-lo para refrescar o
**access token** a ser usado pelo neomutt para acessar o servidor imap do
outlook. Para isso, é necessário rodar no terminal o código abaixo uma vez:
```
python mutt_oauth2.py --authflow authcode {EMAIL_OUTLOOK}.tokens --authorize
```

Após isso, é necessário definir o comando que será usado pelo neomutt para
refrescar constantemente o **access token** durante a execução do programa.
Isso pode ser feito como segue:
```
set imap_oauth_refresh_command = "python $my_config_neomutt/mutt_oauth2.py --authflow authcode $my_config_neomutt/$OUTLOOK.tokens" ; \
```


## Variáveis
Quanto às variáveis, o `neomuttrc` necessita que as seguintes variáveis de ambiente
estejam disponíveis:
* `$HOME`
* `$GMAIL`
> Armazena o email do gmail
* `$OUTLOOK`
> Armazena o email do outlook
* `$GPG_TTY`
> Usado pelo script `mutt_oauth.py`
>> `set -x GPG_TTY "$(tty)"`


## Diretórios
Quanto aos diretórios, o `neomuttrc` necessita que os seguintes diretórios
estejam disponíveis:
1. `~/.cache/neomutt/header`
> cache dos headers das mensagens dos emails
2. `~/.cache/neomutt/body`
> cache dos bodys das mensagens dos emails
3. `~/.config/neomutt`
> symbolic link para `~/dotfiles/neomutt/neomutt`


# Obtendo o arquivo de keybindings do vim
O modelo do arquivo de keybindings do vim usado pode ser encontrado em
`/usr/share/neomutt/vim-keys`

Caso seja de interesse, copie o arquivo e o coloque na mesma pasta do
`neomuttrc`
> Lembre-se de atualizar o `neomuttrc` com o novo caminho até o arquivo de
> keybindings do vim


# Obtendo os arquivos de colorscheme
Os arquivos de colorscheme podem ser encontrados em
`/usr/share/neomutt/colorschemes`

Caso seja de interesse, copie o arquivo e o coloque na mesma pasta do
`neomuttrc`
> Lembre-se de atualizar o `neomuttrc` com o novo caminho até o arquivo de
> colorscheme


# Possíveis evoluções
* Substituir o `secret.fish` e o `secretneomuttrc` por um arquivo encrypted
  que guarde as chaves/tokens de autenticação necessários (usar `gpg`)
* Comentar que também é necessário habilitar a opção de usar clients IMAP e
  POP nas configurações do Gmail (e possivelmente do Outlook?)
