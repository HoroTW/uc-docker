import undetected_chromedriver as uc
from selenium.webdriver.remote.webdriver import By
import selenium.webdriver.support.expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

import time

print("start of script")

options = uc.ChromeOptions()
driver = uc.Chrome(options)
driver.maximize_window()

# open google
driver.get("https://www.google.com")

# accept cookies if necessary
driver.find_elements(By.XPATH, '//*[contains(text(), "Alle ablehnen")]')[-1].click()

# find input field
try:
    inp_search = driver.find_element(By.XPATH, '//textarea[@name="q"]')
except:
    inp_search = driver.find_element(By.XPATH, '//input[@name="q"]')

time.sleep(0.5)  # <- thats bad practice (google needs some time to have the 
                 #                        handler ready for the input)

# search for rickroll
inp_search.send_keys("rickroll\n")

# don't stop the script so chrome doesn't close and we can see the result
while True: time.sleep(10)
