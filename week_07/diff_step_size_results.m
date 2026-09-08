% inputs
x = 1;
n_vect = [1, 4, 7, 10, 13, 15, 18, 20];

syms t;
func = exp(2.*t);

% store results
results = {};

for n = n_vect

    tab = diff_step_size_function(...
        n, x, func ...
    );
    % append table to results
    results{end + 1} = tab;

end

% merge all tables
results = vertcat(results{:});

% display
disp(results)