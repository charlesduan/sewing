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

    p321 = z3..z2..z1;
    p543 = z5..tension 1.1..z4..z3;
    p5 = z0--z5;

    draw p5 & p543 & p321 -- cycle dashed evenly;

    draw add_seam_allowance(p5) joined add_seam_allowance(p543)
        joined add_seam_allowance(p321) joined add_seam_allowance(z1--z0)
        -- cycle;

    dotlabels.lft(0, 1, 3, 4);
    dotlabels.bot(2, 5);

    z50 = (x5, y0);
    measurebars(0, 1, left, btex $h_b$ etex);
    measurebars(0, 3, left * .5in, btex $h_f$ etex);
    measurebars(0, 5, left, btex $d$ etex);
    measurebars(1, 3, up, btex $w_t$ etex);
    measurebars(0, 5, down, btex $w_b$ etex);

    label(jobname, .5[z1, z5]);

endfig;
end

