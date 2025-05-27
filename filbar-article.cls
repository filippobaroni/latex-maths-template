\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{filbar-article}[2025/02/26 v0.1 FilBar Article Class]

% Support for key-value options
\RequirePackage{xkeyval}

% Pass unknown options to scrartcl
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% Process options
\ProcessOptions\relax

% Set page size and layout - part I
\PassOptionsToPackage{paper=a4,pagesize=auto,usegeometry}{typearea}

% Load the KOMA-Script class
\LoadClass[parskip=half,11pt]{scrartcl}

% Set page size and layout - part II
\RequirePackage{geometry}
\geometry{footskip=2.5em,top=1.2in,bottom=1.5in,includefoot}

% The abstract is, internally, just a quotation environment.
% Since we are using parskip instead of intendation, we want to use the quote environment instead, which matches the spacing of the rest of the document.
% We redefine the abstract environment to use the quote environment instead.
\BeforeBeginEnvironment{abstract}{\bgroup\let\quotation\quote}
\AfterEndEnvironment{abstract}{\egroup}

% HEADERS AND FOOTERS
% Load scrlayer-scrpage
\RequirePackage{scrlayer-scrpage}
% Plain page style with no headings
\pagestyle{plain.scrheadings}

% LOAD the common styles
\RequirePackage{filbar-common}

% SPACING
% Micromanaging spacing for theorems and proofs
% This removes extra spacing above and below all theorems.
% It's a very low-level hack (directly into amsthm), and it
% probably invalidates attempts to change the spacing from a
% higher level (e.g. thmtools)
\def\thm@space@setup{
    \thm@preskip=0pt plus 2pt
    \thm@postskip=0pt
}
% Hard-coded spacing for proof environment. I don't really understand where
% the numbers come from, ideally I would find precise numbers in the definitions,
% but for now this works.
\AtBeginEnvironment{proof}{
  \setlength{\partopsep}{.9pt plus 1pt}
  \vspace*{-\parskip}
}
\AtEndEnvironment{proof}{
  \vspace*{-\parskip}
}

% Reduce spacing before paragraphs
\RedeclareSectionCommand[beforeskip=0pt plus 1ex]{paragraph}