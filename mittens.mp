input sewlib;

beginfig(1);

    x12 - x16 = palm_circum/2 + 2seam_loss;
    x14 = .5[x12, x16];
    x12 - x10 = thumb_circum/2 + 2seam_loss;
    x11 = .5[x10, x12];

    y14 - y16 = finger_height + 2seam_loss;
    y10 = y12 = y16;
    y10 - y11 = thumb_height + seam_loss;

    y14 - y15 = palm_curve_height;

    z15 - z16 = z13 - z12; x15 = x16;

    y11' = y11''; x11' = x10; x11'' = x12; x11'' - x11 = y11' - y11;

    y11 = 1in; x16 = 1in;

    path p; p = z10 -- z11'{down} .. z11{right} .. z11''{up} -- z12 -- z13{up}
        .. z14{left} .. z15{down} -- z16;
    draw p -- cycle dashed evenly;

    draw join(add_seam_allowance(z16--z10), add_seam_allowance(p)) -- cycle;

    dotlabels.rt(11'', 13);
    dotlabels.top(10, 14);
    dotlabels.lft(11', 12, 15, 16);
    dotlabels.bot(11);

    measurebars(11', 11'', up, btex ${1 \over 2}{\rm thumb\_circum}$ etex);
    measurebars(14, 12, right * .5in, btex $\rm finger\_height$ etex);
    measurebars(15, 13, up, btex ${1 \over 2}\rm palm\_circum$ etex);
    measurebars(11, 12, right * .5in, btex $\rm thumb\_height$etex);

endfig;

beginfig(2);
    z27 = (1in, 1in + 2hem_width);
    z21 - z27 = (palm_circum/2 + 2seam_loss, 0);
    z26 - z27 = (0, palm_bottom_length + wrist_length + seam_loss);
    y25 = y26; x25 = x24;
    x22 = x21; x22 - x24 = thumb_circum/2 + 2seam_loss; x23 = .5[x22, x24];
    y23 - y25 = thumb_height + seam_loss; y24 = y22;
    z23 - z24 = whatever * (1, 1);

    path p; p = z21 -- z22{up} .. z23{left} .. z24{down} -- z25;
    draw z26 -- z27 -- z21 -- p -- cycle dashed evenly;

    draw add_seam_allowance(z26--z27)
        -- hem_allowance(z27--z21)
        -- add_seam_allowance(p)
        joined add_seam_allowance(z25--z26) -- cycle;
    dotlabels.lft(22, 24,  26);
    dotlabels.top(23);
    dotlabels.bot(25, 27, 21);

    measurebars(22, 24, down, btex${1 \over 2}{\rm thumb\_circum}$ etex);
    measurebars(27, 21, up * 1in, btex ${1 \over 2}\rm palm\_circum$ etex);
    measurebars(26, 27, right, btex
        ${\rm palm\_bottom\_length}+{\rm wrist\_length}$
        etex);

endfig;

beginfig(3);
    z31 = (1in, 1.2in);
    z32 - z31 = (palm_circum/2 + 2seam_loss, 0);
    z33 - z32 = z35 - z31; x35 = x31;
    x34 = .5[x33, x35]; z34 - z35 = whatever * (1, 1);
    y34 - y31 = palm_bottom_length + wrist_length + finger_height + seam_loss;

    path p; p = z32 -- z33{up} .. z34{left} .. {down}z35 -- z31;
    draw p -- cycle dashed evenly;
    draw add_seam_allowance(p) -- hem_allowance(z31--z32) -- cycle;
    dotlabels.bot(31, 32);
    dotlabels.top(34);
    dotlabels.rt(33, 35);

    measurebars(32, 34, right * .5in, btex
        ${\rm palm\_bottom\_length}+{\rm wrist\_length}+{\rm finger\_height}$
        etex rotated 90);
    measurebars(35, 33, down, btex ${1 \over 2}\rm palm\_circum$ etex);
endfig;

end
