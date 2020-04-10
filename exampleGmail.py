from selenium import webdriver
from time import sleep
import os
#https://www.youtube.com/watch?v=HkgDRRWrZKg
class Google:
    
    def __init__(self,username,password):
        self.driver=webdriver.Firefox()
        self.driver.get("https://stackoverflow.com/users/signup?ssrc=head&returnurl=%2fusers%2fstory%2fcurrent%27")
        sleep(3)
        self.driver.find_element_by_xpath('//*[@id="openid-buttons"]/button[1]').click()
        print("widzimy_maila")
        sleep(3)
        self.driver.find_element_by_xpath('//input[@type="email"]').send_keys(username)
        #self.driver.find_element_by_name("identifier").send_keys(username)
        self.driver.find_element_by_xpath('//*[@id="identifierNext"]').click()
        sleep(3)
        self.driver.find_element_by_xpath('//input[@type="password"]').send_keys(password)
        self.driver.find_element_by_xpath('//*[@id="passwordNext"]').click()
        sleep(2)
        self.driver.get('https://youtube.com')
        sleep(4)
        self.driver.find_element_by_xpath('//*[@id="button"]/button[1]').click()
        sleep(3)
        self.driver.find_element_by_xpath('//*[@class="style-scope ytd-compact-link-renderer"]//*[text()="Upload video"]').click()
        sleep(3)
        #self.driver.find_element_by_xpath('//*[@id="select-files-button"]').send_keys("~/Projects/autoWebScrapping/'Dějiny udatného českého národa - Baroko 67.mp4'")
        #self.driver.find_element_by_xpath('//*[@id="select-files-button"]').send_keys("~/Projects/autoWebScrapping/'Dějiny udatného českého národa - Baroko 67.mp4'")

#geckodriver - wymagany do odpalenia selenium w przeglądarce na potrzeby skryptu
geckodriver_path = os.path.dirname(os.path.realpath(__file__))
print("Scieszka geckodriver:"+geckodriver_path)
os.environ["PATH"] += os.pathsep + geckodriver_path
password="bomilkar96"
username="adonnibal96"
mylike=Google(username,password)
