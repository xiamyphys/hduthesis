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
\def\hduthesis@date{2024/10/04}
\def\hduthesis@version{0.1.0}

\ExplSyntaxOn
\cs_new_protected_nopar:Npn \hduthesis_provide_module:n #1
  {
    \ProvidesExplFile{hduthesis-#1-module.code.tex}{\hduthesis@date}{\hduthesis@version}
    {HDUThesis~ \text_titlecase:n { #1 } ~Module}
  }
\ExplSyntaxOff

\PassOptionsToPackage{quiet}{xeCJK}
\PassOptionsToPackage{no-math}{fontspec}
\ProvidesExplClass{hduthesis}{\hduthesis@date}{\hduthesis@version}{HDU Thesis Class}

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

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[a4paper]{report}

\RequirePackage{siunitx, circuitikz, pgfplots, listings, lipsum, zhlipsum}
\pgfplotsset{compat = newest}

\cs_new_protected_nopar:Npn \int_if_exist_use:N #1
  {
    \int_compare:nNnT #1 > 0
    {
      \int_use:N #1
    }
  }

\keys_define:nn { hduthesis / docinfo }
  {
    title.tl_set:N = \l__docinfo_title_tl,
    school.tl_set:N = \l__docinfo_school_tl,
    major.tl_set:N = \l__docinfo_major_tl,
    class.tl_set:N = \l__docinfo_class_tl,
    stdntid.int_set:N = \l__docinfo_stdntid_int,
    author.tl_set:N = \l__docinfo_author_tl,
    supervisor.tl_set:N = \l__docinfo_supervisor_tl,
  }
\NewDocumentCommand \DocInfo { m }
{
  \keys_set:nn { hduthesis / docinfo } { #1 }
}

\hduthesis_load_module:n {font}
\hduthesis_load_module:n {cover}
\hduthesis_load_module:n {matter}
\hduthesis_load_module:n {layout}

\RequirePackage[
  backend = biber,
  citestyle = gb7714-2015,
  bibstyle = gb7714-2015,
]{biblatex}
\AddToHook{cmd/printbibliography/before}
{
  \group_begin:
  \AddToHook{cmd/@makeschapterhead/after}
  {
    \linespread{1.3}
  }
}
\AddToHook{cmd/printbibliography/after}
{
  \group_end:
}

\endinput

% End of file hduthesis.cls
