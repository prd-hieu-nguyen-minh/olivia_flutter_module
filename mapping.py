#  Created by hieu.nguyen.minh@paradox.ai on 5/30/23, 10:09 AM
#  Copyright (c) 2016-2023 by Paradox.Ai . All rights reserved.
#   Last modified 5/30/23, 10:09 AM

symbol_mapping = [
    '%{0,2}\{.*?\}s{0,1}',  # {employee_term}, %{ai_name}, %{ai_name}s, %%{activeUser.name}
    '%\(.*?\)s{0,1}',  # %(candidate_name), %(ai_name)s
    '\{\{.*?\}\}',  # {{actionText}}
    '\[\[.*?\]\]',  # [[company_name]]
    '#document-name',
]

blank_mapping = [
    '<span.*?>',  # <span>, <span class=\"lblCompanyAIName\">
    '</span>',
    '<strong>',
    '</strong>',
]

special_mapping = [
    ('&', '&amp;'),
    ('...', '&#8230;'),
    ("\\'", "\'"),
    ('\'', '\\\''),
    ('<br/>', '\\n'),
    ('<br>', '\\n'),
]
