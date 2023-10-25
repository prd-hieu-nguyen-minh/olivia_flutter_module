#  Created by lang.le@paradox.ai on 10/24/23, 7:58 AM
#  Copyright (c) 2016-2023 by Paradox.Ai . All rights reserved.
#  Last modified 10/24/23, 7:58 AM

# Run:  >>>  python3 string2arb.py  <<<
import json
import re

import mapping as mp


def msgid(text):
    text_new = (re.sub('[^a-zA-Z0-9_]+', '', text.replace(" ", "_"))).lower()
    if len(text_new) > 0 and text_new[0] == "_":
        text_new = text_new.replace('_', 'l', 1)
    return text_new


def msgstr(text):
    for regex in mp.symbol_mapping:
        text = re.sub(regex, "{param}", text)
    for regex in mp.blank_mapping:
        text = re.sub(regex, "", text)
    for k, v in mp.special_mapping:
        text = text.replace(k, v)
    return add_number_param(text)


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


x = ""
while True:
    x = input("Input text (Enter \"c\" to stop): ")
    if x == "c":
        break

    # Load file arb to json
    path_file = 'lib/l10n/intl_en.arb'
    with open(path_file) as arb_file:
        json_lang = json.loads(arb_file.read())

    # Add text input into json file
    json_lang[msgid(x)] = msgstr(x)

    # Read text to arb file
    with open(path_file, "w+") as json_file:
        json.dump(json_lang, json_file)
