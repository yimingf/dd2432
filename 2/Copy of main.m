% 3.2
% That should be n, if we have fewer approx n-N weights will be just random.
%   It will become 0, since the weigths will match up to fit the given data exact (put probably not data outside the given set)
%   When n=N
%   No, see the case when n=N, the error will probably become 0, but it might be far from optimalr for the general case

% 4.1
%  sin(2x):
	units = 5 => max(res) ~= 1.12, bad approx
	units = 6 => max(res) ~= 0.1, rather good approx
	units = 15 => max(res) ~=0.01
	units = 55 => max(res) ~= 0.001
	units = 60 => max(res) ~= 0.0001

% 	The function has 6 local maximas so to approximate it we need at least one unit for each maxima

 square(2x)
	units = 60 => max(res) ~= 0.1, rather good approx
	units >= 63 gives max(res) < 1e-16 !

 * Classification (it's actually just on/off)


 One can get max(res)=0 for sin(2x) by transposing x (that is, instead of 64 1-dimensional patterns we get 1 64-dimensional input.
 for units = 5 we get res=0. 

 * One can solve XOR with RBF by putting one node at each 0-point (that is, at (0, 0) and (1, 1)). This will make the output from the rbf linary separable.

4.2
 n = 0.1
 * I found that varing the numebr of iterations from 2000 to 7000 didn't to very much, the big difference was in units. 
	 units = 10 gives an acceptable result  max(res) ~=0.42. 20 => 0.1
	 To get down to 0.01 i changed n to 0.3 and use 12000 iterations and 50 units, and i still was only close (0.03)
* x^2: Worked well, it had problems with fitting correct at the endpoint

5.1
 * Only the nodes closest (the winners) to the dataclusters moved at all. This makes some nodes totaly irrelevant (they will never trigger)
 * You get one and only one node at each cluster (given that number of clusters < number of nodes)

--
 * with single winner one or more nodes tend to get large or very of. With all units allowed to move they spread out quite good over the data clusters, but run to long they often don't cover all data points.

 !!!! EM WAS BROKEN (wrong axes)
 * I don't have time