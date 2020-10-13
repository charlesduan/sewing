prologues := 3;
outputtemplate := "%j.ps";

seam_allowance = .375in;

vardef posttension expr t of p =
    save q; path q;
    q = point t of p{direction t of p}..{direction t + 1 of p}point t + 1 of p;
    length(postcontrol 0 of q - point 0 of q) /
        length(postcontrol t of p - point t of p)
enddef;

vardef pretension expr t of p =
    save q; path q;
    q = point t - 1 of p{direction t - 1 of p}..{direction t of p}point t of p;
    length(precontrol 1 of q - point 1 of q) /
        length(precontrol t of p - point t of p)
enddef;

vardef seam_allowance_point expr t of p =
    (seam_allowance * unitvector(direction t of p) rotated 90) + (point t of p)
enddef;

vardef add_seam_allowance(expr p) =
    save i;
    seam_allowance_point 0 of p{direction 0 of p}
        .. tension (posttension 0 of p) and
            for i = 1 upto length(p) - 1:
                (pretension i of p) ..
                seam_allowance_point i of p{direction i of p}
                .. tension (posttension i of p) and
            endfor
        (pretension length(p) of p) ..
        {direction length(p) of p}seam_allowance_point length(p) of p
enddef;

def measurebars(suffix $, $$)(expr way, lbl) =
    if (z$ dotprod way) > (z$$ dotprod way):
        measurebars_($, $$, way, lbl)
    else:
        measurebars_($$, $, way, lbl)
    fi
enddef;

def measurebars_(suffix $, $$)(expr way, lbl) =
    begingroup
        save z_, a_, b_; pair z_, a_, b_;
        save p; picture p;
        z_ = .25in * unitvector way;
        a_ = z$ + way + z_;
        b_ = z$$ + whatever * way = a_ + whatever * (way rotated 90);
        draw z$--(a_  + .5z_);
        draw z$$--(b_  + .5z_);
        draw a_--b_;
        label(lbl, .5[a_, b_]);
    endgroup
enddef;

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

