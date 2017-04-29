%% tenth.cls
%% Author: Abhabongse Janthong
%
% This document class provides preloaded most common packages and most common
% configurations of the document according to my own taste.
%
% It is released under MIT License because the author thinks that the
% LaTeX Project Public License is annoying and life is complicated.
\NeedsTeXFormat{LaTeX2e}[2016/02/01]
\ProvidesClass{tenth}[2017/04/28 v0.1.1 (Abhabongse Janthong)]

%%------------------------------------------------------------------
%%  Very important utility package
%%------------------------------------------------------------------
\RequirePackage{etoolbox}

%%------------------------------------------------------------------
%%  Define and process variables and options for this document
%%  class. This has to be done before base class is loaded.
%%------------------------------------------------------------------
\newbool{istwoside}  % whether 'twoside' option is loaded (default: false)
\DeclareOption{twoside}{%
    \booltrue{istwoside}%
    \PassOptionsToClass{twoside}{article}}

\newbool{isthai}  % whether the document is written in Thai
\DeclareOption{thai}{%
    \booltrue{isthai}}

\newbool{istypistdisabled}  % whether Thai Typist font should be disabled
\DeclareOption{notypist}{%
    \booltrue{istypistdisabled}}

\newbool{issansthai}  % whether use sans serif as default for Thai only
\DeclareOption{sansthai}{%
    \booltrue{issansthai}}

\newbool{isthmsec}  % whether theorem env will have section numbering
\DeclareOption{thmsec}{%
    \booltrue{isthmsec}}

%%  Pass along all other options not captured above
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%%  Now load the base class
\LoadClass{article}

%%------------------------------------------------------------------
%%  Setup paper margin and marginnote command.
%%------------------------------------------------------------------
\RequirePackage[%
    top=1in,bottom=1in,outer=1.75in,inner=1in,heightrounded,%
    marginparwidth=1.25in, marginparsep=1pc]{geometry}

%%------------------------------------------------------------------
%%  Setup marginnote command.
%%------------------------------------------------------------------
\RequirePackage{marginnote}
% \newrobustcmd{\marginnote}[1]{\marginpar{%
%     \ifnumodd{\thepage}%
%         {\flushleft #1}%
%         {\ifbool{istwoside}{\flushright #1}{\flushleft #1}}}}

%%------------------------------------------------------------------
%%  Setup constant lengths for parts of document.
%%------------------------------------------------------------------
\RequirePackage{setspace}
\setstretch{1.2}
\setlength{\headheight}{27.5pt}
\setlength{\parskip}{0pc}
\setlength{\parindent}{2pc}

%%------------------------------------------------------------------
%%  Setup font families (including for math)
%%------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage{libertine}
\RequirePackage[varqu,varl]{inconsolata}
%% Include math fonts.
\RequirePackage{amsthm}
\RequirePackage[libertine]{newtxmath}
% \RequirePackage{lib­ert­i­nust1­math}

%% Setup font names
\newrobustcmd{\linuxlib}{LinuxLibertineT-TLF}
\newrobustcmd{\linuxbio}{LinuxBiolinumT-TLF}
\newrobustcmd{\inconsol}{zi4}

%% Setup Thai fonts is 'thai' option is specified.
\ifbool{isthai}{%
    \RequirePackage[thai]{babel}%
    \RequirePackage[utf8x]{inputenc}%
    \RequirePackage[rmnorasi,sflaksaman]{fonts-tlwg}%
    \renewcommand{\baselinestretch}{1.5}
    \renewrobustcmd{\englishrmdefault}{\linuxlib}%
    \renewrobustcmd{\englishsfdefault}{\linuxbio}%
    \renewrobustcmd{\englishttdefault}{\inconsol}%
    \ifbool{issansthai}{%
        \renewrobustcmd{\thaifamilydefault}{\thaisfdefault}}{}%
    \ifbool{istypistdisabled}{%
        \renewrobustcmd{\thaittdefault}{\inconsol}
        \renewrobustcmd{\ttfamily}{%
            \fontencoding{\latinencoding}%
            \fontfamily{\ttdefault}%
            \selectfont}}{}}{}

%% TODO: use relsize to control the scale of Thai fonts

%%------------------------------------------------------------------
%%  Load 'microtype' which is the best package ever
%%------------------------------------------------------------------
\RequirePackage[%
    activate={true,nocompatibility},final,tracking=true,letterspace=100,%
    kerning=true,spacing=true,factor=1150,stretch=15,shrink=15]{microtype}
\microtypecontext{spacing=nonfrench}
\SetExtraKerning[unit=space]%
    {encoding={*},family={\linuxlib},series={*},%
        size={footnotesize,small,normalsize}}%
    {\textendash={600,600},      % en-dash, add more space around it
     \textemdash={600,600},      % en-dash, add more space around it
     "28={,150},                 % left bracket, add space from right
     "29={150,},                 % right bracket, add space from left
     \textquotedblleft={,150},   % left quotation mark, space from right
     \textquotedblright={150,}}  % right quotation mark, space from left

%%------------------------------------------------------------------
%%  Setup color choices
%%------------------------------------------------------------------
\RequirePackage[dvipsnames,svgnames,table,fixpdftex,hyperref]{xcolor}
\definecolor{DarkGray}{gray}{0.25}
\definecolor{Gray}{gray}{0.5}
\definecolor{LightGray}{gray}{0.65}
\definecolor{VeryLightGray}{gray}{0.9}
\definecolor{GrayBG}{gray}{0.9}
\definecolor{LightGrayBG}{gray}{0.935}
\definecolor{VeryLightGrayBG}{gray}{0.97}

% Color settings for mdframed
\definecolor{ShadeColor}{gray}{0.935}
\definecolor{BorderColor}{gray}{0.785}

% Commands for colored squares
\newrobustcmd{\colorsq}[1]{{%
    \hspace{0.1pc}\color{#1}\rule[-0.02pc]{0.6pc}{0.6pc}\hspace{0.1pc}}}
\newrobustcmd{\redsq}{\colorsq{red}}
\newrobustcmd{\greensq}{\colorsq{green}}
\newrobustcmd{\bluesq}{\colorsq{blue}}

%%------------------------------------------------------------------
%%  Setup math equations and symbols
%%------------------------------------------------------------------
\RequirePackage{amsmath, amssymb, amsfonts}
\RequirePackage{mathtools}
\RequirePackage{chemarrow}
\RequirePackage{fdsymbol}  % nicer looking standard symbols
\renewrobustcmd{\qedsymbol}{$\blacksquare$}

%%------------------------------------------------------------------
%%  Setup mdframed environment
%%------------------------------------------------------------------
\RequirePackage{mdframed}
\mdfdefinestyle{standard}{%
    backgroundcolor=ShadeColor,linecolor=BorderColor,%
    innertopmargin=0pc,skipabove=0.25pc,skipbelow=0.25pc}
\mdfdefinestyle{codebox}{%
    innertopmargin=0pc,skipabove=0.75pc}

% \DeclareDocumentCommand\newmdtheoremenv*{O{} m o m o }{%
%     \ifboolexpr{ test {\IfNoValueTF {#3}} and test {\IfNoValueTF {#5}} }%
%     {\newtheorem{#2}{#4}}{%
%         \IfValueTF{#3}{\newtheorem*{#2}[#3]{#4}}{}%
%         \IfValueTF{#5}{\newtheorem*{#2}{#4}[#5]}{}%
%     }%
%     \BeforeBeginEnvironment{#2}{%
%         \begin{mdframed}[#1]}%
%     \AfterEndEnvironment{#2}{%
%         \end{mdframed}}%
% }

%%------------------------------------------------------------------
%%  Setup math theorem environments
%%------------------------------------------------------------------
\theoremstyle{plain}
    \ifbool{isthmsec}{%
        \newmdtheoremenv[style=standard]{theorem}{Theorem}[section]}%
    {%else
        \newmdtheoremenv[style=standard]{theorem}{Theorem}}
    \newmdtheoremenv[style=standard]{lemma}[theorem]{Lemma}
    \newmdtheoremenv[style=standard]{proposition}[theorem]{Proposition}
    \newmdtheoremenv[style=standard]{corollary}[theorem]{Corollary}
    \newmdtheoremenv[style=standard]{claim}[theorem]{Claim}
    \newmdtheoremenv[style=standard]{conjecture}[theorem]{Conjecture}

\theoremstyle{definition}
    \newmdtheoremenv[style=standard]{definition}[theorem]{Definition}
    \newmdtheoremenv[style=standard]{fact}[theorem]{Fact}
    \newmdtheoremenv[style=standard]{example}[theorem]{Example}
    \newmdtheoremenv[style=standard]{question}[theorem]{Question}
    \newmdtheoremenv[style=standard]{problem}[theorem]{Problem}

\theoremstyle{remark}
    \newtheorem*{remark}{Remark}
    \renewcommand{\endremark}{\hfill$\Diamond$\endtrivlist}
    \newtheorem*{note}{Note}
    \newtheorem*{hint}{Hint}


% %% Include this package to be able to insert .eps file
% \RequirePackage[pdftex]{graphicx}
%
% %% Include this package to use more symbols
% \RequirePackage{textcomp}
%
% %% Include this package to customize item numbers
% %\RequirePackage{enumerate}
% \RequirePackage{enumitem}
% \RequirePackage{alphalph}
% \setlist[enumerate,1]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[itemize,1]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[description,1]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=-2em}
% \setlist[enumerate,2]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[itemize,2]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[description,2]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=-2em}
% \setlist[enumerate,3]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[itemize,3]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[description,3]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=-2em}
% \setlist[enumerate,4]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[itemize,4]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=0em}
% \setlist[description,4]{topsep=1em, partopsep=0em, parsep=0em, itemsep=1em, listparindent=2em, itemindent=-2em}
%
% %% Extra enumerate labels
% \makeatletter
% \newcommand*{\single@thai}[1]{%
%   \expandafter\@single@thai\csname c@#1\endcsname%
% }
% \newcommand*{\@single@thai}[1]{%
%   \ifcase#1\orก\orข\orค\orฆ\orง\orจ\orฉ\orช\orซ\orฌ\orญ\orฎ\orฏ\orฐ\orฑ\orฒ\orณ\orด\orต\orถ\orท\orธ\orน\orบ\orป\orผ\orฝ\orพ\orฟ\orภ\orม\orย\orร\orล\orว\orศ\orษ\orส\orห\orฬ\orอ\orฮ\else\@ctrerr\fi%
% }
% \newalphalph{\@thai}[alph]{\@single@thai}{24}
% \newcommand*{\thai}[1]{%
%   \expandafter\@thai\csname c@#1\endcsname%
% }
% \AddEnumerateCounter{\thai}{\@thai}{ณ}
%
%
% %% Include this package for professional table style
% \RequirePackage{array, booktabs}
%
% %% Include this package for different styles of a figure
% \RequirePackage[margin=1em, font={footnotesize,sf}, labelfont=bf, labelsep=period, format=plain, indention=1em, justification=justified]{caption}
% \RequirePackage{subcaption}
% % \DeclareCaptionFormat{llap}{\llap{#1#2}#3\par}
% % \captionsetup{format=llap,labelsep=quad,singlelinecheck=no}
%
% %% Include this package for formatting the date and time
% \RequirePackage{datetime}
%
% %% Include this package to allow verbatim input
% \RequirePackage{fancyvrb}
%
% %% Include this package to include beautiful pseudocode
% \RequirePackage{clrscode3e}
%
% %% Include the code formatter.
% \RequirePackage{listings}
% \lstset{
%   % Basic Settings
%   basicstyle=\footnotesize\ttfamily,
%   captionpos=b,
%   % Margins and Background
%   xleftmargin=3em,
%   xrightmargin=1em,
%   rulesep=1em,
%   framextopmargin=5em,
%   framexbottommargin=5em,
%   framexleftmargin=1em,
%   framexrightmargin=1em,
%   backgroundcolor=\color{LightGrayBackground},
%   % Spacing and Horizontal Flow
%   showspaces=false,
%   showstringspaces=false,
%   showtabs=false,
%   tabsize=2,
%   breaklines=true,
%   columns=fullflexible,
%   keepspaces=true,
%   % Vertical Flow
%   aboveskip=\bigskipamount,
%   belowskip=\bigskipamount,
%   lineskip=0.00001pt,
%   % Line Numbers
%   stepnumber=1,
%   numbers=left,
%   numbersep=2em,
%   numberstyle=\ttfamily\color{Gray},
%   % Special Keyword Format
%   stringstyle=\color{Maroon},
%   keywordstyle=\color{NavyBlue},
%   keywordstyle={[2]\color{teal}},
%   commentstyle=\color{ForestGreen},
%   extendedchars=true
%  }
% \lstdefinelanguage{pseudocode}{
%     morekeywords={,if,then,else,while,do,end,loop,until,for,to,downto,return,print,def},
%     morekeywords={[2],true,false},
%     sensitive=false,
%     morestring=[b]",
%     morecomment=[l]{//},
%   }
%
% %% Include this package for a fancy header
% \RequirePackage{fancyhdr}
% \RequirePackage{lastpage}
% % Reset the header and footer
% \pagestyle{fancy}
% \fancyhead{} % clear all header fields
% \fancyhead[L]{\sffamily\small \topleft \\ \bottomleft}
% \fancyhead[R]{\sffamily\small \topright \\ \bottomright}
% \fancyhead[C]{}
% \fancyfoot{} % clear all footer fields
% \fancyfoot[L]{}
% \fancyfoot[R]{\sffamily\small \thepage}
% \fancyfoot[C]{}
% \renewcommand{\headrulewidth}{0pt}
% \renewcommand{\footrulewidth}{0pt}
% \setlength{\parskip}{0pt}
% \setlength{\parindent}{2em}
%
% %% Set the title, author, and date
% \title{}
% \author{}
% \date{}
%
% %% Spaces
% \DeclareRobustCommand{\HairSp}{\ifmmode\mskip1mu\else\kern0.0625em\fi}
%
% %% Mathematical symbol
% \DeclareRobustCommand{\Algebraic}{\mathbb{A}}
% \DeclareRobustCommand{\Complex}{\mathbb{C}}
% \DeclareRobustCommand{\Field}{\mathbb{F}}
% \DeclareRobustCommand{\N}{\mathbb{N}}
% \DeclareRobustCommand{\Q}{\mathbb{Q}}
% \DeclareRobustCommand{\R}{\mathbb{R}}
% \DeclareRobustCommand{\Z}{\mathbb{Z}}
%
% \DeclareRobustCommand{\ol}[1]{\overline{#1}}
%
% \DeclareRobustCommand{\hl}[1]{\mathchoice%
%   {\colorbox{Goldenrod!30}{\color{black}$\displaystyle#1$}}%
%   {\colorbox{Goldenrod!30}{\color{black}$\textstyle#1$}}%
%   {\colorbox{Goldenrod!30}{\color{black}$\scriptstyle#1$}}%
%   {\colorbox{Goldenrod!30}{\color{black}$\scriptscriptstyle#1$}}}
% \DeclareRobustCommand{\bhl}[1]{\mathchoice%
%   {\colorbox{LimeGreen!30}{\color{black}$\displaystyle#1$}}%
%   {\colorbox{LimeGreen!30}{\color{black}$\textstyle#1$}}%
%   {\colorbox{LimeGreen!30}{\color{black}$\scriptstyle#1$}}%
%   {\colorbox{LimeGreen!30}{\color{black}$\scriptscriptstyle#1$}}}
% \DeclareRobustCommand{\grayed}[1]{\mathchoice%
%   {\colorbox{VeryLightGrayBackground}{\color{Gray}$\displaystyle#1$}}%
%   {\colorbox{VeryLightGrayBackground}{\color{Gray}$\textstyle#1$}}%
%   {\colorbox{VeryLightGrayBackground}{\color{Gray}$\scriptstyle#1$}}%
%   {\colorbox{VeryLightGrayBackground}{\color{Gray}$\scriptscriptstyle#1$}}}
%
% \DeclareRobustCommand{\colorsq}[1]{{\color{#1}\rule{0.625em}{0.625em}}}
% \DeclareRobustCommand{\redsq}{\colorsq{red}}
% \DeclareRobustCommand{\greensq}{\colorsq{green}}
% \DeclareRobustCommand{\bluesq}{\colorsq{blue}}
%
% %% Drawings
% \RequirePackage{tikz}
% \RequirePackage[usenames,dvipsnames]{pstricks}
% \RequirePackage{epsfig,pst-grad,pst-plot}
% \usetikzlibrary{positioning}
%
% %% Unfinished tag
% \DeclareRobustCommand{\unfinished}{\colorbox{red}{\sffamily\bfseries\color{white}unfinished}}
%
% %% Include this package to allow cross-reference hyperlink
% %% PEOPLE SAY THIS SHOULD BE ADDED LAST
% \RequirePackage[bookmarks=true,pdftex]{hyperref}