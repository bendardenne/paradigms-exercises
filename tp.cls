\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{tp} % Class information printed in the log during every compilation

\LoadClass[a4paper,10pt]{article} % Load the primary class with set options

\date{}


\usepackage{amsmath}
\usepackage{color}
\usepackage{fancybox}
\usepackage{hyperref}
\usepackage{indentfirst}
\usepackage{minted}
\usepackage{xspace}
\usepackage{todonotes}

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


\newcommand{\lang}[2]{\expandafter\def\csname#1\endcsname
	{\textsf{#2}\xspace}}

\lang{pascal}{Pascal}
\lang{scheme}{Scheme}
\lang{prolog}{Prolog}
\lang{C}{C}

% Minted config
\newmintinline[pascalcode]{pascal}{}
\newmintinline[schemecode]{scheme}{}

\endinput
