% Author: Mingyu Xia
% Homepage: 
% Email: xiamyphys@gmail.com
% Lastest Version: v0.0.1

% Powered by ElegantLaTeX Group
% --- Class structure: identification part
\ProvidesClass{HDUPaper}[2023/05/02 v0.10 HDULaTeX Paper class]
\NeedsTeXFormat{LaTeX2e}
%%%
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{setspace}
\RequirePackage{tikz}
\RequirePackage{fixdif}
\RequirePackage{physics2}
\usephysicsmodule{ab} % 不用qty啦！
\usephysicsmodule{ab.legacy}
\RequirePackage{url}
\RequirePackage{array}
\RequirePackage{afterpage}
\newcommand\myemptypage{\null\thispagestyle{empty}\addtocounter{page}{-1}\newpage}


\SetupKeyvalOptions{family=ELEGANT, prefix=ELEGANT@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{ELEGANT}{#1}}

\DeclareStringOption[cn]{lang}
\DeclareVoidOption{cn}{\ekv{lang=cn}}

\DeclareStringOption[cm]{math}

\DeclareStringOption[numeric-comp]{citestyle}
\DeclareStringOption[numeric]{bibstyle}

\DeclareStringOption[biber]{bibend}
\DeclareVoidOption{biber}{\ekv{bibend=biber}}
\DeclareVoidOption{bibtex}{\ekv{bibend=bibtex}}


\DeclareStringOption[ctexfont]{chinesefont}
\DeclareVoidOption{ctexfont}{\ekv{chinesefont=ctexfont}}
\DeclareVoidOption{founder}{\ekv{chinesefont=founder}}
\DeclareVoidOption{nofont}{\ekv{chinesefont=nofont}}

\DeclareVoidOption{mtpro2}{\ekv{math=mtpro2}}
\DeclareVoidOption{cm}{\ekv{math=cm}}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*\relax
\LoadClass{article}

\RequirePackage{hyperref}
\hypersetup{
  pdfborder={0 0 0},
  colorlinks=true,
  linkcolor={black},
  urlcolor={winered},
  filecolor={winered},
  citecolor={winered},
  linktoc=all,
}
% settings for the hyperref and geometry
\RequirePackage[a4paper,
  left=3cm,
  right=2cm,
  top=3cm,
  bottom=2cm,headheight=2cm,
  headsep=1cm]{geometry}

\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{indentfirst}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{multirow}
% \RequirePackage{linegoal}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\renewcommand{\thefigure}{\thesection-\arabic{figure}}
\RequirePackage{fancyvrb}
\RequirePackage{abstract}
\RequirePackage{hologo}

\RequirePackage{fancyhdr}
\newcommand{\fancyhc}[1]{\gdef\@fancyhc{#1}}
\fancypagestyle{plain}{\pagestyle{fancy}}
\pagestyle{fancy}
\fancyhead[c]{\@fancyhc}
\fancyhead[l]{}
\fancyhead[r]{}
\fancyfoot[c]{\thepage}

\linespread{1.35}
\graphicspath{{image/}{figure/}{fig/}{img/}}

% caption settings 
\RequirePackage[labelfont={bf}]{caption}
\captionsetup[table]{skip=3pt}
\captionsetup[figure]{skip=3pt}

% list/itemize/enumerate setting
\RequirePackage[shortlabels,inline]{enumitem}
\setlist{nolistsep}


% define the hyperref color 
\RequirePackage{xcolor}
\definecolor{winered}{rgb}{0.5,0,0}

\definecolor{lightgrey}{rgb}{0.95,0.95,0.95}
\definecolor{commentcolor}{RGB}{0,100,0}
\definecolor{frenchplum}{RGB}{190,20,83}


% add the email cmd 
\newcommand\email[1]{\href{mailto:#1}{\nolinkurl{#1}}}

% font settings


\PassOptionsToPackage{no-math}{fontspec}
\PassOptionsToPackage{quiet}{fontspec}
\RequirePackage{iftex}

\ifXeTeX
  \RequirePackage[no-math]{fontspec}
  \setmainfont{texgyretermes}[
    UprightFont = *-regular ,
    BoldFont = *-bold ,
    ItalicFont = *-italic ,
    BoldItalicFont = *-bolditalic ,
    Extension = .otf ,
    Scale = 1.0]
    
  \setsansfont{texgyreheros}[
    UprightFont = *-regular ,
    BoldFont = *-bold ,
    ItalicFont = *-italic ,
    BoldItalicFont = *-bolditalic ,
    Extension = .otf ,
    Scale = 0.9]
\else
  \RequirePackage{newtxtext}
  \RequirePackage[scaled=.90]{helvet}
\fi

\ifdefstring{\ELEGANT@lang}{cn}{
  \ifdefstring{\ELEGANT@chinesefont}{founder}{
    \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
    \setCJKmainfont[BoldFont={FZHei-B01},ItalicFont={FZKai-Z03}]{FZShuSong-Z01}
    \setCJKsansfont[BoldFont={FZHei-B01}]{FZKai-Z03}
    \setCJKmonofont[BoldFont={FZHei-B01}]{FZFangSong-Z02}
    \setCJKfamilyfont{zhsong}{FZShuSong-Z01}
    \setCJKfamilyfont{zhhei}{FZHei-B01}
    \setCJKfamilyfont{zhkai}[BoldFont={FZHei-B01}]{FZKai-Z03}
    \setCJKfamilyfont{zhfs}[BoldFont={FZHei-B01}]{FZFangSong-Z02}
    \newcommand*{\songti}{\CJKfamily{zhsong}}
    \newcommand*{\heiti}{\CJKfamily{zhhei}}
    \newcommand*{\kaishu}{\CJKfamily{zhkai}}
    \newcommand*{\fangsong}{\CJKfamily{zhfs}}}{\relax}
  
  \ifdefstring{\ELEGANT@chinesefont}{nofont}{
    \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}}{\relax}

  \ifdefstring{\ELEGANT@chinesefont}{ctexfont}{
    \RequirePackage[UTF8,scheme=plain]{ctex}}{\relax}
  
  \AfterEndPreamble{
    \setlength\parindent{2\ccwd}}
}{\relax}


\ifcsname kaishu\endcsname
  \newcommand{\citshape}{\kaishu}
\else
  \newcommand{\citshape}{\itshape}
\fi
\ifcsname kaishu\endcsname
  \newcommand{\cnormal}{\kaishu}
\else
  \newcommand{\cnormal}{\normalfont}
\fi

\ifcsname fangsong\endcsname
  \newcommand{\cfs}{\fangsong}
\else
  \newcommand{\cfs}{\normalfont}
\fi

\RequirePackage[
  backend=\ELEGANT@bibend,
  citestyle=\ELEGANT@citestyle,
  bibstyle=\ELEGANT@bibstyle]{biblatex}
\defbibheading{elegantbook}[\ebibname]{#1}
\counterwithin{table}{subsection}
\ExecuteBibliographyOptions{sorting=gb7714-2015}

\RequirePackage{appendix}

\theoremstyle{plain}% default
\newtheorem{theorem}{定理}[section] %
\newtheorem{lemma}[theorem]{引理} %
\newtheorem{proposition}[theorem]{命题} %
\newtheorem*{corollary}{推论} %
\theoremstyle{definition} %
\newtheorem{definition}{定义}[section] %
\newtheorem{conjecture}{猜想}[section] %
\newtheorem{example}{例}[section] %
\theoremstyle{remark} %
\newtheorem*{remark}{\normalfont\bfseries 评论} %
\newtheorem*{note}{\normalfont\bfseries 注} %
\newtheorem{case}{\normalfont\bfseries 案例} %
\renewcommand*{\proofname}{\normalfont\bfseries 证明} %
\renewcommand\contentsname{目录}
\renewcommand\refname{参考文献} %
\renewcommand\figurename{图} %
\renewcommand\tablename{表}%
\newcommand\versiontext{版本：}%
\newcommand\updatetext{日期：}%
\newcommand{\ebibname}{参考文献}
\renewcommand\abstractname{摘\hspace{2em}要}
\setlength\parindent{2\ccwd}
\renewcommand{\abstracttextfont}{\small\citshape\noindent\ignorespaces}
% 新定义命令
\newcommand{\keywords}[1]{\vskip2ex\par\noindent\normalfont{\bfseries 关键词: } #1}
\newcommand\figref[1]{{\bfseries 图~\ref{#1}}}
\newcommand\tabref[1]{{\bfseries 表~\ref{#1}}}
\renewcommand{\appendixtocname}{附录}
\renewcommand{\appendixpagename}{附录}

\def\bibfont{\footnotesize}

\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}}
\BeforeBeginEnvironment{tabular}{\small}
\AfterEndEnvironment{tabular}{}

\AtBeginDocument{
  % \setlength{\abovedisplayskip}{3pt}
  % \setlength{\belowdisplayskip}{3pt}
  \RequirePackage[flushmargin]{footmisc}
  \setlength{\footnotesep}{12pt}}
  \setlength{\abovecaptionskip}{1em}

\def\IfEmpty#1{%
  \edef\1{\the#1}
  \ifx\1\empty
}
\newtoks\version
\newtoks\institute
\newcommand{\grade}[1]{\gdef\@grade{#1}}
\newcommand{\school}[1]{\gdef\@school{#1}}
\newcommand{\major}[1]{\gdef\@major{#1}}
\newcommand{\id}[1]{\gdef\@id{#1}}
\newcommand{\name}[1]{\gdef\@name{#1}}
\newcommand{\teacher}[1]{\gdef\@teacher{#1}}
\renewcommand\maketitle{
  \begin{titlepage}
    \begin{spacing}{4.0}
    \begin{center}
      \includegraphics[width=0.64\textwidth]{hdulogo.png}
      \vskip+4ex

      \bfseries{\fontsize{40.0pt}{\baselineskip}本\qquad\quad 科\qquad\quad 课\qquad\quad 程\qquad\quad 设\qquad\quad 计}
      \vspace{2em}
      
      \bfseries{\huge \@grade}

      \vspace{4em}
      \begin{tabular}{cc}
        \Large 题\qquad 目 & \underline{\makebox[314pt]{\Large\citshape \@title}}\\
        \Large 学\qquad 院 & \underline{\makebox[314pt]{\Large\citshape \@school}}\\
        \Large 专\qquad 业 & \underline{\makebox[314pt]{\Large\citshape \@major}}\\
        \Large 学\qquad 号 & \underline{\makebox[314pt]{\Large\citshape \@id}}\\
        \Large 学生姓名 & \underline{\makebox[314pt]{\Large\citshape \@name}}\\
        \Large 任课教师 & \underline{\makebox[314pt]{\Large\citshape \@teacher}}
      \end{tabular}
    \end{center}
  \end{spacing}
  \end{titlepage}
  \myemptypage
}
  

\RequirePackage{listings}
\renewcommand{\ttdefault}{cmtt}

\lstdefinestyle{estyle}{
  basicstyle=%
    \ttfamily
    \lst@ifdisplaystyle\footnotesize\fi
}
\lstset{basicstyle=\scriptsize\ttfamily,style=estyle}

\lstset{language=[LaTeX]TeX,
	texcsstyle=*\color{winered},
	numbers=none,
	breaklines=true,
	keywordstyle=\color{winered},
	frame=tlbr,framesep=4pt,framerule=0pt,
	commentstyle=\color{commentcolor},
	emph={elegantpaper,fontenc,fontspec,xeCJK,FiraMono,xunicode,newtxmath,figure,fig,image,img,table,itemize,enumerate,newtxtext,newtxtt,ctex,microtype,description,times,newtx,booktabs,tabular,PDFLaTeX,XeLaTeX,type1cm,BibTeX,cite,gbt7714,lang},
	emphstyle={\color{frenchplum}},
	morekeywords={DeclareSymbolFont,SetSymbolFont,toprule,midrule,bottomrule,institute,version,includegraphics,setmainfont,setsansfont,setmonofont ,setCJKmainfont,setCJKsansfont,setCJKmonofont,RequirePackage,figref,tabref,email,maketitle,keywords,zhdate,zhtoday},
	tabsize=2,
	backgroundcolor=\color{lightgrey}
}

\addbibresource[location=local]{reference.bib}
% restore the tt default family to lmodern tt family
\renewcommand\ttdefault{lmtt}

\RequirePackage{fontawesome}