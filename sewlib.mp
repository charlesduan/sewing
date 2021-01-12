%
% Library functions for drawing sewing patterns.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DEFAULT SETTINGS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


prologues := 3;
outputtemplate := "%j-%c.ps";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SEWING PARAMETERS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% The sewing pattern's seam allowance; adjust as necessary.
%
seam_allowance := .375in;

%
% The amount of fabric width that is lost on each seam side. This isn't used in
% the library but is meant for the user.
%
seam_loss := 0.125in;

%
% The width of rolled hems for cuffs and such. Double this amount should be
% added wherever a hem is needed, since the hem is rolled over twice.
%
hem_width := 0.5in;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTIONS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    (seam_allowance * unitvector(direction t of p) rotated -90) + (point t of p)
enddef;

%
% Given a path, create a new path that has the seam allowance added to it. The
% path must be continuous and counterclockwise.
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

        if angle(way) < -157.5:
            label.lft(lbl, .5[a_, b_]);
        elseif angle(way) < -112.5:
            label.llft(lbl, .5[a_, b_]);
        elseif angle(way) < -67.5:
            label.bot(lbl, .5[a_, b_]);
        elseif angle(way) < -22.5:
            label.lrt(lbl, .5[a_, b_]);
        elseif angle(way) < 22.5:
            label.rt(lbl, .5[a_, b_]);
        elseif angle(way) < 67.5:
            label.urt(lbl, .5[a_, b_]);
        elseif angle(way) < 112.5:
            label.top(lbl, .5[a_, b_]);
        elseif angle(way) < 157.5:
            label.ulft(lbl, .5[a_, b_]);
        else:
            label.lft(lbl, .5[a_, b_]);
        fi
    endgroup
enddef;

%
% Truncates the end of a path p at time t, terminating at point endpt. (The
% endpt must be specified because intersection points of paths may not be
% exactly on the path.)
%
vardef trunc_path_end(expr p, t, endpt) =
 save p_; path p_; p_ = subpath (0,t) of p;
 save t_; t_ = ceiling t-1;
 (subpath (0,t_) of p_)
 .. controls (postcontrol t_ of p_) and (precontrol infinity of p_) .. endpt
enddef;

%
% Truncates the start of a path p at time t, starting at point startpt.
%
vardef trunc_path_start(expr p, t, startpt) =
 save p_; path p_; p_ = subpath (t,infinity) of p;
 startpt .. controls (postcontrol 0 of p_) and (precontrol 1 of p_)
    .. (subpath(1, infinity) of p_)
enddef;

% The "combine" macro combines two paths at their intersection point.
vardef combine(expr first, second) =
 save t_; pair t_; t_=first intersectiontimes second;
 trunc_path_end(first, xpart t_, point ypart t_ of second)
    & (subpath (ypart t_, infinity) of second)
enddef;

% The var_combine macro does the same as combine, but the first path dominates
% the subpath.
vardef var_combine(expr first, second) =
 save t_; pair t_; t_=first intersectiontimes second;
 (subpath (0, xpart t_) of first)
 & trunc_path_start(second, ypart t_, point xpart t_ of first)
enddef;

% Different ways of writing combine and var_combine.
tertiarydef first combined second = combine(first, second) enddef;
tertiarydef first var_combined second = var_combine(first, second) enddef;  

%
% Joins two seam allowances, either by truncating them at their intersection or
% by joining them. Currently they are joined by just a straight line, but an
% improvement would be to extend the two paths linearly and join them at the
% intersection.
vardef join(expr first, second) =
    if first intersectiontimes second = (-1, -1):
        first -- second
    else:
        combine(first, second)
    fi
enddef;
tertiarydef first joined second = join(first, second) enddef;

%
% Given a line where a hem bottom should be found, draw lines and form the path
% for the seam allowance of a hem. It is assumed that the resulting path can be
% connected via straight lines to the rest of the path, since the hemmed area
% must be rectangular in order to fold properly.
%
vardef hem_allowance(expr p) =
    save osa; osa := seam_allowance;
    save seam_allowance;

    seam_allowance := -hem_width;
    save p_; path p_; p_ = add_seam_allowance(p);
    draw p_ dashed withdots;
    label(btex sew hem etex, point length(p_)/2 of p_);

    seam_allowance := hem_width;
    save p_; path p_; p_ = add_seam_allowance(p);
    draw p_ dashed withdots;
    label(btex fold hem etex, point length(p_)/2 of p_);

    seam_allowance := 2hem_width;
    add_seam_allowance(
        ((point 0 of p) - osa * unitvector(direction 0 of p))
        -- p
        -- ((point infinity of p) + osa * unitvector(direction infinity of p))
    )
enddef;
