%% 
% inputs

n = 2;
x_0 = 1;
x_n = 3;
%% 
% function

func = @(x) x./(x.^2 + 4);
%% 
% new variables

h = (x_n - x_0)/n;
x_inner = x_0+h:h:x_n-h;
%% 
% true value

true_value = integral(func, x_0, x_n);
%% 
% calculations

inter = func(x_0);
for x_i = x_inner
    inter = inter + 2.*func(x_i);
end
inter = inter + func(x_n);
inter = (h./2).*inter;
%% 
% relative error

rel_error = abs((inter - true_value).*100./true_value);
%%
tab = table(n, h, x_0, x_n, true_value, inter, rel_error);

disp(tab);