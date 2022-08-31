n = input('Number of Elements Present : \n');
nn = n+1;
%initialize matricies
E=[2e4,2e4];
A=[250,250];
L=[150,150];
k=[];
K= zeros(nn);
P = 6e4;
%Creating the force array
F = zeros(1, nn);
F(1, n) = P;
%Input problem specific geometry
U1 = 0;
U3 = 1.2;

for i = 1:n
    % Gather information about the nodes
%     E = [E input("Enter the Young's Modulus for Element " + i + ' in N/mm^2 :\n')];
%     A = [A input("Enter the Area for Element " + i + ' in mm^2 :\n')];
%     L = [L input("Enter the Length for Element " + i + ' in mm :\n')];
    % Calculate the stiffness coefficient
    k = E(i)*A(i)/L(i);
    %Form the Global Stiffness Matrix
    K(i,i) = K(i,i) + k;
    K(i+1,i) = K(i+1,i) -k;
    K(i,i+1) = K(i,i+1) - k;
    K(i+1,i+1) = K(i+1,i+1) +k;
    
end

%Solve for U2

K2 = K(2:n, 2:n);
M = F(2:n) - U1*K(2:n,1) - U3*K(2:n, nn);
U2 = linsolve(K2, M);


%Find reaction forces
R1 = K(1,:)*[U1;U2;U3];
R3 = K(3,:)*[U1;U2;U3];

%Find internal forces and calc the stress for each element
F12=-R1;
F23=R3;

sigma1 = F12/A(1);
sigma2 = F23/A(2);

fprintf("The elongation of element 2 is:\n" +U2+'mm'+'\n')
fprintf("The reaction forces are:\n" +R1+'N, ' +R3+'N\n')
fprintf("The internal forces are:\n" +F12+'N, '+F23+'N\n')
fprintf("The stress's on members are:\n"+ sigma1+'N/mm^2, '+sigma2+'N/mm^2\n')
