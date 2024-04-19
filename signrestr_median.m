function [U, C, a] = signrestr_median(M, w)
% PURPOSE: Decompose M (=[M1 M2]) into two orthogonal shocks U (=[U1 U2]) 
% such that U1+U2=M1, the effect of U1 is positive on M1 and negative on M2
% while the effect of U2 is positive on both M1 and M2.
% The decomposition satisfies: M = U*C
% where C = [effect of U1 on M1 = 1, effect of U1 on M2 < 0;
%            effect of U2 on M1 = 1, effect of U2 on M2 > 0]
% Find the median shocks that satisfy the sign restrictions.
% INPUTS:
% M - T by 2 matrix
% w - optional quantile of the rotation angle, between 0 and 1
%     default: w = 0.5 implies the median rotation angle
%
% OUTPUT:
% U - T by 2 matrix with the orthogonal shocks
% C - 2 by 2 matrix with their effects on M
% a - rotation angle
%
% SEE:
% Motivation: Jarocinski, M. and Karadi, P. (2020) Deconstructing 
% Monetary Policy Surprises - The Role of Information Shocks, AEJ:Macro.
% This implementation: Appendix B of Jarocinski, M. (2020) Central Bank 
% Information Effectsand Transatlantic Spillovers, ECB Working Paper 2482.
%
% Marek Jarocinski

if nargin<2
    w = 0.5;
end

% handle missing data (if any)
inotnan = ~isnan(sum(M,2));
MM = M(inotnan,:);

[Q,R] = qr(MM,0);
S = diag(sign(diag(R)));
Q = Q*S; R = S*R;
if R(1,2)>0
    a = (1-w)*atan(R(1,2)/R(2,2)) + w*pi/2;
else
    a = (1-w)*0 + w*atan(-R(2,2)/R(1,2));
end
P = [cos(a) sin(a); -sin(a) cos(a)];
D = diag([R(1,1)*cos(a), R(1,1)*sin(a)]);

UU = Q*P*D;
C = D\P'*R;
U = nan(size(M));
U(inotnan,:) = UU;
end