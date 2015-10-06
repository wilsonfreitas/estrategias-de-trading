function pairsChart(LCO, WTI)
% PAIRSCHART: Shows the full time history for LCO and WTI

% Copyright 2011, The MathWorks, Inc.
% All rights reserved.

plot(LCO(:,1), LCO(:,2), WTI(:,1), WTI(:,2))

datetick('x')
grid on

xlabel('Date')
ylabel('Price (USD)')

title('Intraday prices for LCO and WTI')
legend('LCO', 'WTI', 'Location', 'best')