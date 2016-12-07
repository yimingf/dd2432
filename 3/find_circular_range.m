function [ range ] = find_circular_range( d, y, neighbor_size )
% find circular range for an array.
% for dd2432, lab 3, part 4

big         = mod(d + neighbor_size, y);
small       = mod(d - neighbor_size, y);
% determine the nominal range.

if (big < small)
    range   = [small : 1 : y];
    range   = [1 : 1 : big, range];
else
    range   = [small : 1 : big];
end

range(range==0) = y;
% replace zero values.

end

