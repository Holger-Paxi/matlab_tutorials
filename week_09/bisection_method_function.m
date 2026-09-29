function [p, iter, results] = bisection_method_function(...
        a, b, tol, max_iter, func ...
    )
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
            return % use break if it is a script
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
    
    error('the method failed after %d iteration', max_iter)

end