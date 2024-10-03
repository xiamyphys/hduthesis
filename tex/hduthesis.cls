%% ****************************************************************
%%        Copyright 2024 by M.Y. XIA <xiamyphys@gmail.com>        *
%%                                                                *
%%   This work may be distributed and/or modified under the       *
%%   conditions of the LaTeX Project Public License               *
%%                                                                *
%%             http://www.latex-project.org/lppl.txt              *
%%                                                                *
%%   either version 1.3c of this license or any later version.    *
%%                                                                *
%%   This work has the LPPL maintenance status `maintained'.      *
%%                                                                *
%%   The Current Maintainers of this work is M.Y. XIA             *
%%                                                                *
%%   This work consists of the files hduthesis.cls,               *
%%                                   hduthesis-font-module.code,  *
%%                                   hduthesis-cover-module.code, *
%%                                   hduthesis-matter-module.code,*
%%                                   hduthesis-layout-module.code,*
%%                               and README.md.                   *
%%   available at https://github.com/xiamyphys/hduthesis          *
%% ****************************************************************
\RequirePackage{xparse}% For TeX Live 2019 - 2020 Compatibility
\PassOptionsToPackage{quiet}{xeCJK}
\PassOptionsToPackage{no-math}{fontspec}
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

\RequirePackage{siunitx, circuitikz, pgfplots, lipsum, zhlipsum}
\pgfplotsset{compat = newest}

\hduthesis_load_module:n {font}
\hduthesis_load_module:n {cover}
\hduthesis_load_module:n {matter}
\hduthesis_load_module:n {layout}

\RequirePackage[
  backend = biber,
  citestyle = gb7714-2015,
  bibstyle = gb7714-2015,
  ]{biblatex}

\endinput

% End of file hduthesis.cls
