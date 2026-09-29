%% 
% inputs

func = @(x) x.^2 - 4.*x + 4 - log(x);

a = 1;
b = 2;
max_iter = 100;

% tolerance
tol = 1e-5;
%% 
% check if the interval is crossing the x-axis

if func(a) * func(b) > 0
    error("the interval does not bracket a root");
end
%%
% step 1
iter = 1;
f_a = func(a);
f_b = func(b); % not necessary

results = table();
converged = false;

% step 2
while iter <= max_iter
    % step 3
    p = a + (b - a)/2;
    f_p = func(p);

    results(end+1,:) = table(...
        iter, a, b, p, f_a, f_b ,f_p ...
    );

    % step 4 - convergence test
    if abs(f_p) < tol || (b - a)/2 < tol
        converged = true;
        break % use return if it is a function
    end

    % redefining variables
    % step 5
    iter = iter + 1;

    % step 6 - choose new interval
    if f_a .* f_p > 0
        a = p;
        f_a = f_p;
    else
        b = p;
        f_b = f_p; % not necessary
    end

end

if ~converged
    error('the method failed after %d iteration\n', max_iter)
end
%% 
disp(results)
%% 
% plot

figure
hold on
fplot(func, [1, 2], 'c')
plot(results.p, results.f_p, 'r--o')
grid on
hold off