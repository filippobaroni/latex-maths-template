\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{filbar-thesis}

% Support for key-value options
\RequirePackage{xkeyval}

% Fancy chapter headings
\newif\if@filbar@fancychapters
\DeclareOption{fancychapters}{\@filbar@fancychapterstrue}

% Pass unknown options to scrartcl
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

% Process options
\ProcessOptions\relax

% Set page size and layout
\PassOptionsToPackage{paper=a4,pagesize=auto}{typearea}

% Load the KOMA-Script class
\LoadClass[12pt,headings=chapterwithprefix]{scrbook}

% SECTIONS
% Customise the section headings
% We want the last number in the section/subsection number to be coloured.
% The default formatting looks like this:
% \newcommand*{\sectionformat}{\thesection\autodot\enskip}
% In turn, \thesection is defined as:
% \expandafter \ifnum \scr@v@is@gt {2.97d}\if@mainmatter \thechapter .\fi \else \thechapter .\fi \@arabic \c@section
\renewcommand*{\sectionformat}{\if@mainmatter \thechapter .\fi 
\textcolor{filbar theme color}{\@arabic \c@section}\autodot\enskip}
% The default definition for \thesubsection is:
% \thesection .\@arabic \c@subsection
\renewcommand*{\subsectionformat}{\thesection .\textcolor{filbar theme color}{\@arabic\c@subsection}\autodot\enskip}

% HEADERS AND FOOTERS
% Load scrlayer-scrpage
\RequirePackage{scrlayer-scrpage}
% Plain page style with no headings
\pagestyle{plain.scrheadings}

% LOAD the common styles
\RequirePackage{filbar-common}

% SPACING
% Increase spacing between lines
\RequirePackage{setspaceenhanced}
\spacesetup{onehalfspacing}

% CHAPTERS
% We have some very fancy chapter headings.
\if@filbar@fancychapters
\setkomafont{chapterprefix}{\mdseries}
\RenewDocumentCommand{\chapterformat}{}{%
\tikz\pic{filbar@chapter heading={\textcolor{black!60}{{\LARGE\chapappifchapterprefix {\hspace{1em}}}}\textbf{\textcolor{filbar theme color}{\thechapter \autodot}}}};%
}
\RenewDocumentCommand{\chapterlineswithprefixformat}{mmm}{
\begin{center}
#2#3
\end{center}
}
% Define the decoration
\tikzset{
filbar@chapter heading/.pic={
    \def\targetsep{2.5pt}
    \def\height{1em}
    \node[inner ysep=.4em,inner xsep=2em] (text) {#1};
    \tikzmath{
        coordinate \p;
        integer \n,\i;
        \p=($(text.north east)-(text.north west)$);
        \n=\px/\targetsep;
        \sep=\px/\n;
    }
    \foreach \anchor/\yscale in {north west/1,south west/-1} {
        \tikzmath{
            for \i in {0,...,\n} {
                \h{\i}=rnd;
            };
            for \j in {1,2,3} {
                for \i in {1,...,\n-1} {
                    \ii=int(\i-1);
                    \iii=int(\i+1);
                    \newh{\i}=.8*\h{\i}+.1*(\h{\ii}+\h{\iii});
                };
                for \i in {1,...,\n-1} {
                    \h{\i}=\newh{\i};
                };
            };
            for \i in {0,...,\n} {
                \h{\i}=\h{\i}*(1-cos(\i/\n*360))/2;
            };
        }
        \foreach \i[evaluate=\i as \x using {\i*\sep}] in {0,...,\n} {
            \tikzmath{
                \c=int(max(1,random(int(\h{\i}*8))));
                integer \j,\jj;
                \q{0}=0;
                for \j in {1,...,\c} {
                    \jj=\j-1;
                    \q{\j}=\q{\jj}+rnd+\c*.5;
                };
                for \j in {1,...,\c} {
                    \q{\j}=\h{\i}*\q{\j}/\q{\c};
                };
            }
            \draw[yscale=\yscale,line cap=round,line width=1.25pt] \foreach \j [parse=true,evaluate=\j as \jj using {int(\j-1)},evaluate=\j as \col using {\j==1?int(50*(1-cos(\i/\n*360))):random(100)}] in {1,...,\c} {
                ($(text.\anchor)+(\x pt,\q{\jj}*\height)$) edge[filbar theme color!\col] ($(text.\anchor)+(\x pt,{\q{\j}*\height-(\j<\c)*2.5pt})$)
            };
        }
    }
    \path[use as bounding box] ([yshift=\height]text.north west) rectangle ([yshift=-\height]text.south east);
    }
}
\fi