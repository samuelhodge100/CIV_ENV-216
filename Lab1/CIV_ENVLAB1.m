%% Givens
P = 4;
TF = 25; 
Matrix = [0];

%% Matrix Setup
for alpha=0:.1:1
    Matrix = [Matrix atand(alpha)];
end

for beta=0:.1:1
    Matrix = [Matrix; atand(beta) zeros(1,11)];
end

D = size(Matrix);
%% Force Calcultions

for i = 2:1:D(1,1)
    for j = 2:1:D(1,2)
        Matrix(i,j)= 5*P*(2*cosd(Matrix(1,j))+sind(Matrix(1,j)))/(5*cosd(Matrix(i,1))+4*sind(Matrix(i,1)));
    end
end

%% FOS Calculations

MatrixFOS = TF ./ Matrix;
MatrixFOS(:,1) = Matrix(:,1);
MatrixFOS(1,:) = Matrix(1,:);

%%Graph
figure(1)
mesh(Matrix(1,2:end), Matrix(2:end,1), Matrix(2:end,2:end));
xlabel('alpha');
ylabel('beta');
zlabel('Force');

figure(2)
mesh(MatrixFOS(1,2:end), MatrixFOS(2:end,1), MatrixFOS(2:end,2:end));
xlabel('alpha');
ylabel('beta');
zlabel('FOS');