%Test Script
params.Ts = .001; params.k_p = 1.0; params.k_I = 2.0*(1/params.Ts);
r = ones(20,1); r(1) = 0;
u = zeros(size(r)); y = zeros(size(r));
u_i = zeros(size(r)); u_p = zeros(size(r));
u_i(1) = compute_pi(params, true, r(1), y(1)); %Initialize the controller
u_p(1) = params.k_p * (r(1) - y(1));
u(1) = u_i(1) + u_p(1);
y(2)=.25*u(1);
for k = 2:length(y)
    u_i(k) = u_i(k-1) + compute_pi(params, false, r(k-1:k), y(k-1:k)); %compute controller u
    u_p(k) = params.k_p * (r(k) - y(k));
    u(k) = u_i(k) + u_p(k);
    if k == length(y)
       break;
    end
    y(k+1) = .25*u(k); %Plant model y(k) = .25*u(k-1);
end
figure(1);plot(params.Ts*(1:length(r)),[r,y,u]);grid;
xlabel('time (seconds)');ylabel('r,y,u');legend({'r','y','u'});