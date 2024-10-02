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


\RequirePackage{geometry, fancyhdr, tikz, setspace}
\geometry
  {
    top = 3cm, bottom = 2cm, left = 4cm, right = 2cm,
    headheight = 15pt, headsep = .5cm
  }
\chead{\small 杭州电子科技大学本科毕业设计（论文）}
\lhead{}\rhead{}
\pagestyle{fancy}
\graphicspath
  {
    {./figure/}{./figures/}{./image/}{./images/}
    {./graphics/}{./graphic/}{./pictures/}{./picture/}
  }
\RequirePackage[labelsep = quad, font = small]{caption}
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
\AddToHook{env/figure/after}{\vspace*{-2.5ex}}

\hduthesis_load_module:n {font}
\hduthesis_load_module:n {cover}
\hduthesis_load_module:n {matter}
\hduthesis_load_module:n {chapter}

\endinput

% End of file hduthesis.cls