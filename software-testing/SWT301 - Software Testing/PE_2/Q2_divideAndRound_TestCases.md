# Question 2: Unit Test Cases for divideAndRound

| Test Case | Dividend | Divisor | Expected Result | Note                       |
|-----------|----------|---------|----------------|----------------------------|
| TC1       | 10       | 3       | 4              | Positive, remainder        |
| TC2       | 10       | 2       | 5              | Positive, no remainder     |
| TC3       | -10      | 3       | -4             | Negative, remainder        |
| TC4       | -10      | 2       | -5             | Negative, no remainder     |
| TC5       | 0        | 3       | 0              | Zero dividend              |
| TC6       | 10       | 0       | Exception      | Divide by zero             |

## Notes:
- TC1: 10/3 = 3, remainder 1, rounds up to 4.
- TC2: 10/2 = 5, no remainder.
- TC3: -10/3 = -3, remainder -1, rounds down to -4.
- TC4: -10/2 = -5, no remainder.
- TC5: 0/3 = 0.
- TC6: Division by zero should throw an exception.

These cases ensure 100% statement and decision coverage for the method. 