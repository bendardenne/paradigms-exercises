program Employee;

type booktype = (novel, comic);

type book = record
	title: string;

	case kind: booktype	of
		novel: (
			author: string;
			ISBN: Int64;
		);
		comic: (
			writer: string;
			artist: string;
		)
end;


var
	theHobbit: book;
	luckyLuke: book;	

begin 
	
theHobbit.title := 'The Hobbit, or There and Back Again';
theHobbit.author := 'J. R. R. Tolkien';
theHobbit.ISBN := 9780007525492;

luckyLuke.kind := comic;
luckyLuke.title := 'Billy the Kid';
luckyLuke.writer := 'Goscinny';
luckyLuke.artist := 'Morris';


{* Tests *}
writeln(theHobbit.kind);
writeln(theHobbit.author);
writeln(theHobbit.writer);
writeln(theHobbit.artist);

writeln(luckyLuke.kind);	
writeln(luckyLuke.author);

luckyLuke.author := 'Did I break Pascal yet?';
writeln(luckyLuke.author);
writeln(luckyLuke.writer);


theHobbit.ISBN := 31084784824439585;

writeln(theHobbit.ISBN);
writeln(theHobbit.artist);

end.
