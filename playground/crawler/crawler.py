from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time
import urllib.request
import os


def createDirectory(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print("Error: Failed to create the directory.")


def crawling_img(keyword, filename_prefix):
    # driver = webdriver.Chrome()
    driver = webdriver.Edge()
    driver.get("https://www.google.co.kr/imghp?hl=ko&tab=wi&authuser=0&ogbl")
    elem = driver.find_element(By.NAME, "q")
    elem.send_keys(keyword)
    elem.send_keys(Keys.RETURN)

    SCROLL_PAUSE_TIME = 0.5
    # Get scroll height
    last_height = driver.execute_script(
        "return document.body.scrollHeight")
    while True:
        # Scroll down to bottom
        driver.execute_script(
            "window.scrollTo(0, document.body.scrollHeight);")
        # Wait to load page
        time.sleep(SCROLL_PAUSE_TIME)
        # Calculate new scroll height and compare with last scroll height
        new_height = driver.execute_script("return document.body.scrollHeight")
        if new_height == last_height:
            try:
                driver.find_element(By.CSS_SELECTOR, ".mye4qd").click()
            except:
                break
        last_height = new_height

    imgs = driver.find_elements(By.CSS_SELECTOR, ".rg_i.Q4LuWd")

    img_root = ".\\dog_images" + "\\" + filename_prefix

    createDirectory(img_root)
    count = 1
    for img in imgs:
        try:
            img.click()
            time.sleep(1)
            imgURL = driver.find_element(By.XPATH, '//*[@id="Sva75c"]/div/div/div[3]/div[2]/c-wiz/div/div[1]/div[1]/div[3]/div/a/img').get_attribute("src")
            print("Source: {}".format(imgURL))

            path = ".\\dog_images\\" + filename_prefix + "\\"
            fname = path + filename_prefix + str(count).zfill(3) + ".jpg"
            print("Store: {}".format(fname))

            urllib.request.urlretrieve(imgURL, fname)
            count = count + 1
            if count >= 260:
                break

        # except Exception as e:
        except:
            # print("Error: {}".format(e))
            pass

    driver.close()
