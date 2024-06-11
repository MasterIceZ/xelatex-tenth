#!/usr/bin/env python3
"""
Run this script to download required fonts
from GitHub repository into local fonts directory.
"""
import os
import shutil
import sys
import requests
from urllib.parse import urlsplit
from urllib.request import urlopen

FONT_URLS = [
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-Thin.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-ThinItalic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-ExtraLight.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-ExtraLightItalic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-Light.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-LightItalic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-Regular.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-Italic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-Medium.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-MediumItalic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-SemiBold.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-SemiBoldItalic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-Bold.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-BoldItalic.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-ExtraBold.ttf',
    'https://github.com/cadsondemak/Sarabun/raw/master/fonts/Sarabun-ExtraBoldItalic.ttf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-ExtraLight.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-ExtraLightItalic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-Light.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-LightItalic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-Book.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-BookItalic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-Regular.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-Italic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-Medium.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-MediumItalic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-SemiBold.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-SemiBoldItalic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-Bold.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-BoldItalic.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Roman/FiraGO-ExtraBold.otf',
    'https://github.com/bBoxType/FiraGO/raw/master/Fonts/FiraGO_OTF_1001/Italic/FiraGO-ExtraBoldItalic.otf',
    'https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip'
]


def main():
    for font_url in FONT_URLS:
        download_file(font_url)
    download_FiraCode()


def download_file(url):
    # Create local file path
    split_result = urlsplit(url)
    this_dir = os.path.dirname(os.path.abspath(__file__))
    local_path = os.path.join(this_dir, 'fonts', os.path.basename(split_result.path))

    # Ensure that directory exists
    os.makedirs(os.path.dirname(local_path), exist_ok=True)

    # Actual downloading
    print(f"Downloading to fonts/ directory: {url}", file=sys.stderr)
    with urlopen(url) as response, open(local_path, 'wb') as fobj:
        shutil.copyfileobj(response, fobj)

def download_FiraCode():
    owner = "tonsky"
    repo = "FiraCode"
    release_tag = "6.2"
    download_path = "fonts"
    download_filename = ""

    url = f"https://api.github.com/repos/{owner}/{repo}/releases/tags/{release_tag}"
    response = requests.get(url)
    release_info = response.json()

    for asset in release_info['assets']:
        asset_url = asset['browser_download_url']
        asset_name = asset['name']
        asset_download_path = f"{download_path}/{asset_name}"
    
        print(f"Downloading to fonts/ directory: {url}", file=sys.stderr)
        asset_response = requests.get(asset_url)
        with open(asset_download_path, 'wb') as f:
            f.write(asset_response.content)

        download_filename = asset_download_path
    
    print(f"Unzipping {download_filename} to {download_path}/{repo}")
    shutil.unpack_archive(download_filename, f"{download_path}/{repo}")

    print(f"Deleting FiraCode zip")
    os.remove(download_filename)

    font_list = os.listdir(f"{download_path}/{repo}/ttf")
    print(f"Moving font files")
    for font_file in font_list:
        shutil.move(f"{download_path}/{repo}/ttf/{font_file}", f"{download_path}/{font_file}")

    print(f"Deleting FiraCode directory")
    shutil.rmtree(f"{download_path}/{repo}")

if __name__ == '__main__':
    main()
