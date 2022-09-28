#!/usr/bin/env python
# Investment targets:
# 90% stocks
#   30% international (VXUS)
#   60% domestic      (VTI,VOO)
# 10% bonds           (BND,VCLT
dom_stock_goal_pct = 0.6
int_stock_goal_pct = 0.3
bnd_goal_pct = 0.1

# Get totals in brokerage account
brk_bnd = input('BND in brokerage: ')
brk_vclt = input('VCLT in brokerage: ')
brk_voo = input('VOO in brokerage: ')
brk_vti = input('VTI in brokerage: ')
brk_vxus = input('VXUS in brokerage: ')
brk_cash = input('Cash in brokerage: ')
# Get totals in Roth IRA
roth_bnd = input('BND in Roth IRA: ')
roth_vclt = 0  # input('VCLT in Roth IRA: ')
roth_voo = input('VOO in Roth IRA: ')
roth_vti = input('VTI in Roth IRA: ')
roth_vxus = input('VXUS in Roth IRA: ')
roth_cash = input('Cash in Roth IRA: ')

# Calculate totals
bnd_tot = brk_vclt + brk_bnd + roth_vclt + roth_bnd
dom_stock_tot = brk_voo + brk_vti + roth_vti + roth_voo
int_stock_tot = brk_vxus + roth_vxus
cash_tot = brk_cash + roth_cash
total_value = bnd_tot + dom_stock_tot + int_stock_tot + cash_tot

# Calculate goal totals
dom_stock_goal = dom_stock_goal_pct * total_value
int_stock_goal = int_stock_goal_pct * total_value
bnd_goal = bnd_goal_pct * total_value

# Difference between goal and current value
dom_stock_diff = dom_stock_goal - dom_stock_tot
int_stock_diff = int_stock_goal - int_stock_tot
bnd_diff = bnd_goal - bnd_tot

#Print out info
print('Total Holdings: $' + str(total_value))
print('Domestic stocks (VTI, VOO): $' + str(dom_stock_tot) + ' (' + str(dom_stock_tot * 100 / total_value) + '%)')
print('International stocks (VXUS): $' + str(int_stock_tot) + ' (' + str(int_stock_tot * 100 / total_value) + '%)')
print('Bonds (BND): $' + str(bnd_tot) + ' (' + str(bnd_tot * 100 / total_value) + '%)')
print('Cash: $' + str(cash_tot) + ' (' + str(cash_tot * 100 / total_value) + '%)')
print('Current targets: ')
print(str(dom_stock_goal_pct * 100) + ' % Domestic stock')
print(str(int_stock_goal_pct * 100) + ' % International stock')
print(str(bnd_goal_pct * 100) + ' % Bonds')
print('Target - current:')
print('  Domestic stocks: $' + str(dom_stock_diff))
print('  International stocks: $' + str(int_stock_diff))
print('  Bonds: $' + str(bnd_diff))

