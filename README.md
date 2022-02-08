# IIS-RestrictedAddressList
PowerShell script to export the IIS IP Address and Domain Restriction settings to a text list

## Introduction
If you're a web administrator and you often work with Internet Information Services (IIS), you most likely already know about the IP Address and Domain Restrictions, a great built-in feature of IIS8 that allows to selectively allow or deny access to the web server, websites, folders or files that makes your server more secure.

However, such feature comes with some major flaws: for example, we can't modify the single entries, for example to edit their IP address - we can only delete and add them again; furthermore, we can't add notes, descriptions or other meta-data to these entries, which would be very helpful to give an actual "name" to those IP addresses, thus preventing us from forgetting why we've put them there or which service (or person) they belong to. Last but not least, we are completely unable to print or export a human-readable list of the blocked (or allowed) IP addresses.

To fix the first two features we would need to develop a dedicated software with read and write permissions to some critical system files, which would be rather complex to implement: luckily enough, the "human-readable list" can be generated quite easily, since it only requires to issue a query to the appcmd.exe file, normalize the generated output and print it to a text file.

That's what **IIS-RestrictedAddedList** is about: a simple PowerShell script that can be used to export the IIS IP Address and Domain Restriction settings to a text list.

## How it works
The program allows to specify a single website or multiple (comma-separated) websites, and will print a text file containing a list of all the allowed or denied IP addresses, in the following format:

```
---------------------------------------------
website1.example.com
---------------------------------------------
ipAddress="90.188.92.0" subnetMask="255.255.255.0" allowed="true" 
ipAddress="127.0.0.1" allowed="true" 
ipAddress="10.100.0.12" allowed="true" 

---------------------------------------------
website2.example.com
---------------------------------------------
ipAddress="127.0.0.1" allowed="true" 
ipAddress="10.100.0.12" allowed="true" 
```

In the above file we can see the list for two different websites: **website1.example.com** and **website2.example.com**.

We hope that this PowerShell script will be useful to other web administrators that need to export a list of the IP Address and Domain Restriction feature - just like I did!
