%% written by K. Garner, 2022
% this code goes through some of section 5 of Henson & Penny (2005) ANOVAs and SPM
% https://www.fil.ion.ucl.ac.uk/~wpenny/publications/rik_anova.pdf
% and also adapts the code from spm_make_contrasts.m (Penny, W. 2005-2012,
% Wellcome Trust Centre for Neuroimaging)

% Notations from the chapter:
% I_k = k x k identity matrix
% 1_k = k x 1 vector of 1s
% 0_k = k x 1 vector of 0s
% 0_kn = k x n matrix of zeros
% n = 1..N subjects
% m = 1...M factors
% the mth factor has 1...K_m levels

%% define ANOVA space for this run
M = 3; % how many ways does your anova go - e.g. a 3 way anova
Ks = [2 2 3]'; % define the number of levels per factor - this is a 2 x 2 x 2 ANOVA

sprintf('according to eq 26, there are %d conditions in the ANOVA, as you take the product of the number of levels for each factor', ...
       prod(Ks)) 
   
nf = numel(Ks); % get the numer of factors for later on
k = [Ks(:)' 1 1 1]; % found this in the spm function for spm_make_kron(kron(D1,D2),D3)s.m

% number of interactions of order r = 0...M where 0 = main effects
(2^M)-1

%% get common and differential vectors
% by creating common and differential vectors of the factors, we can
% then combine them later to get the contrasts we need 
% see equation 28

% C_m is first, which can be thought of as the common effect for the mth
% factor. Cm = 1_Km

C1 = ones(k(1), 1);
C2 = ones(k(2), 1);
C3 = ones(k(3), 1);

% D_m is second, which reflects the differential effect for each factor
D1 = -diff(eye(k(1)))'; % get the identity matrix for the factor, take the difference of the rows and 
% flip the signs
D2 = -diff(eye(k(2)))'; 
D3 = -diff(eye(k(3)))'; % get the difference between l1 & l2, and then l2 & l3

% now that we have a way to select common and differential effects, we can
% build contrast for each experimental effect by making Kronecker products
% in the order that yields the combinations and differences we want for
% each contrast

% the Kronecker product (k prod) of a matrix basically replicates rows and columns
% of 1 matrix, given the dimensions of a second matrix, by taking all the
% possible products between the elements of A, and the matrix B
% so if A is m x n, and b is p x q, kron(A,B) gets you an m*p x n*q matrix
% when used with zeros and ones you can use it to replicate columns and
% rows as you wish

% imagine briefly we had a 2 x 2 ANOVA, then...
% for the main effect of factor 1, we take each row of the differential effect, 
% e.g. row 1 = -1, row 2 = 1, and we take the k prod with the relevant C,
% so that we replicate each row for as many levels as there are in that
% factor e.g. [-1 -1 1 1]

% now for a 3 way ANOVA
sprintf('return all 1s, to get the average effect of condition/session')
kron(kron(C1,C2),C3)' % returns all 1s, is the average effect of condition

sprintf('main effect of factor A')
kron(kron(D1,C2), C3) 

sprintf('main effect of factor B')
kron(kron(C1,D2),C3)'

sprintf('A x B interaction')
kron(kron(D1,D2),C3)

sprintf('main effect of factor C')
kron(kron(C1,C2),D3)' % tests the null that C1 == C2 == C3

sprintf('A x C interaction')
kron(kron(D1,C2),D3)' % tests the null that A1[C1 == C2 == C3] == A2[C1 == C2 == C3]

sprintf('B x C interaction')
kron(kron(C1,D2),D3)' % tests the null that B1[C1 == C2 == C3] == B2[C1 == C2 == C3]

sprintf('A x B x C interaction')
kron(kron(D1,D2),D3)' % tests the null that [A1B1[C1 == C2 == C3]-A1B2[C1 == C2 == C3]]-[A2B1[C1 == C2 == C3]-A2B2[C1 == C2 == C3]] = 0


