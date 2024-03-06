class Solution:
    def maxProfit(self, prices):
        out = 0
        for i, price in enumerate(prices):
            if not i:
                min_left = price
                continue
                
            profit = price - min_left
            if profit > out:
                out = profit
            
            if price < min_left:
                min_left = price
        
        return out