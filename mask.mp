prologues := 3;
outputtemplate := "%j.ps";

input params_orig;

beginfig(1);

    margin = 1in;

    z1 = z0 + (0, h.b);
    z3 - z0 = (w.t, h.f);
    z5 - z0 = (w.b, -d);

    z2 = eye_apex[z1, z3] + eye_offset * ((z3 - z1) rotated -90);
    z4 = nose_apex[z3, z5] + nose_offset * ((z5 - z3) rotated 90);

    y5 = margin;
    x0 = margin;

    draw z1..z2..z3 & z3..z4..tension 1.1..z5 & z5{left}..z0--cycle
        withpen pencircle scaled 1pt;

    dotlabels.lft(0, 1, 3, 4);
    dotlabels.bot(2, 5);

    label.rt(btex$h_b$etex, .5[z0, z1]);

    z50 = (x5, y0);
    draw z0--z50--z5 dashed evenly;
    draw z3--(x3, y0) dashed evenly;
    draw z1--(x3, y1) dashed evenly;
    label.bot(btex$w_b$etex, .5[z0, z50]);
    label.lft(btex $d$ etex, .5[z50, z5]);
    label.rt (btex$h_f$etex, (x3, .5[y0, y3]));
    label.bot(btex$w_t$etex, (.5[x1, x3], y1));


endfig;
end

