%% 
% Just in case, check what is required. The content here may not strictly follow 
% the instructions
% 
% question 5

x = linspace(1, 5, 100)'
%% 
% question 6

% two lines
x = 0.1
f_x = cos(exp(pi*x))

% two lines
x = linspace(1, 5, 100)
f_x = cos(exp(pi.*x))

% three lines
x = linspace(1, 5, 100)
f_x = @(x) cos(exp(pi.*x))
f_x(x)
%% 
% question 7

% mark = 90;
% 
% if mark >= 50
%     grade = "Pass";
% elseif mark >= 65
%     grade = "Credit";
% elseif mark >= 75
%     grade = "Distinction";
% elseif mark >= 85
%     grade = "High Distinction";
% else
%     grade = "Fail";
% end
% 
% fprintf('Mark = %d, Grade = %s\n', mark, grade);
mark = 90;

if mark >= 85
    grade = "High Distinction";
elseif mark >= 75
    grade = "Distinction";
elseif mark >= 65
    grade = "Credit";
elseif mark >= 50
    grade = "Pass";
else
    grade = "Fail";
end

fprintf('Mark = %d, Grade = %s\n', mark, grade);
%% 
% question 8

% Script for summing a series

% perform initialisations
N = 10;
Sum = 0;
loopIndex = 1;

%  process calculations
while loopIndex <= N    
    Sum = Sum + loopIndex;
    loopIndex = loopIndex + 1;
end

disp(Sum)
%% 
% question 9

function [p, results] = function_newton(...
        p0, func, max_iter, tol ...
    )

    syms x
    func_sym = func(x);
    dfunc_sym = diff(func_sym, x);
    
    dfunc = matlabFunction(dfunc_sym, "Vars", x);
    iter = 1;
    
    results = table();
    
    while iter <= max_iter
        % step 3
        f_p0 = func(p0);
        df_p0 = dfunc(p0);
        p = p0 - f_p0./df_p0;
    
        f_p = func(p);  % not necessary
        results(end+1,:) = table( ...
            iter, p0, p, f_p0, df_p0, f_p ...
            );
    
        if abs(p - p0) < tol
            return
        end
    
        iter = iter + 1;
    
        p0 = p;
    end
    
    error("the method failed after %d iteration", max_iter)
   
end
%%
func = @(x) sqrt(x) - cos(x)
p0 = 0.25

max_iter = 100
tol = 1e-5
%%
[p, results] = function_newton(p0, func, max_iter, tol);
fprintf('Root = %.8f\n', p);
disp(results);
%% 
% question 10

tab = array2table( ...
    [5, 50, 500, 2500, 5000; 4.3, 55.3, 486.1, 2625.7, 4831.1]', ...
    "VariableNames", ["x", "y"] ...
    )
tab.x2 = tab.x.^2
tab.xy = tab.x.*tab.y
%%
n = height(tab)
sum_x = sum(tab.x)
sum_y = sum(tab.y)
sum_x2 = sum(tab.x2)
sum_xy = sum(tab.xy)

slo = (n*sum_xy - sum_x*sum_y)/...
    (n*sum_x2 - sum_x^2)
inte = (sum_x2*sum_y - sum_xy*sum_x)/...
    (n*sum_x2 - sum_x^2)

[coeffs, fitStats] = polyfit(tab.x, tab.y, 1)
%% 
% question 11

func_11 = @(x) exp(2.*x)

syms x
func_11_sym = func_11(x)
dfunc_11_sym = diff(func_11_sym, x)

dfunc_11 = matlabFunction(dfunc_11_sym, "Vars", x)
%%
x = 3
true_value = dfunc_11(x)
%%
h = 0.1
forward = (func_11(x+h) - func_11(x))/h
backward = (func_11(x) - func_11(x - h))/h
central = (func_11(x + h) - func_11(x - h))/(2*h)

rel_err_forward = abs(forward - true_value)*100/abs(true_value)
rel_err_backward = abs(backward - true_value)*100/abs(true_value)
rel_err_central = abs(central - true_value)*100/abs(true_value)
%% 
% question 12

function tab = func_trapezoidal(n, x_0, x_n, func)
    
    h = (x_n - x_0)/n;
    x_inner = x_0+h:h:x_n-h;
    
    true_value = integral(func, x_0, x_n);
    
    inter = func(x_0);
    for x_i = x_inner
        inter = inter + 2.*func(x_i);
    end
    inter = inter + func(x_n);
    inter = (h./2).*inter;
    
    rel_error = abs((inter - true_value).*100./true_value);
    
    tab = table(n, h, x_0, x_n, true_value, inter, rel_error);

end

function tab = func_simpson(n, x_0, x_n, func)

    h = (x_n - x_0)/(2*n);
    x_inner = x_0+h:h:x_n-h;
    ind_vect = 1:length(x_inner);
    
    true_value = integral(func, x_0, x_n);
    
    inter = func(x_0);
    for ind = ind_vect
        if mod(ind,2) == 1
            inter = inter + 4.*func(x_inner(ind));
        elseif mod(ind,2) == 0
            inter = inter + 2.*func(x_inner(ind));
        end
    end
    inter = inter + func(x_n);
    inter = (h./3).*inter;
    
    rel_error = abs((inter - true_value).*100./true_value);
    
    tab = table(n, h, x_0, x_n, true_value, inter, rel_error);

end

fprintf("run done")
%%
x_0 = 1
x_n = 2
n = 2
func = @(x) x.*log(x)

syms x
func_sym = func(x)
ifunc_sym = int(func_sym, x)

simp = func_simpson(n, x_0, x_n, func)
trap = func_trapezoidal(n, x_0, x_n, func)

results = innerjoin(...
    trap, simp, ...
    "Keys", [...
    "n", "x_0", "x_n", "true_value"...
    ]...
    )

results = results(:, [...
    "n", "h_trap", "h_simp", "x_0", "x_n", ...
    "true_value", "inter_trap", "inter_simp", ...
    "rel_error_trap", "rel_error_simp" ...
    ]);

disp(results)
%% 
% question 13

syms y(t)

ode = diff(y,t) == t + y

cond = y(0) == 1;
ySol(t) = dsolve(ode,cond)

ode_func = matlabFunction(ySol(t), "Vars", t)
%%
func = @(t,y) t + y

h = 0.1
t = 0:h:0.2

% t0 = 0
y0 = 1

y = zeros(size(t));
y(1) = y0;

results = table()

for iter = 1:length(t)-1
    t0 = t(iter)
    y0 = y(iter)

    k1 = func(t0, y0)
    k2 = func(t0 + h/2, y0 + h*k1/2)
    k3 = func(t0 + h/2, y0 + h*k2/2)
    k4 = func(t0 + h, y0 + h*k3)
    y1 = y0 + h*(k1 + 2*k2 + 2*k3 + k4)/6

    y(iter+1) = y1

    true_val = ode_func(t(iter+1))
    rel_err = abs(true_val - y1)*100/abs(true_val)

    results(end+1,:) = table( ...
        iter, t0, y0, y1, true_val, rel_err, k1, k2, k3, k4 ...
    );
end

disp(results)
%%