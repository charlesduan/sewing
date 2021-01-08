input sewlib;

beginfig(1);

    margin = 1in;

    z1 = z0 + (0, h.b);
    z3 - z0 = (w.t, h.f);
    z5 - z0 = (w.b, -d);

    z2 = eye_apex[z1, z3] + eye_offset * ((z3 - z1) rotated -90);
    z4 = nose_apex[z3, z5] + nose_offset * ((z5 - z3) rotated 90);

    y5 = margin;
    x0 = margin;

    path p[], p[]';

    p123 = z1..z2..z3;
    p345 = z3..z4..tension 1.1..z5;
    p50 = z5--z0;

    draw p123 & p345 & p50--cycle
        withpen pencircle scaled 1pt;

    draw add_seam_allowance(p123) -- add_seam_allowance(p345)
        -- add_seam_allowance(p50) -- add_seam_allowance(z0--z1) -- cycle
        dashed evenly;


    dotlabels.lft(0, 1, 3, 4);
    dotlabels.bot(2, 5);

    z50 = (x5, y0);
    measurebars(0, 1, left, btex $h_b$ etex);
    measurebars(0, 3, left * .5in, btex $h_f$ etex);
    measurebars(0, 5, left, btex $d$ etex);
    measurebars(1, 3, up, btex $w_t$ etex);
    measurebars(0, 5, down, btex $w_b$ etex);

endfig;
end

