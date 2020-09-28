#!/bin/sh

echo ""

echo -e -n "\e[41m Please Note the installation follows wget approach to downlaod the package \e[49m\n "

echo ""

echo " Checks if wget is installed on the host machine "

echo ""

yum install wget -y >~/output.txt

WGET_STATUS=$(cat ~/output.txt | grep -i "already installed" | grep -o "already installed")

if [ "$WGET_STATUS" == "already installed" ]; then
  echo -e -n "\e[44m  The wget package is $WGET_STATUS \e[49m\n "
  echo ""
  echo -e -n "\e[44m  We are good to download the Splunk Enterprise Package \e[49m\n "
fi

HOST_NAME=$(hostname)
OPERATING_SYSTEM=$(uname -s)

echo ""
echo -e -n "\e[44m OPERATING_SYSTEM = $OPERATING_SYSTEM \e[49m\n "
echo ""
echo -e -n "\e[44m $OPERATING_SYSTEM SPLUNK ENTERPRISE INSTALLATION IN PROGRESS \e[49m\n"
echo ""
echo ""

if [ "$OPERATING_SYSTEM" == "Linux" ]; then
  ##Linux :-
  LINUX_WGET_CMD=$(wget -O splunk-8.0.5-a1a6394cc5ae-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.5&product=splunk&filename=splunk-8.0.5-a1a6394cc5ae-Linux-x86_64.tgz&wget=true')

  LINUX_INSTALL_FILE="splunk-8.0.5-a1a6394cc5ae-Linux-x86_64.tgz"

  echo ""

  tar -xzf $LINUX_INSTALL_FILE -C /opt >~/output.txt

  chown -R root.root /opt/splunk/

  $(/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --gen-and-print-passwd >~/output.txt)

  SPLUNK_START=$(cat ~/output.txt | grep -i "Starting splunk server daemon (splunkd)..." | grep -o "Starting splunk server daemon (splunkd)...")

  if [ "$SPLUNK_START" == "Starting splunk server daemon (splunkd)..." ]; then
    echo -e -n "\e[44m Splunk Enterprise started \e[49m\n "

    echo ""
  fi

  $(/opt/splunk/bin/splunk enable boot-start -user root >~/output.txt)

  BOOT_START=$(cat ~/output.txt | grep -i "Init script is configured to run at boot." | grep -o "Init script is configured to run at boot.")

  if [ "$BOOT_START" == "Init script is configured to run at boot." ]; then

    echo -e -n "\e[44m Splunk Enterprise is Configured to run on boot \e[49m\n "

    echo ""

  fi

  FILE="/opt/splunk/etc/system/local/user-seed.conf"

  /bin/cat <<EOM >$FILE
[user_info]
USERNAME = admin
PASSWORD = changeme
EOM

  mv /opt/splunk/etc/passwd /opt/splunk/etc/passwd-OLD
  mv /opt/splunk/etc/system/local/inputs.conf /opt/splunk/etc/system/local/inputs.conf-OUT
  echo ""

  # POST SPLUNK INSTALLATION STEPS #

  echo ""

  STATUS=$(/opt/splunk/bin/splunk status)
  echo -e -n "\e[44m Splunk Status Information $STATUS \e[49m\n "

  echo ""

  VERSION=$(/opt/splunk/bin/splunk version)
  echo -e -n "\e[44m splunk version $VERSION \e[49m\n "

  echo ""

  echo -e -n "\e[44m  SPLUNK ENTERPRISE IS INSTALLED ON HOST = $HOST_NAME WITH SPLUNK VERSION $VERSION \e[49m\n "

  echo ""

  $(/opt/splunk/bin/splunk restart >~/output.txt)

  echo -e -n "\e[44m  Restarting Splunk Enterprise For Updated configration to reflect \e[49m\n "

  echo ""

  echo -e -n "\e[44m If you want to check any information related to restart you can find output.txt file on [~] home location \e[49m\n "

  echo ""
  echo ""

  echo -e -n "\e[44m  Username :- admin  \e[49m\n "

  echo -e -n "\e[44m  Password :- changeme  \e[49m\n "

fi
