program Employee;

type booktype = (novel, comic);

type book = record
	title: string;

	case kind: booktype	of
		novel: (
			author: string;
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
theHobbit.pages := 320;

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

end.
