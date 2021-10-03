from selenium import webdriver
from time import sleep
import re

browser = webdriver.Firefox()
browser.get('https://jw.ustc.edu.cn')

input()

windows = browser.window_handles
browser.switch_to.window(windows[1])

while True:
    element = browser.find_element_by_id('table')
    elementText = element.text
    number = re.sub(r'.*? (\d+\/\d+).*', r'\1', elementText.split('\n')[2])  # 行数
    selectedNumber = int(number.split('/')[0])
    selectedRange = int(number.split('/')[1])
    if (selectedNumber < selectedRange):
        raise (RuntimeError('exist'))
    try:
        browser.refresh()
    except:
        browser.refresh()
    sleep(.5)

browser.quit()
