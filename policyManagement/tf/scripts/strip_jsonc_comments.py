#!/usr/bin/env python3
"""
Simple script to strip comments from JSONC files and output valid JSON.
This allows Terraform's jsondecode() to parse JSONC files with comments.
"""

import sys
import json
import re

def strip_jsonc_comments(content):
    """
    Remove single-line (//) and multi-line (/* */) comments from JSONC content.

    Args:
        content: String content of a JSONC file

    Returns:
        String content with comments removed
    """
    # Remove multi-line comments /* ... */
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)

    # Remove single-line comments // ...
    content = re.sub(r'//.*?$', '', content, flags=re.MULTILINE)

    return content

def main():
    if len(sys.argv) != 2:
        print("Usage: strip_jsonc_comments.py <file_path>", file=sys.stderr)
        sys.exit(1)

    file_path = sys.argv[1]

    try:
        # Read the JSONC file
        with open(file_path, 'r') as f:
            jsonc_content = f.read()

        # Strip comments
        json_content = strip_jsonc_comments(jsonc_content)

        # Validate it's valid JSON by parsing and re-serializing
        parsed = json.loads(json_content)

        # Output clean JSON (compact format)
        print(json.dumps(parsed))

    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON after stripping comments: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
