import re

def validate_credit_card(credit_card):
    # Regex pattern for a valid credit card number
    pattern = r"^(?!.*(\d)(-?\1){3})[456]\d{3}(?:-?\d{4}){3}$"
    # Explanation of the regex pattern:
    # ^ : Start of the string
    # (?!.*(\d)(-?\1){3}) : Negative lookahead to ensure no more than 3 consecutive repeated digits
    # [456] : Must start with 4, 5, or 6
    # \d{3} : Followed by 3 digits
    # (?:-?\d{4}){3} : Followed by 3 groups of optional hyphen and 4 digits
    # $ : End of the string
    
    if re.match(pattern, credit_card):
        return "Valid"
    else:
        return "Invalid"

if __name__ == "__main__":
    n = int(input().strip())
    credit_cards = [input().strip() for _ in range(n)]
    
    for card in credit_cards:
        print(validate_credit_card(card))
