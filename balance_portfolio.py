#!/usr/bin/env python3
# Investment targets:
# 90% stocks
#   30% international (VXUS)
#   60% domestic      (VTI,VOO)
# 10% bonds           (BND,VCLT
dom_stock_goal_pct = 0.6
int_stock_goal_pct = 0.3
bnd_goal_pct = 0.1

accts = ["brokerage", "trad IRA", "Roth IRA",  "joint"]
dom = ["VTI", "VOO"]     # domestic stocks
intl = ["VXUS"]          # international stocks
bond = ["BND", "VCLT"]   # bonds
cash  = ["CASH"]         # cash

# Get holdings in each account
dom_total = 0
intl_total = 0
bond_total = 0
cash_total = 0
for acct in accts:
    bnd = float(input(f'BND in {acct}: '))
    if acct == "brokerage":
        vclt = float(input(f'VCLT in {acct}: '))
    if acct == "brokerage" or "Roth IRA":
        voo = float(input(f'VOO in {acct}: '))
    vti = float(input(f'VTI in {acct}: '))
    vxus = float(input(f'VXUS in {acct}: '))
    cash = float(input(f'Cash in {acct}: '))

    # Update totals
    dom_total = dom_total + voo + vti
    intl_total = intl_total + vxus
    bond_total = bond_total + bnd + vclt
    cash_total = cash_total + cash


# Calculate totals
total_value = bond_total + dom_total + intl_total + cash_total

# Calculate goal totals
dom_stock_goal = dom_stock_goal_pct * total_value
int_stock_goal = int_stock_goal_pct * total_value
bnd_goal = bnd_goal_pct * total_value

# Difference between goal and current value
dom_stock_diff = dom_stock_goal - dom_total
int_stock_diff = int_stock_goal - intl_total
bnd_diff = bnd_goal - bond_total

# Print out info
print('Total Holdings: $' + str(total_value))
print('Domestic stocks (VTI, VOO): $' +
      str(dom_total) + ' (' +
      str(dom_total * 100 / total_value) + '%)')
print('International stocks (VXUS): $' +
      str(intl_total) +
      ' (' + str(intl_total * 100 / total_value) + '%)')
print('Bonds (BND, VCLT): $' +
      str(bond_total) + ' (' +
      str(bond_total * 100 / total_value) + '%)')
print('Cash: $' +
      str(cash_total) + ' (' +
      str(cash_total * 100 / total_value) + '%)')
print('Current targets: ')
print(str(dom_stock_goal_pct * 100) + ' % Domestic stock')
print(str(int_stock_goal_pct * 100) + ' % International stock')
print(str(bnd_goal_pct * 100) + ' % Bonds')
print('Target - current:')
print('  Domestic stocks: $' + str(dom_stock_diff))
print('  International stocks: $' + str(int_stock_diff))
print('  Bonds: $' + str(bnd_diff))
