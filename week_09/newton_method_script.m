%% 
% inputs

func = @(x) x.^2 - 4.*x + 4 - log(x);

p0 = 1;
max_iter = 100;

% tolerance
tol = 1e-5;
%% 
% symbolic derivatives

syms x
func_sym = func(x);
dfunc_sym = diff(func_sym, x);
%% 
% derivative function

dfunc = matlabFunction(dfunc_sym, "Vars", x);
%%
% step 1
iter = 1;

results = table();
converged = false;
% step 2
while iter <= max_iter
    % step 3
    f_p0 = func(p0);
    df_p0 = dfunc(p0);
    p = p0 - f_p0./df_p0;

    f_p = func(p);  % not necessary
    results(end+1,:) = table( ...
        iter, p0, p, f_p0, df_p0, f_p ...
    );

    % step 4
    if abs(p - p0) < tol
        converged = true;
        break
    end

    % step 5
    iter = iter + 1;

    % step 6
    p0 = p;

end

if ~converged
    error("the method failed after %d iteration", max_iter)
end
%%
disp(results)
%%
figure
hold on
fplot(func, [1, 2], 'c')
plot(results.p, results.f_p, 'r--o')
grid on
hold off