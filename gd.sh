#!/bin/bash


# GitHub Dorks

## Org search

## User search

## Site search

echo "=== GitHub Statements ==="
echo """
NOT
user:uname
org:orgname
"""

echo "=== GitHub Keywords ==="
echo """
ldap
private
passwd
Jenkins
OTP
oauth
authoriztion
password
pwd
ftp
dotfiles
JDBC
key-keys
send_key-keys
send,key-keys
token
user
login-singin
passkey-passkeys
pass
secret
SecretAccessKey
app_AWS_SECRET_ACCESS_KEY AWS_SECRET_ACCESS_KEY
credentials
config
security_credentials
connectionstring
ssh2_auth_password
DB_PASSWORD"""
echo """
filename:.npmrc _auth
filename:.dockercfg auth
extension:pem private
extension:ppk private
filename:id_rsa or filename:id_dsa
extension:sql mysql dump
extension:sql mysql dump password
filename:credentials aws_access_key_id
filename:.s3cfg
filename:wp-config.php
filename:.htpasswd
filename:.env DB_USERNAME NOT homestead
filename:.env MAIL_HOST=smtp.gmail.com
filename:.git-credentials
PT_TOKEN language:bash
filename:.bashrc password
filename:.bashrc mailchimp
filename:.bash_profile aws
rds.amazonaws.com password
extension:json api.forecast.io
extension:json mongolab.com
extension:yaml mongolab.com
jsforce extension:js conn.login
SF_USERNAME salesforce
filename:.tugboat NOT _tugboat
HEROKU_API_KEY language:shell
HEROKU_API_KEY language:json
filename:.netrc password
filename:_netrc password
filename:hub oauth_token
filename:robomongo.json
filename:filezilla.xml Pass
filename:recentservers.xml Pass
filename:config.json auths
filename:idea14.key
filename:config irc_pass
filename:connections.xml
filename:express.conf path:.openshift
filename:.pgpass
filename:proftpdpasswd
filename:ventrilo_srv.ini
[WFClient] Password= extension:ica
filename:server.cfg rcon password
JEKYLL_GITHUB_TOKEN
filename:.bash_history
filename:.cshrc
filename:.history
filename:.sh_history
filename:sshd_config
filename:dhcpd.conf
filename:prod.exs NOT prod.secret.exs
filename:prod.secret.exs
filename:configuration.php JConfig password
filename:config.php dbpasswd
filename:config.php pass
path:sites databases password
shodan_api_key language:python
shodan_api_key language:shell
shodan_api_key language:json
shodan_api_key language:ruby
filename:shadow path:etc
filename:passwd path:etc
extension:avastlic "support.avast.com"
filename:dbeaver-data-sources.xml
filename:sftp-config.json
filename:.esmtprc password
extension:json googleusercontent client_secret
HOMEBREW_GITHUB_API_TOKEN language:shell
xoxp OR xoxb
.mlab.com password
filename:logins.json
filename:CCCam.cfg
msg nickserv identify filename:config
filename:settings.py SECRET_KEY
filename:secrets.yml password
filename:master.key path:config
filename:deployment-config.json
filename:.ftpconfig
filename:.remote-sync.json
filename:sftp.json path:.vscode
filename:WebServers.xml
filename:jupyter_notebook_config.json
"api_hash" "api_id"
"https://hooks.slack.com/services/"
filename:github-recovery-codes.txt
filename:gitlab-recovery-codes.txt
filename:discord_backup_codes.txt
extension:yaml cloud.redislabs.com
extension:json cloud.redislabs.com"""
