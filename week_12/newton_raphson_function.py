import sympy as sp
import pandas as pd


def newton_raphson_function(p0, tol, max_iter, func):
    # symbolic derivatives
    x = sp.symbols("x")
    func_sym = func(x)
    dfunc_sym = sp.diff(func_sym, x)

    # derivative function
    dfunc = sp.lambdify(x, dfunc_sym, "numpy")

    # step 1
    iter = 1
    results = []

    # step 2
    while iter <= max_iter:

        # step 3
        f_p0 = func(p0)
        df_p0 = dfunc(p0)

        p = p0 - f_p0 / df_p0

        f_p = func(p)  # not necessary

        results.append({
            "iter": iter,
            "p0": p0,
            "p": p,
            "f_p0": f_p0,
            "df_p0": df_p0,
            "f_p": f_p,
        })

        # step 4
        if abs(p - p0) < tol:
            msg = "the method converged successfully"

            results = pd.DataFrame(results)

            return p, iter, results, func_sym, dfunc_sym, msg

        # step 5
        iter += 1

        # step 6
        p0 = p

    msg = f"the method failed after {max_iter} iterations"

    results = pd.DataFrame(results)

    return p, iter, results, func_sym, dfunc_sym, msg
