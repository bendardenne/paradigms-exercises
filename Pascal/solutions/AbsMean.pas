{*
	Copied from 
		Bruce J. Maclennan, Principles of Programming Languages, p.171
*}

program AbsMean (input, output);
	
	uses crt;

	const Max = 900;
	type index = 1 .. Max;

	(* Variable declarations *)
	var 
		N: 0 .. Max;
		Data: array[index] of real;
		sum, avg, val: real;
		i: index;
	
(* Main program block *)
begin
	sum := 0;
	readln(N);

	for i := 1 to N do
		begin
			readln(val);
			if val < 0 then Data[i] := -val
			else Data[i] := val
		end;

	for i := 1 to N do
		sum := sum + Data[i];
	
	avg := sum/N;
	writeln(avg);

	readkey();
end. 
