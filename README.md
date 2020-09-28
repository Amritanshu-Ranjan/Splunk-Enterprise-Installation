# Splunk-Enterprise-Installation
Shell Script which downloads and installs the Splunk Enterprise modules on Linux host.

# Functionality of Script
Based on the WGET command line URL which Splunk provides , the script downloads the Splunk Enterprise package and does the installation.


## Installation Includes

> Untarring the Splunk enterprise package.
> Installing the Splunk enterpise package accepting license.
> Enabling the boot-start .

### Untarring the Splunk enterprise package
```
tar -xzf <tar_file_name> -C /opt 

/opt :- Untars the file in mentioned directory.

```

### Installing the Splunk enterpise package accepting license.

```
splunk start --accept-license --answer-yes --no-prompt --gen-and-print-passwd

> Generate a random password and print the random password immediately

Help URL :- https://docs.splunk.com/Documentation/Splunk/8.0.6/Security/Secureyouradminaccount

```

### Enabling the boot-start .

```
splunk enable boot-start -user root

```




# Install WGET on Linux 
yum install wget 

# UserName and Password 
Custom User name and password is flashed at the end which you can use to login , it can be changed in future reason for generating a common password is you can run the script on one go across all the servers and will have a common credentials across all the Splunk Components.

