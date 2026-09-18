#!/usr/bin/env python3

import re
import sys

PLACEHOLDER = "REDACTED"

content = sys.stdin.read()

content = re.sub(
    r'("location"\s*:\s*\{.*?"name"\s*:\s*")[^"]*(")',
    rf'\1{PLACEHOLDER}\2',
    content,
    count=1,
    flags=re.DOTALL,
)

sys.stdout.write(content)
