%% ***********************************************************
%%   Copyright 2024 by M.Y. XIA <xiamyphys@gmail.com>        *
%%                                                           *
%%   This work may be distributed and/or modified under      *
%%   the conditions of the LaTeX Project Public License      *
%%                                                           *
%%       http://www.latex-project.org/lppl.txt               *
%%                                                           *
%%   either version 1.3c of this license or any later        *
%%   version.                                                *
%%                                                           *
%%   This work has the LPPL maintenance status `maintained'. *
%%                                                           *
%%   The Current Maintainers of this work is M.Y. XIA        *
%%                                                           *
%%   This work consists of the files hduthesis.cls,          *
%%                               and README.md.              *
%%   available at https://github.com/xiamyphys/hduthesis     *
%% ***********************************************************
\RequirePackage{xparse}% For TeX Live 2019 - 2020 Compatibility
\PassOptionsToPackage{quiet}{xeCJK}
\ProvidesExplClass{hduthesis}{2024/10/02}{0.2A}{HDU Thesis Class}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[a4paper]{report}

\cs_new_protected:Npn \hduthesis_msg_new:nn #1#2 
  { \msg_new:nnn { hduthesis } { #1 } { #2 } }
\cs_new_protected:Npn \hduthesis_msg_error:nn #1#2
  { \msg_error:nnn { hduthesis } { #1 } { #2 } }
\cs_generate_variant:Nn \hduthesis_msg_error:nn { nx }
\hduthesis_msg_new:nn { not found module }
  {
    The~hduthesis~module~`#1'~not~found.
  }
\cs_new_protected_nopar:Npn \hduthesis_load_module:n #1 
  {
    \clist_map_inline:nn { #1 }
    {
      \file_if_exist_input:nF { hduthesis-##1-module.code.tex }
      {
        \hduthesis_msg_error:nn { not found module } { ##1 }
      }
    }
  }

\RequirePackage[zihao = -4]{ctex}
\linespread{1.4}
\setlength{\parindent}{2\ccwd}
\RequirePackage{geometry, fancyhdr, tikz, setspace}
\geometry
  {
    top = 3cm, bottom = 2cm, left = 4cm, right = 2cm,
    headheight = 15pt, headsep = .5cm
  }
\chead{\small 杭州电子科技大学本科毕业设计（论文）}
\pagestyle{fancy}
\graphicspath
  {
    {./figure/}{./figures/}{./image/}{./images/}
    {./graphics/}{./graphic/}{./pictures/}{./picture/}
  }
\setmainfont{texgyretermes}
  [
    UprightFont = *-regular,
    BoldFont = *-bold,
    ItalicFont = *-italic,
    BoldItalicFont = *-bolditalic,
    Extension = .otf,
    Scale = 1.0
  ]
\setsansfont{texgyreheros}
  [
    UprightFont = *-regular,
    BoldFont = *-bold,
    ItalicFont = *-italic,
    BoldItalicFont = *-bolditalic,
    Extension = .otf,
    Scale = 0.9
  ]

\hduthesis_load_module:n {cover}

\tl_new:N \l__abstract_name_tl
\RenewDocumentEnvironment {abstract} { O{en} }
  {
    \str_if_eq:nnT {#1} {en}
    {
      \tl_set:Nn \l__keywords_name_tl {Key~words:~}
      \tl_set:Nn \l__keywords_sep_tl {;~}
    }
    \str_if_eq:nnT {#1} {cn}
    {
      \tl_set:Nn \l__keywords_name_tl {\textsf{关键词：}}
      \tl_set:Nn \l__keywords_sep_tl {；}
    }
    \vspace*{-.65\baselineskip}
    \@beginparpenalty\@lowpenalty
    \begin{center}%
      \bfseries\large
        \str_if_eq:nnT {#1} {en} {ABSTRACT}
        \str_if_eq:nnT {#1} {cn} {\textsf{摘\qquad 要}}
      \@endparpenalty\@M
    \end{center}%
    \vspace*{.75\baselineskip}
    \group_begin:
    \setstretch{1.38}
  }
  {
    \par\null
    \group_end:
    \tl_clear:N \l__abstract_name_tl
    \clearpage
  }

\clist_new:N \l__abstract_keywords_clist
\NewDocumentCommand \keywords { m }
  {
    \vspace*{1.1\baselineskip}
    \noindent\textbf{\l__keywords_name_tl}
    \clist_set:Nn \l__abstract_keywords_clist {#1}
    \clist_use:Nn \l__abstract_keywords_clist {\l__keywords_sep_tl}
  }

\newcommand\frontmatter{%
    \cleardoublepage
  %\@mainmatterfalse
  \pagenumbering{roman}}

\newcommand\mainmatter{%
    \cleardoublepage
 % \@mainmattertrue
  \pagenumbering{arabic}}

\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
 % \@mainmatterfalse
   }

\renewcommand \contentsname{\large\hfill 目\qquad 录\hfill}