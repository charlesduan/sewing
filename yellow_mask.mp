%
% This is based on the yellow polka dot mask, Oct. 12, 2020.
%
h.b = 2in;
h.f = 3.75in;
w.t = 3.5in;
w.b = 4.25in;
d = 1.25in;

% How far to pull downwards the curve for the eye, as a proportion of the
% distance of the eye seam.
eye_offset = 0.5/4;

% How close to put the eye cutout toward the nose; this is a number between
% 0 (away from the nose) and 1 (right by the nose).
eye_apex = 0.5;

% How far to pull outwards the curve for the nose, as a proportion of the
% nose-to-chin seam.
nose_offset = 0.85/5;

% How close to put the nose-to-chin outwards apex toward the nose; this is a
% number between 0 (right at the nose) and 1 (at the chin).
nose_apex = 0.5;

input mask;

