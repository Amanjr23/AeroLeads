import os
import time
from pathlib import Path

import pandas as pd
from bs4 import BeautifulSoup
from dotenv import load_dotenv

from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

load_dotenv()
HEADLESS = os.getenv("HEADLESS", "1") == "1"  # default headless ON
OUTPUT_DIR = Path("output")
OUTPUT_DIR.mkdir(exist_ok=True)

def make_driver():
    options = Options()
    if HEADLESS:
        options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--window-size=1200,900")
    options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
    service = ChromeService(ChromeDriverManager().install())
    return webdriver.Chrome(service=service, options=options)

def pick(soup, selectors):
    for sel in selectors:
        node = soup.select_one(sel)
        if node and node.get_text(strip=True):
            return node.get_text(" ", strip=True)
    return None

def extract_fields(html, url):
    soup = BeautifulSoup(html, "html.parser")
    name = pick(soup, ["h1", "h1.text-heading-xlarge", "h1.top-card-layout__title"])
    headline = pick(soup, ["div.text-body-medium.break-words", "div.text-body-medium", "h2", "p.subtitle"])
    location = pick(soup, ["span.text-body-small.inline.t-black--light.break-words", "span.text-body-small"])
    about = pick(soup, ["section#about p", "section[data-section='about'] p", "div.inline-show-more-text"])
    return {"name": name, "headline": headline, "location": location, "about": about, "url": url}

def read_urls(path="urls.txt"):
    urls = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#"):
                urls.append(line)
    return urls[:20]

def main():
    urls = read_urls()
    if not urls:
        print("No URLs found in urls.txt")
        return

    rows = []
    driver = make_driver()
    try:
        for i, url in enumerate(urls, 1):
            print(f"[{i}/{len(urls)}] Fetching: {url}")
            driver.get(url)
            time.sleep(3)  # simple wait for page to render
            html = driver.page_source
            rows.append(extract_fields(html, url))
    finally:
        driver.quit()

    df = pd.DataFrame(rows, columns=["name", "headline", "location", "about", "url"])
    out_csv = OUTPUT_DIR / "linkedin_profiles.csv"
    df.to_csv(out_csv, index=False, encoding="utf-8")
    print("Saved:", out_csv.resolve())

if __name__ == "__main__":
    main()
