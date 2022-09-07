import requests
import zipfile
import os

def download():
    browser_version = "105.0.1343.27" # Edge
    driver_uri = "https://msedgedriver.azureedge.net/{}/edgedriver_win64.zip".format(browser_version)
    # browser_version = "105.0.5195.52" # Chrome
    # driver_uri = "https://chromedriver.storage.googleapis.com/{}/chromedriver_win32.zip".format(browser_version)

    download_fname = "webdriver.zip"

    file = requests.get(driver_uri, allow_redirects=True)
    open(download_fname, 'wb').write(file.content)

    zipfile.ZipFile(download_fname, 'r').extractall(".")

    os.unlink(download_fname)

    return
