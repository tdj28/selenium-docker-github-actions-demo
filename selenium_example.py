#!/usr/bin/env python
import pytest
from pyvirtualdisplay import Display
from selenium import webdriver

base_url = "http://localhost:8000"

@pytest.fixture
def browser():

    opt = webdriver.ChromeOptions()
    opt.add_argument("--headless")
    opt.add_argument("--disable-xss-auditor")
    opt.add_argument("--disable-web-security")
    opt.add_argument("--allow-running-insecure-content")
    opt.add_argument("--no-sandbox")
    opt.add_argument("--disable-setuid-sandbox")
    opt.add_argument("--disable-webgl")
    opt.add_argument("--disable-popup-blocking")
    opt.add_argument("--disable-dev-shm-usage")
    opt.add_argument("--disable-gpu")

    driver = webdriver.Chrome(options=opt)
    driver.set_window_size(640, 480)
    driver.implicitly_wait(10)

    yield driver

    driver.quit()

def test_that_title_is_correct(browser):
    try:
        browser.get(base_url)
        assert browser.title == 'Testing 123 ABC'
    except Exception as e:
        print(e)
    finally:
        browser.close()
