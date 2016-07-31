program Collatz;


function f(n: Int64) : Int64;
begin
	if n mod 2 = 0 then
		n := n div 2
	else
		n := 3 * n + 1;
	
	f := n;
end;


function collatz(n: Int64) : Int64;
begin
	write(n, ' ');
	if n = 1 then
		writeln()
	else 
		collatz := collatz(f(n));
end;



var
	n : Int64;

begin 
	writeln('Input a positive integer:');
	readln(n);

  	{* Recursive solution *}
	collatz(n);


	{* Iterative solution *}
	while n <> 1 do
	begin 
		write(n, ' ');
		n := f(n);
	end;

	writeln(n);
end.

