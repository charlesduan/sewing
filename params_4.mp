h.b = 2.25in;
h.f = 3.25in;
w.t = 3.75in;
w.b = 3.75in;
d = 1.75in;

% How far to pull downwards the curve for the eye, as a proportion of the
% distance of the eye seam.
eye_offset = 0.1;

% How close to put the eye cutout toward the nose; this is a number between
% 0 (away from the nose) and 1 (right by the nose).
eye_apex = 0.67;

% How far to pull outwards the curve for the nose, as a proportion of the
% nose-to-chin seam.
nose_offset = .15;

% How close to put the nose-to-chin outwards apex toward the nose; this is a
% number between 0 (right at the nose) and 1 (at the chin).
nose_apex = 0.67;

input mask
