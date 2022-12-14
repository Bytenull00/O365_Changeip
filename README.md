# O365_ChangeIP

A simple tool written in bash that automates password spraying on office365 and changes every few attempts to IP addresses to avoid bans

### Requirements

```
Oh365UserFinder
Proxychains
Tor
Curl
```

### Installation

Install O365_ChangeIP

```
pip3 install -r requirements.txt
apt-get -y install curl
apt-get -y install tor
apt install libproxychains4
```

## Usage 

```
chmod +x O365_changeip.sh.sh
./O365_changeip.sh.sh <MAIL_FILE> <PASSWORD>

MAIL_FILE = File with email addresses
PASSWORD = Password to spray for each email of the MAIL_FILE file

```


## Demo



### Credits 

* Gustavo Segundo - ByteNull%00
* Joe helle - dievus - https://github.com/dievus
