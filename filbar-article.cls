\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{filbar-article}[2025/02/26 v0.1 FilBar Article Class]

% Support for key-value options
\RequirePackage{xkeyval}

% Pass unknown options to scrartcl
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% Process options
\ProcessOptions\relax

% Set page size and layout
\PassOptionsToPackage{paper=a4,pagesize=auto}{typearea}

% Load the KOMA-Script class
\LoadClass[parskip=half,11pt]{scrartcl}

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

% Load the common styles
\RequirePackage{filbar-common}