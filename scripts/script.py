import os
import time
from playwright.sync_api import Playwright, sync_playwright
def run(playwright: Playwright) -> None:
    browser = playwright.chromium.launch(headless=True)
    context = browser.new_context()
    # Open new page
    page = context.new_page()
    # Go to http://localhost:4000/
    page.goto("http://chirp:4000/")
    # Go to http://localhost:4000/posts
    page.goto("http://chirp:4000/posts")
    # Click text=New Post
    # with page.expect_navigation(url="http://localhost:4000/posts/new"):
    for i in range(1,21):
        print(f"message {i}")
        with page.expect_navigation():
            page.click("text=New Post")
        # Click textarea[name="post[body]"]
        page.click("textarea[name=\"post[body]\"]")
        # Fill textarea[name="post[body]"]
        page.fill("textarea[name=\"post[body]\"]", f"message {i} from: {os.environ.get('HOSTNAME')}")
        # Click text=Save
        page.click("text=Save")
        
    # assert page.url == "http://localhost:4000/posts"
    # Click text=New Post
    # page.click("text=New Post")
    # # assert page.url == "http://localhost:4000/posts/new"
    # # Click textarea[name="post[body]"]
    # page.click("textarea[name=\"post[body]\"]")
    # # Fill textarea[name="post[body]"]
    # page.fill("textarea[name=\"post[body]\"]", "sample text")
    # # Click text=Save
    # page.click("text=Save")
    # assert page.url == "http://localhost:4000/posts"
    # Go to http://localhost:4000/posts
    page.goto("http://chirp:4000/posts")
    # ---------------------
    context.close()
    browser.close()
with sync_playwright() as playwright:
    run(playwright)
