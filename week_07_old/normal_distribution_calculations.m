% clear, clc
% inputs
sigma = 1;
delta_x_vect = [0.1 0.05 0.01, 0.001];
x_a_vect = [-sigma, -2*sigma, -3*sigma];
x_b_vect = [sigma, 2*sigma, 3*sigma];

func = @(x) (1./(sigma.*sqrt(2.*pi))).*...
    exp((-1./2).*(x./sigma).^2);

% new variables
ind_vect = 1:length(x_a_vect);

% Store results for each method
trapResults = [];
simpResults = [];

for ind = ind_vect
    x_a = x_a_vect(ind);
    x_b = x_b_vect(ind);

    trap = trapezoidal_rule_func( ...
        delta_x_vect, x_a, x_b, func ...
        );
    simp = simpson_rule_func( ...
        delta_x_vect, x_a, x_b, func ...
        );

    trap.("sigma") = repmat(x_b, length(delta_x_vect), 1);
    simp.("sigma") = repmat(x_b, length(delta_x_vect), 1);

    trapResults = [trapResults; trap];
    simpResults = [simpResults; simp];

end

simpResults.("delta x") = [];
simpResults.("true value") = [];
simpResults.sigma = [];

trapResults.ID = (1:height(trapResults))';
simpResults.ID = (1:height(simpResults))';

tab = innerjoin( ...
    trapResults, simpResults, ...
    'Keys', "ID" ...
    );
tab.ID = [];
tab = tab(:, [ ...
    "sigma", "delta x", "true value", ...
    "trapezoidal", "rel. error_trapResults", ...
    "simpson", "rel. error_simpResults" ...
    ]);

disp(tab);