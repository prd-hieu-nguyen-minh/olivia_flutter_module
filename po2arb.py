#!/usr/bin/env python
# -*- coding:utf-8 -*-
# apt-get install python-polib
# apt-get install python3-polib
# emerge dev-python/polib
# pip install polib
# run ubuntu python ./po2arb.py
# run mac python po2arb.py

#  Created by lang.le@paradox.ai on 10/24/23, 7:59 AM
#  Copyright (c) 2016-2023 by Paradox.Ai . All rights reserved.
#  Last modified 10/23/23, 2:40 PM

import json
import polib
import re

import mapping as mp


def get_po_path(locale, po_file, locale_dir):
    return locale_dir + "/" + locale + "/LC_MESSAGES/" + po_file + ".po"


# Get data by hashmap(msgid, msgstr)
def extract_from_po_file(lang, po_path):
    hasp_map_msg_ids = {}
    try:
        src_po_data = polib.pofile(po_path)
        for line in src_po_data:
            msgid = redefine_msgid(line.msgid)
            msgid_plural = redefine_msgid(line.msgid_plural)
            if not line.msgid_plural:
                if lang == "en" or lang == "en_GB":
                    hasp_map_msg_ids[msgid] = line.msgid
                else:
                    hasp_map_msg_ids[msgid] = line.msgstr
            else:
                if lang == "en" or lang == "en_GB":
                    hasp_map_msg_ids[msgid] = line.msgid_plural
                else:
                    hasp_map_msg_ids[msgid] = line.msgstr_plural[0]
                    try:
                        hasp_map_msg_ids[msgid_plural] = line.msgstr_plural[1]
                    except Exception:
                        hasp_map_msg_ids[msgid_plural] = line.msgstr_plural[0]
    except Exception as e:
        print("An exception occurred: ", str(e))
    return hasp_map_msg_ids


def add_number_param(value):
    new = ""
    split = value.split("{param}")
    size = len(split)
    if size > 1:
        for idx, text in enumerate(split):
            if idx == size - 1:
                new += text
            else:
                new += text + "{param" + str(idx + 1) + "}"
    else:
        new = value
    return new


def redefine_msgid(text):
    text_new = text
    try:
        text_new = (re.sub('[^a-zA-Z0-9_]+', '', text.replace(" ", "_"))).lower()
        if len(text_new) > 0 and text_new[0] == "_":
            text_new = text_new.replace('_', 'l', 1)
    except Exception as e:
        print("Exception(redefine_msgid): ", str(e))
    return text_new


def po2arb(locales, pofiles, locale_dir):
    exist_lang = []
    # Read file en arb string languages
    with open('lib/l10n/intl_en.arb') as arb_file:
        data = json.loads(arb_file.read())
        for key, value in data.items():
            exist_lang.append(key)
    for locale in locales:
        rename_lang = locale
        if rename_lang == 'zh_CN':
            rename_lang = 'zh_Hans_CN'
        elif rename_lang == 'zh_TW':
            rename_lang = 'zh_Hant_TW'
        data_export = {}
        for poFile in pofiles:
            po_data = extract_from_po_file(locale, get_po_path(locale, poFile, locale_dir))
            for key in po_data:
                if key in exist_lang:
                    msgstr = po_data[key]
                    for regex in mp.symbol_mapping:
                        msgstr = re.sub(regex, "{param}", msgstr)
                    for regex in mp.blank_mapping:
                        msgstr = re.sub(regex, "", msgstr)
                    for k, v in mp.special_mapping:
                        msgstr = msgstr.replace(k, v)
                    data_export[key] = add_number_param(msgstr)
        # Export file .arb from dump data PO
        with open("lib/l10n/intl_" + rename_lang + ".arb", "w+") as file:
            json.dump(data_export, file)


if __name__ == '__main__':
    # locales = ["en"]
    locales = ["bg", "bs", "cs", "da", "de", "el", "en", "en_GB", "es", "es_EM", "es_MX", "fr", "fr_CA", "he", "hr", "hu", "it",
               "ja", "ko", "nl", "pl", "pt", "pt_BR", "ro", "ru", "sk", "sr", "th", "tr", "uk", "vi", "zh_CN", "zh_TW"]
    po_files = ["mobile", "django", "djangojs"]
    locale_dir = "locale"
    po2arb(locales, po_files, locale_dir)
