\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{tp} % Class information printed in the log during every compilation

\LoadClass[a4paper,10pt]{article} % Load the primary class with set options




\usepackage{color}
\usepackage{fancybox}
\usepackage{hyperref}
\usepackage{indentfirst}

\newenvironment{instruction}%
{\vspace{15pt}
	\noindent\begin{Sbox}
		\begin{minipage}{\textwidth}}%
		{\end{minipage}
	\end{Sbox}	
\shadowbox{\TheSbox} \vspace{10pt}}

% Colors 
\definecolor{asmblue}{RGB}{0,0,90}
\definecolor{asmgreen}{RGB}{0,90,28}

% Commands
\newcommand{\asmop}[1]{{\sffamily \bfseries \color{asmblue} #1}}
\newcommand{\asmreg}[1]{{\sffamily \bfseries \color{asmgreen} #1}}



\endinput
