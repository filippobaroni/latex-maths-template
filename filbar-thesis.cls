\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{filbar-thesis}

% Support for key-value options
\RequirePackage{xkeyval}

% Pass unknown options to scrartcl
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

% Process options
\ProcessOptions\relax

% Set page size and layout
\PassOptionsToPackage{paper=a4,pagesize=auto,usegeometry}{typearea}

% Load the KOMA-Script class
\LoadClass[12pt]{scrbook}

% Set page size and layout - part II
\RequirePackage{geometry}
\geometry{footskip=2em}

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

% THEOREM NUMBERING
% Number theorems within chapters
\def\filbar@numbertheoremswithin{chapter}

% LOAD the common styles
\RequirePackage{filbar-common}

% SPACING
% Increase spacing between lines
\RequirePackage{setspaceenhanced}
\spacesetup{onehalfspacing}