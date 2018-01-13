function sPb_thin = PRcut(ws_wt2, nvec, ic_gamma, dthresh)

    if nargin<4, dthresh = 2; end
    if nargin<3, ic_gamma = 0.12; end
    if nargin<2, nvec = 6; end

    [tx2, ty2] = size(ws_wt2);
    tx=(tx2-1)/2; ty=(ty2-1)/2;

    l{1} = ws_wt2(1:2:end,2:2:end);
    l{2}= ws_wt2(2:2:end,1:2:end);

    % build the pairwise affinity matrix
    [val,I,J] = buildW(l{1},l{2}, dthresh, ic_gamma);
    W = sparse(val,I,J);
    [EigVect, EVal] =  PR_vect2(W, nvec);
    clear D W opts;

    EigVal = diag(EVal);
    clear Eval;

    EigVal(1:end) = EigVal(end:-1:1);
    EigVect(:, 1:end) = EigVect(:, end:-1:1);

    vect = zeros(tx, ty, nvec);
    for v = 2 : nvec,
        vect(:, :, v) = reshape(EigVect(:, v), [ty tx])';
    end
    clear EigVect;

    %% spectral Pb
    for v=2:nvec,
        vect(:,:,v)=(vect(:,:,v)-min(min(vect(:,:,v))))/(max(max(vect(:,:,v)))-min(min(vect(:,:,v))));
    end

    sPb_thin = zeros(2*tx+1, 2*ty+1);
    for v = 1 : nvec
        if EigVal(v) > 0,
            vec = vect(:,:,v)/sqrt(EigVal(v));
%             vec = vect(:,:,v);
            sPb_thin = sPb_thin + seg2bdry_wt(vec, 'doubleSize');
         end
    end
    sPb_thin = sPb_thin.^(1/sqrt(2));


function [EV, EVal] =  PR_vect(W, n_vect)
    [m,n] = size(W);
    W = 0.5*(W+W');
    [r,c,val] = find(W);
    [id, C] = kmeans(val, 3);
    [~, ind] = sort(C, 'descend');
    for i = 1:length(C)
        min_val = min(val(id == ind(i)));
        r_tmp = r(val >= min_val);
        c_tmp =  c(val >= min_val);
        val_tmp = val(val >= min_val);
        W_tmp = sparse(r_tmp, c_tmp, val_tmp, m,n);
        G = graph(W_tmp);
        n_comp = max(conncomp(G));
        if (n_comp > n_vect)
            G_prime = G;
        else
%             max(conncomp(G_prime))
            break;
        end
    end


%   Calculate the first projection
    bins = conncomp(G_prime);
    r_tmp = 1:length(bins);
    B = 1:length(bins);
    Ncount = histc(bins, B);
    val_new = 1./sqrt(Ncount(bins));
    N = sparse(r_tmp,bins,val_new);


    r_tmp = r(id == ind(i));
    c_tmp = c(id == ind(i));
    val_tmp = val(id == ind(i));
    W_k = sparse(r_tmp, c_tmp, val_tmp, m, n);
    [EV,EVal] = rcut2(W_k, N, n_vect);
%     [EV,EVal] = ncuts2(N'*W_k*N, n_vect);

    EV = N*EV;

    EV = whiten(EV, 1, 0);



function [EV, EVal] =  PR_vect2(W, n_vect)
    [m,n] = size(W);
    W = 0.5*(W+W');
    [r,c,val] = find(W);
    C = multithresh(val,2);
    for i = length(C):-1:1
        min_val = C(i);
        r_tmp = r(val >= min_val);
        c_tmp =  c(val >= min_val);
        val_tmp = val(val >= min_val);
        W_tmp = sparse(r_tmp, c_tmp, val_tmp, m,n);
        G = graph(W_tmp);
        n_comp = max(conncomp(G));
        if (n_comp > n_vect)
            G_prime = G;
        else
            break;
        end
    end


    bins = conncomp(G_prime);
    r_tmp = 1:length(bins);
    B = 1:length(bins);
    Ncount = histc(bins, B);
    val_new = 1./sqrt(Ncount(bins));
    N = sparse(r_tmp,bins,val_new);

    r_tmp = r(val < min_val);
    c_tmp =  c(val < min_val);
    val_tmp = val(val < min_val);
    W_k = sparse(r_tmp, c_tmp, val_tmp, m, n);
    [EV,EVal] = rcut2(W_k, N, n_vect);
%     [EV,EVal] = ncuts2(N'*W_k*N, n_vect);

    EV = N*EV;

    EV = whiten(EV, 1, 0);



function [EV, EVal] = rcut2(A, N, n_ev)
[wx, wy] = size(A);
x = 1 : wx;
S = full(sum(A, 1));
D = sparse(x, x, S, wx, wy);
clear S x;


opts.issym=1;
opts.isreal = 1;
opts.disp=0;
L_k = N'* ((D - A) + (10^-10) * speye(size(D))) * N;
[EV, EVal] = eigs(L_k, n_ev, 'sm', opts);
clear D A opts;

v = diag(EVal);
[sorted, sortidx] = sort(v, 'descend');
EV = EV(:,sortidx);
EVal = diag(sorted);

function [EV, EVal] = ncuts2(A, n_ev)
[wx, wy] = size(A);
x = 1 : wx;
S = full(sum(A, 1));
D = sparse(x, x, S, wx, wy);
clear S x;


opts.issym=1;
opts.isreal = 1;
opts.disp=0;
[EV, EVal] = eigs((D - A) + (10^-10) * speye(size(D)), D, n_ev, 'sm', opts);
clear D A opts;

v = diag(EVal);
[sorted, sortidx] = sort(v, 'descend');
EV = EV(:,sortidx);
EVal = diag(sorted);
