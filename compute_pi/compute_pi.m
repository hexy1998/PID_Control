function u_i = compute_pi(params, reset, r, y)
    if reset
        e=r-y;
        u_i = params.k_I * params.Ts / 2 * e;
    else
        e=r-y;
        u_i = params.k_I * params.Ts / 2 * (e(2) + e(1));
    end
end