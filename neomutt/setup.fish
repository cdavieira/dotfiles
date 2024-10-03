#!/usr/bin/fish

function download_gmail_script
	set gmail_script "https://github.com/google/gmail-oauth2-tools/blob/master/python/oauth2.py"
	set target "oauth2.py"

	if test -e $target
		echo "File $target already exists in $(pwd)"
		return
	end

	curl $gmail_script
	echo "File $target is now available at $(pwd)"
end

function download_outlook_script
	set outlook_script "https://github.com/neomutt/neomutt/blob/main/contrib/oauth2/mutt_oauth2.py"
	set target "mutt_oauth2.py"

	if test -e $target
		echo "File $target already exists in $(pwd)"
		return
	end

	curl $outlook_script
	echo "File $target is now available at $(pwd)"
end

function cp_vimkeys_rc
	cp /usr/share/neomutt/vim-keys/vim-keys.rc .
	mv vim-keys.rc vimkeys.rc
	echo "vimkeys.rc is now available at $(pwd)"
end

function cp_theme
	set theme "vombatidae.neomuttrc"
	cp /usr/share/neomutt/colorschemes/$theme .
	echo "theme $theme is now available at $(pwd)"
end

function setup_gmail
	python ./oauth2.py \
		--user=$GMAIL \
		--client_id=(pass mutt/gmail_client_id) \
		--client_secret=(pass mutt/gmail_client_secret) \
		--generate_oauth2_token
end

function setup_outlook
	python mutt_oauth2.py "$OUTLOOK.tokens" \
					--verbose \
					--authorize \
					--provider microsoft \
					--encryption-pipe "gpg --encrypt --default-recipient-self" \
					--email $OUTLOOK \
					--client-id (pass mutt/outlook_client_id) \
					--client-secret (pass mutt/outlook_client_secret) \
					--authflow devicecode
end

#download_gmail_script
#download_outlook_script
#cp_vimkeys_rc
#cp_theme
#setup_gmail
#setup_outlook
