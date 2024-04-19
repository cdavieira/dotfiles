#!/usr/bin/fish

# this file provides all client_id and client_secret variables used in this
# script
#
# keep it with you and don't upload it to a repository by any means

source secret.fish

function gmail
	python oauth2.py --user=$GMAIL \
			--client_id=$GMAIL_CLIENT_ID \
			--client_secret=$GMAIL_CLIENT_SECRET \
			--generate_oauth2_token
end

function outlook
	python mutt_oauth2.py "$OUTLOOK.tokens" \
			--verbose \
			--authorize \
			--provider microsoft \
			--encryption-pipe "gpg --encrypt --recipient cd_vieira@hotmail.com" \
			--email $OUTLOOK \
			--client-id $OUTLOOK_CLIENT_ID \
			--client-secret $OUTLOOK_CLIENT_SECRET_VALUE \
			--authflow devicecode
end

gmail
#outlook
