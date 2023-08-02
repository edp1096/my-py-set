import requests
from bs4 import BeautifulSoup

(r := requests.get('https://www.python.org/downloads/')).raise_for_status()
soup = BeautifulSoup(r.text, 'lxml')
if (a := soup.find_all('a', class_='button')):
    print(a[0].text.split()[-1])
