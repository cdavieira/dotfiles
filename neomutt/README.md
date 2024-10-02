# Quick guide to setup Gmail and Outlook for neomutt

## set gpg and pass
```bash
gpg --gen-key
pass init "Carlos Vieira"
```

## setup environment variables
```fish
# $XDG_CONFIG_HOME/config.fish

# set -x HOME $HOME
set -x GMAIL <your_gmail> 
set -x OUTLOOK <your_outlook> 
set -x GPG_TTY $(tty)
```
> `GPG_TTY` is required by `mutt_oauth.py` (Outlook)

## setup directories
```bash
mkdir ~/.cache/neomutt/{,body,header}
ln -s ~/.config /path/to/dotfiles/neomuttdir
```
1. `~/.cache/neomutt/header`
> cache dos headers das mensagens dos emails
2. `~/.cache/neomutt/body`
> cache dos bodys das mensagens dos emails
3. `~/.config/neomutt`
> symbolic link para `~/dotfiles/neomutt`


---

## Gmail
1. Download [oauth2.py (Gmail) - Github](https://github.com/google/gmail-oauth2-tools/blob/master/python/oauth2.py)

2. Get `client_id` and `client_secret` in [Google Cloud](https://console.cloud.google.com/?hl=en)

if you had already created an application and configured its credentials:
    * on the top bar click on `Console` 
    * on the top bar select the project for your application (neomutt1 in my case)
    * on the quick access menu click in `APIs & Services`
    * on the leftsidebar click on `Credentials`
    * on the `OAuth 2.0 Client IDs` menu click on your application credentials
    * on the right you'll find the `client_id` and `client_secret` for your app, save both

otherwise:
    * on the top bar click on `Console` 
    * on the top bar create a new application project named neomutt (for example)
> no need to choose an organization
    * on the top bar select the recently created project
    * on the quick access menu click in `APIs & Services`
    * on the leftsidebar click on `Credentials` and create a new one
        * **application type**: **Web application**
        * **name**: **neomuttWeb** (or whatever)
        * **Authorized redirect URIs**: https://oauth2.dance/
    * now you'll find the `client_id` and `client_secret` for your app, save both
    * on the leftsidebar click on `OAuth consent screen` and create such a resource
> submit your own email as a test user (just in case)

3. Allow the use of IMAP and POP clients in Gmail
> Steps?

4. run
```bash
# paste the client_id when prompted to
pass insert mutt/gmail_client_id
# paste the client_secret when prompted to
pass insert mutt/gmail_client_secret

# open the link in your browser, copy the token generated and paste it on the terminal when prompted to
python ./oauth2.py --user=$GMAIL --client_id=(pass mutt/gmail_client_id) --client_secret=(pass mutt/gmail_client_secret) --generate_oauth2_token`

# save the access_token and refresh_token

# paste the refresh_token when prompted to (this is permanent)
pass insert mutt/gmail_refresh_token
# paste the access_token when prompted to (this is temporary)
pass insert mutt/gmail_access_token
```

---

## Outlook
1. Obter [mutt_oauth2.py (Outlook) - Github](https://github.com/neomutt/neomutt/blob/main/contrib/oauth2/mutt_oauth2.py)
> também pode ser encontrado em `/usr/share/neomutt`

É necessário aplicar o seguinte patch para que o código funcione:
```python
...
elif authflow == 'devicecode':
        try:
            response = urllib.request.urlopen(registration['devicecode_endpoint'],
                                              urllib.parse.urlencode(p).encode())
        ...
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
...
```

2. Get `client_id` and `client secret VALUE` in [Azure](https://azure.microsoft.com/en-us/)
    * login with your email
    * in the [homepage](https://portal.azure.com/#home), search for `App
      registrations` either in the searchbar or in the `Azure services` quick
      menu in the bottom

if you had already created an application and configured its credentials:
    * on the list of apps, click on your Application (neomuttClient for me)
    * here you will find the **Application (client) ID**, save it
    * click on `Client credentials`
    * delete any previously created Client secrets
    * click on `New client secret` and create a new one
        * Description: neomuttClient
    * now the **Application (client) secret VALUE** will be visible for as
      long as you stay in this page. Save the **VALUE** number (**NOT** the Secret
      ID).

otherwise:
    * click on `New Registration` in order to create a new App Registration
        * Name: **neomutt**
        * Select `Accounts in any organization directory and personal Microsoft accounts`
        * Redirect URI: `registrations['microsoft']['redirect_uri']` from `mutt_oauth.py`
> The Redirect URI isn't actually used, since i opted for the devicecode
> authentication method to be used in `mutt_oauth.py`
    * go back to the `App registrations` page and click on your just created App
    * on the `Branding & properties` page, write your application name
    * on the `Authentication` page, enable the boxes for `Access tokens` and `ID Tokens`
    * still on the `Authentication` page, write *yes* for `Allow public client flows`
    * on the `Certificates & secrets` page, create a new client secret and
      save the **Secret VALUE ID** which will be displayed for as long as you
      stay in this page
    * on the `API Permissions` page, enable the following options for
      **Microsoft Graph** (Type: Delegated): `IMAP.AccessAsUser.All`, `offline_access`,
      `POP.AccessAsUser.All`, `SMTP.Send`, `User.Read`
    * on the `Overview` page, save your **Application (Client) ID**

3. Allow the use of IMAP and POP clients in Outlook
> Steps?

4. run:
```bash
# paste the client_id when prompted to
pass insert mutt/outlook_client_id

# paste the client_secret when prompted to
pass insert mutt/outlook_client_secret

# open the link in your browser, copy the token generated and paste it on the terminal when prompted to
python mutt_oauth2.py "$OUTLOOK.tokens" \
        --verbose \
        --authorize \
        --provider microsoft \
        --encryption-pipe "gpg --encrypt --default-recipient-self" \
        --email $OUTLOOK \
        --client-id (pass mutt/outlook_client_id) \
        --client-secret (pass mutt/outlook_client_secret) \
        --authflow devicecode

# only the access_token is generated, perhaps not worth saving it
```
