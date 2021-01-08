%
% Library functions for drawing sewing patterns.
%

%
% Default settings
%
prologues := 3;
outputtemplate := "%j.ps";

%
% The sewing pattern's seam allowance; adjust as necessary.
%
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

%
% Given a time and a path, figure where the expanded seam allowance path should
% be at that time. (This is done by taking a perpendicular line based on the
% direction of the path at that time.)
%
vardef seam_allowance_point expr t of p =
    (seam_allowance * unitvector(direction t of p) rotated 90) + (point t of p)
enddef;

%
% Given a path, create a new path that has the seam allowance added to it. The
% path must be continuous.
%
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

%
% Draws measurebars showing the distance between two points. The first two
% arguments are point suffixes for the endpoints of the bars, way is the
% direction that the bar points outward, and lbl is the label text.
%
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


