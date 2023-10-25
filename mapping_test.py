#  Created by hieu.nguyen.minh@paradox.ai on 5/30/23, 10:09 AM
#  Copyright (c) 2016-2023 by Paradox.Ai . All rights reserved.
#   Last modified 5/30/23, 10:09 AM

import mapping as mp
import sys
import re

# Run command: python3 mapping_test.py arg1 arg2 arg3 ...
# Note: Parameters containing () or blank should be put in ''
# Example: python3 mapping_test.py {employee_term} '%( ai_name )s' [[company_name]] abc
# Result:
"""
Param {employee_term}: Passed regex %{0,2}\{.*?\}s{0,1}
Param %( ai_name )s: Passed regex %\(.*?\)s{0,1}
Param [[company_name]]: Passed regex \[\[.*?\]\]
Param abc: Failed
Completed!
"""


def test_symbol_mapping(param):
    symbol = "%s"
    for regex in mp.symbol_mapping:
        if re.sub(regex, symbol, param) == symbol:
            return regex
    return False


args_len = len(sys.argv)
if args_len <= 1:
    print("No params")
else:
    for i in range(1, args_len):
        arg = sys.argv[i]
        result = test_symbol_mapping(arg)
        if result:
            print("Param %s: Passed regex %s" % (arg, result))
        else:
            print("Param %s: Failed" % arg)

print("Completed!")
