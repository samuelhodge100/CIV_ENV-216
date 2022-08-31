%Inputs

P = [1000 0 500];   %In lbs
w = [0 12.5 12.5];  %In lbs/in
S_allow = 1800;     %In lbs/in^2
T_allow = 120;      %In lbs/in^2
syms b L
LSol=[];
BSol=[];
Case=['A' 'B' 'C'];

%Create loop to calculate b and L
for i=1:3
    Soln = double(solve( ((3*w(i)*L^2 +6*P(i)*L)/(64*S_allow))^(1/3) == ((3*w(i)*L+3*P(i))/(16*T_allow))^(1/2),'MaxDegree',4));
    if Soln(1,1) == 0 
       LSol = [LSol Soln(2,1)];
    else
        LSol = [LSol Soln];
    end
    
    Soln = double(solve(b == ((3*w(i)*LSol(i)+3*P(i))/(16*T_allow))^(1/2)));
    BSol = [BSol Soln];
end


% Print out information
for i=1:3
    fprintf('The length in case '+ string(Case(i)) +' is ' + LSol(i) + ' inches and the b value is ' + BSol(i)+' inches. \n')

end

