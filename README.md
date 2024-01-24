# Splunk-Enterprise-Installation
A Shell Script designed to download and install Splunk Enterprise modules on a Linux host.

# Functionality of Script
Using the provided WGET command line URL from Splunk, the script fetches the Splunk Enterprise package and proceeds with the installation.

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
At the conclusion of the process, a unique username and password are displayed for your login. Although these credentials can be modified later, the advantage of generating a standardized password is that you can execute the script seamlessly across all servers, ensuring consistent access credentials for all Splunk Components.

